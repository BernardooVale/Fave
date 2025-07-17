import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../cores.dart';
import '../ed.dart';
import '../cofre.dart';
import '../notificacao/notificacao.dart';

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
            const Text('Novo Usuário', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                  icon: Icon(Icons.close_rounded, color: cs.tertiary),
                  tooltip: 'Limpar',
                  onPressed: () => Navigator.of(context).pop(),
                ),
                IconButton(
                  iconSize: 28,
                  icon: Icon(Icons.check_rounded, color: cs.secondary),
                  tooltip: 'Confirmar',
                  onPressed: () async {
                    final userName = controller.text.trim();

                    if (userName.isEmpty || controller.text.isEmpty) {
                      mostrarNotificacao(
                        context: context,
                        mensagem: 'Digite um nome',
                        background: AppColors.terciaria,
                      );
                      return;
                    }

                    if (usuariosBox.containsKey(userName)) {
                      mostrarNotificacao(
                        context: context,
                        mensagem: 'Perfil já existe',
                        background: AppColors.terciaria,
                      );
                      return;
                    }

                    mostrarNotificacao(
                        context: context,
                        mensagem: "Perfil cadastrado",
                        background: AppColors.secundaria
                    );

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