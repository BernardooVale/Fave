import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../ed.dart';
import '../itens/item.dart';
import '../generated/l10n.dart';

Future<void> deletarSelecionadosGenerico({
  required BuildContext context,
  required dynamic target, // Usuario ou Pasta
  required Box<Usuario> userBox,
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
            child: Text(s.excluir, style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    }
  );

  if (confirm != true) return; // Usuário cancelou

  if (target is Usuario) {
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
    throw Exception('Tipo de target não suportado: ${target.runtimeType}');
  }

  await userBox.putAt(0, userBox.values.first);
}