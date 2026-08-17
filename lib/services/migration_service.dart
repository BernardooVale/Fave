import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';
import '../ed.dart';
import '../cofre.dart';
import 'dart:typed_data';

class MigrationService {
  static const String _migrationPrefix = 'migration_done_';

  static Future<bool> needsMigration(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool('$_migrationPrefix$userId') ?? false);
  }

  static Future<void> migrateUser(String userId) async {
    if (!(await needsMigration(userId))) return;

    final legacyBoxName = 'user_$userId';
    if (!await Hive.boxExists(legacyBoxName)) {
      // Se a caixa legado não existe, marca como feito e sai
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('$_migrationPrefix$userId', true);
      return;
    }

    final legacyBox = await openLegacyUserBox(userId);
    if (legacyBox.isEmpty) {
      await legacyBox.close();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('$_migrationPrefix$userId', true);
      return;
    }

    final usuario = legacyBox.values.first;
    final cofre = await openUserCofre(userId);

    try {
      // Processar recursivamente
      if (usuario.pastas != null) {
        for (var pasta in usuario.pastas!) {
          await _migratePasta(pasta, null, cofre);
        }
      }
      if (usuario.senhas != null) {
        for (var senha in usuario.senhas!) {
          senha.parentPastaId = null;
          await cofre.senhas.put(senha.id, senha);
        }
      }
      if (usuario.documentos != null) {
        for (var doc in usuario.documentos!) {
          doc.parentPastaId = null;
          await _migrateDocumento(doc, cofre);
        }
      }

      // Confirmar sucesso
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('$_migrationPrefix$userId', true);

      // Fechar e deletar legado
      await legacyBox.close();
      await Hive.deleteBoxFromDisk(legacyBoxName);
    } catch (e) {
      // Em caso de erro, fechamos as novas boxes para não deixar lixo inconsistente
      // mas mantemos a flag de migração como false
      await cofre.close();
      await legacyBox.close();
      rethrow;
    }
  }

  static Future<void> _migratePasta(Pasta pasta, String? parentId, UserCofre cofre) async {
    pasta.parentPastaId = parentId;
    
    // Processar subitens antes de limpar listas (embora limpar não seja estritamente necessário se não salvarmos a pasta de volta na box legado)
    if (pasta.subpastas != null) {
      for (var sub in pasta.subpastas!) {
        await _migratePasta(sub, pasta.id, cofre);
      }
    }
    if (pasta.senhas != null) {
      for (var senha in pasta.senhas!) {
        senha.parentPastaId = pasta.id;
        await cofre.senhas.put(senha.id, senha);
      }
    }
    if (pasta.documentos != null) {
      for (var doc in pasta.documentos!) {
        doc.parentPastaId = pasta.id;
        await _migrateDocumento(doc, cofre);
      }
    }

    // Salvar pasta na nova box (sem as listas legadas)
    await cofre.pastas.put(pasta.id, pasta);
  }

  static Future<void> _migrateDocumento(Documento doc, UserCofre cofre) async {
    // Se houver fotos, move para a box de fotos
    if (doc.fotosCriptografadas != null && doc.fotosCriptografadas!.isNotEmpty) {
      await cofre.fotos.put(doc.id, doc.fotosCriptografadas!);
      // Limpa no objeto para não ocupar espaço na box de documentos
      doc.fotosCriptografadas = null;
    }
    await cofre.documentos.put(doc.id, doc);
  }
}
