import 'package:flutter/material.dart';
import '../cores.dart';
import '../ed.dart';
import '../cofre.dart';
import '../itens/item.dart';
import '../generated/l10n.dart';

/// Função genérica para deletar múltiplos itens selecionados.
/// Realiza exclusão recursiva para pastas.
Future<void> deletarSelecionadosGenerico({
  required BuildContext context,
  required UserCofre cofre,
  required Set<Item> selecionados,
}) async {
  final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        final s = S.of(context);

        return AlertDialog(
          title: Text(s.confirmarExclusaoItems),
          content: Text(s.deleteItemsConfirm(selecionados.length)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(s.cancelButtonText),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(s.excluir, style: TextStyle(color: AppColors.terciaria)),
            ),
          ],
        );
      }
  );

  if (confirm != true) return;

  for (final item in selecionados) {
    if (item.tipo == 'pasta') {
      await _deletarPastaRecursivo(item.pasta!, cofre);
    } else if (item.tipo == 'senha') {
      await cofre.senhas.delete(item.senha!.id);
    } else if (item.tipo == 'documento') {
      await cofre.documentos.delete(item.documento!.id);
      await cofre.fotos.delete(item.documento!.id);
    }
  }
}

/// Remove uma pasta e todos os seus subitens recursivamente.
Future<void> _deletarPastaRecursivo(Pasta pasta, UserCofre cofre) async {
  // Busca e remove subpastas
  final subpastas = cofre.pastas.values
      .where((p) => p.parentPastaId == pasta.id)
      .toList();
  for (final sub in subpastas) {
    await _deletarPastaRecursivo(sub, cofre);
  }

  // Busca e remove senhas
  final senhasIds = cofre.senhas.values
      .where((s) => s.parentPastaId == pasta.id)
      .map((s) => s.id)
      .toList();
  for (final id in senhasIds) {
    await cofre.senhas.delete(id);
  }

  // Busca e remove documentos (e suas fotos)
  final documentosIds = cofre.documentos.values
      .where((d) => d.parentPastaId == pasta.id)
      .map((d) => d.id)
      .toList();
  for (final id in documentosIds) {
    await cofre.documentos.delete(id);
    await cofre.fotos.delete(id);
  }

  // Remove a própria pasta
  await cofre.pastas.delete(pasta.id);
}
