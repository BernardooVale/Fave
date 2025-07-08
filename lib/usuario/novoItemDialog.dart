import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../usuario/usuario.dart';
import '../ed.dart'; // Pasta e Senha

Future<void> showAddOptionDialog({
  required BuildContext context,
  required Box<Usuario> userBox,
  required dynamic target, // Usuario ou Pasta
  required VoidCallback onUpdate,
}) async {
  final option = await showDialog<String>(
    context: context,
    builder: (context) => SimpleDialog(
      title: const Text('O que deseja criar?'),
      children: [
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 'pasta'),
          child: const Text('Criar Pasta'),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, 'senha'),
          child: const Text('Criar Senha'),
        ),
        SimpleDialogOption(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancelar'),
        ),
      ],
    ),
  );

  if (option == 'pasta') {
    await showCreateFolderSheet(
      context: context,
      userBox: userBox,
      target: target,
      onUpdate: onUpdate,
    );
  } else if (option == 'senha') {
    await showCreatePasswordSheet(
      context: context,
      userBox: userBox,
      target: target,
      onUpdate: onUpdate,
    );
  }
}

Future<void> addFolder({
  required Box<Usuario> userBox,
  required dynamic target, // Usuario ou Pasta
  required String nome,
  required VoidCallback onUpdate,
}) async {
  final novaPasta = Pasta(
    nome: nome,
    senhas: [],
    subpastas: [],
    ultimaModificacao: DateTime.now(),
  );

  if (target is Usuario) {
    target.pastas ??= [];
    target.pastas!.add(novaPasta);
  } else if (target is Pasta) {
    target.subpastas ??= [];
    target.subpastas!.add(novaPasta);
  } else {
    throw Exception('target deve ser Usuario ou Pasta');
  }

  // Atualiza no Hive
  await userBox.putAt(0, userBox.values.first);
  onUpdate();
}

Future<void> addPassword({
  required Box<Usuario> userBox,
  required dynamic target, // Usuario ou Pasta
  required String nome,
  required String senha,
  required VoidCallback onUpdate,
}) async {
  final novaSenha = Senha(
    nome: nome,
    senha: senha,
    ultimaModificacao: DateTime.now(),
  );

  if (target is Usuario) {
    target.senhas ??= [];
    target.senhas!.add(novaSenha);
  } else if (target is Pasta) {
    target.senhas ??= [];
    target.senhas!.add(novaSenha);
  } else {
    throw Exception('target deve ser Usuario ou Pasta');
  }

  // Atualiza no Hive
  await userBox.putAt(0, userBox.values.first);
  onUpdate();
}

Future<void> showCreateFolderSheet({
  required BuildContext context,
  required Box<Usuario> userBox,
  required dynamic target,
  required VoidCallback onUpdate,
}) async {
  final nomeController = TextEditingController();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Wrap(
        children: [
          Text('Nova Pasta', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          TextField(
            controller: nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome da pasta',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () async {
                final nome = nomeController.text.trim();
                if (nome.isEmpty) return;

                await addFolder(
                  userBox: userBox,
                  target: target,
                  nome: nome,
                  onUpdate: onUpdate,
                );

                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}

Future<void> showCreatePasswordSheet({
  required BuildContext context,
  required Box<Usuario> userBox,
  required dynamic target,
  required VoidCallback onUpdate,
}) async {
  final nomeController = TextEditingController();
  final senhaController = TextEditingController();

  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Wrap(
        children: [
          Text('Nova Senha', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          TextField(
            controller: nomeController,
            decoration: const InputDecoration(
              labelText: 'Nome da senha',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: senhaController,
            decoration: const InputDecoration(
              labelText: 'Senha',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              child: const Text('Salvar'),
              onPressed: () async {
                final nome = nomeController.text.trim();
                final senha = senhaController.text.trim();
                if (nome.isEmpty || senha.isEmpty) return;

                await addPassword(
                  userBox: userBox,
                  target: target,
                  nome: nome,
                  senha: senha,
                  onUpdate: onUpdate,
                );

                Navigator.pop(context);
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}