import 'package:autenticacao/cores.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../ed.dart';
import '../cofre.dart';

Future<void> showAddUserDialog({
  required BuildContext context,
  required Box<Usuario> usuariosBox,
  required VoidCallback onUsuarioCriado,
}) async {
  final cs = Theme.of(context).colorScheme;
  final controller = TextEditingController();

  await showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Novo Usuário', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                  iconSize: 28,
                  icon: Icon(Icons.close, color: AppColors.mel),
                  tooltip: 'Fechar',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Digite o nome do usuário',
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.4))),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.withOpacity(0.6))),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 28,
                  icon: Icon(Icons.delete, color: cs.tertiary),
                  tooltip: 'Limpar',
                  onPressed: () => controller.clear(),
                ),
                IconButton(
                  iconSize: 28,
                  icon: Icon(Icons.check, color: cs.secondary),
                  tooltip: 'Confirmar',
                  onPressed: () async {
                    final userName = controller.text.trim();
                    if (userName.isEmpty) return;

                    if (usuariosBox.containsKey(userName)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Usuário já existe!')),
                      );
                      return;
                    }

                    await openEncryptedUserBox(userName);
                    await usuariosBox.put(userName, Usuario(nome: userName));

                    final userBox = Hive.box<Usuario>('user_$userName');
                    await (userBox.isEmpty
                        ? userBox.add(Usuario(nome: userName))
                        : userBox.putAt(0, Usuario(nome: userName)));

                    Navigator.of(context).pop();
                    onUsuarioCriado(); // chama setState() no widget pai
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}