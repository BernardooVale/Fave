import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

import 'ed.dart';

final _secure = const FlutterSecureStorage();

/// Classe que agrupa as caixas Hive de um usuário.
class UserCofre {
  final Box<Pasta> pastas;
  final Box<Senha> senhas;
  final Box<Documento> documentos;
  final Box<List<dynamic>> fotos; // List<Uint8List> mas Hive prefere List<dynamic> ou Uint8List diretamente

  UserCofre({
    required this.pastas,
    required this.senhas,
    required this.documentos,
    required this.fotos,
  });

  Future<void> close() async {
    await pastas.close();
    await senhas.close();
    await documentos.close();
    await fotos.close();
  }
}

// Gera ou recupera a chave AES-256 para esse usuário
Future<Uint8List> getKeyForUser(String userId) async {
  const androidOpts = AndroidOptions(encryptedSharedPreferences: true);
  final keyName = 'hive_key_$userId';
  final stored = await _secure.read(key: keyName, aOptions: androidOpts);

  if (stored != null) {
    return base64Url.decode(stored);
  }

  final key = Hive.generateSecureKey(); // AES-256
  await _secure.write(
    key: keyName,
    value: base64UrlEncode(key),
    aOptions: androidOpts,
  );
  return Uint8List.fromList(key);
}

/// Abre as 4 caixas criptografadas do usuário.
Future<UserCofre> openUserCofre(String userId) async {
  final key = await getKeyForUser(userId);
  final cipher = HiveAesCipher(key);

  final pastas = await Hive.openBox<Pasta>(
    'pastas_$userId',
    encryptionCipher: cipher,
  );
  final senhas = await Hive.openBox<Senha>(
    'senhas_$userId',
    encryptionCipher: cipher,
  );
  final documentos = await Hive.openBox<Documento>(
    'documentos_$userId',
    encryptionCipher: cipher,
  );
  final fotos = await Hive.openBox<List<dynamic>>(
    'fotos_$userId',
    encryptionCipher: cipher,
  );

  return UserCofre(
    pastas: pastas,
    senhas: senhas,
    documentos: documentos,
    fotos: fotos,
  );
}

// Abre caixa criptografada legado (para migração)
Future<Box<Usuario>> openLegacyUserBox(String userId) async {
  final key = await getKeyForUser(userId);
  return Hive.openBox<Usuario>(
    'user_$userId',
    encryptionCipher: HiveAesCipher(key),
  );
}
