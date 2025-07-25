import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../ed.dart';
import '../itens/item.dart';
import '../generated/l10n.dart';

/// Função genérica para deletar múltiplos itens selecionados de um [Usuario] ou uma [Pasta].
/// Mostra um diálogo de confirmação e, se confirmado, remove os itens e atualiza o Hive.
Future<void> deletarSelecionadosGenerico({
  required BuildContext context,
  required dynamic target, // Pode ser Usuario ou Pasta
  required Box<Usuario> userBox,
  required Set<Item> selecionados,
}) async {
  // Exibe diálogo de confirmação
  final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        final s = S.of(context); // Traduções

        return AlertDialog(
          title: Text(s.confirmarExclusaoItems),
          content: Text(s.deleteItemsConfirm(selecionados.length)), // Exibe número de itens
          actions: [
            // Botão cancelar
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(s.cancelButtonText),
            ),
            // Botão excluir
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(s.excluir, style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      }
  );

  if (confirm != true) return; // Usuário cancelou

  // Remoção dos itens selecionados com base no tipo do target
  if (target is Usuario) {
    // Filtra os itens que *não* estão na seleção e atualiza listas
    target.pastas = target.pastas
        ?.where((p) => !selecionados.contains(Item.pasta(p)))
        .toList();
    target.senhas = target.senhas
        ?.where((s) => !selecionados.contains(Item.senha(s)))
        .toList();
    target.documentos = target.documentos
        ?.where((s) => !selecionados.contains(Item.documento(s)))
        .toList();
  } else if (target is Pasta) {
    target.subpastas = target.subpastas
        ?.where((p) => !selecionados.contains(Item.pasta(p)))
        .toList();
    target.senhas = target.senhas
        ?.where((s) => !selecionados.contains(Item.senha(s)))
        .toList();
    target.documentos = target.documentos
        ?.where((s) => !selecionados.contains(Item.documento(s)))
        .toList();
  } else {
    // Caso seja passado um tipo inesperado, lança exceção
    throw Exception('Tipo de target não suportado: ${target.runtimeType}');
  }

  // Atualiza o Hive com os dados modificados do usuário
  await userBox.putAt(0, userBox.values.first);
}