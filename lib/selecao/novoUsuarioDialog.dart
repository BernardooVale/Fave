import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../cores.dart';
import '../ed.dart';
import '../cofre.dart';
import '../notificacao/notificacao.dart';
import '../generated/l10n.dart';

/// Mostra um diálogo para criação de um novo usuário (perfil).
///
/// [context]: Contexto da interface atual.
/// [usuariosBox]: Caixa Hive contendo os perfis de usuário existentes.
/// [onUsuarioCriado]: Callback executado após o novo usuário ser criado.
Future<void> showAddUserDialog({
  required BuildContext context,
  required Box<Usuario> usuariosBox,
  required VoidCallback onUsuarioCriado,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      final s = S.of(context); // Traduções locais
      final cs = Theme.of(context).colorScheme; // Cores do tema
      final controller = TextEditingController(); // Controlador do campo de texto

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título
              Text(s.novoPerfil, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

              // Campo de texto para nome do perfil
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: s.digiteNomePerfil,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.6)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.withOpacity(0.6)),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Botões de ação: cancelar e confirmar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botão cancelar
                  IconButton(
                    iconSize: 28,
                    icon: Icon(Icons.close_rounded, color: cs.tertiary),
                    tooltip: s.limpar,
                    onPressed: () => Navigator.of(context).pop(),
                  ),

                  // Botão confirmar
                  IconButton(
                    iconSize: 28,
                    icon: Icon(Icons.check_rounded, color: cs.secondary),
                    tooltip: s.confirmButtonText,
                    onPressed: () async {
                      final userName = controller.text.trim();

                      // Validação: nome vazio
                      if (userName.isEmpty || controller.text.isEmpty) {
                        mostrarNotificacao(
                          context: context,
                          mensagem: s.digiteumNome,
                          background: AppColors.terciaria,
                        );
                        return;
                      }

                      // Validação: nome já existe
                      if (usuariosBox.containsKey(userName)) {
                        mostrarNotificacao(
                          context: context,
                          mensagem: s.perfilExiste,
                          background: AppColors.terciaria,
                        );
                        return;
                      }

                      // Confirmação: novo perfil criado
                      mostrarNotificacao(
                        context: context,
                        mensagem: s.perfilCadastrado,
                        background: AppColors.secundaria,
                      );

                      // Cria e abre uma nova caixa criptografada para o usuário
                      await openEncryptedUserBox(userName);

                      // Adiciona o novo usuário à caixa principal
                      await usuariosBox.put(userName, Usuario(nome: userName));

                      // Inicializa a caixa do usuário com um registro se estiver vazia
                      final userBox = Hive.box<Usuario>('user_$userName');
                      await (userBox.isEmpty
                          ? userBox.add(Usuario(nome: userName))
                          : userBox.putAt(0, Usuario(nome: userName)));

                      // Fecha o diálogo e executa o callback
                      Navigator.of(context).pop();
                      onUsuarioCriado();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}