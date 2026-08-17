import 'package:autenticacao/services/migration_service.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cores.dart';
import '../ed.dart';
import '../cofre.dart';
import '../notificacao/notificacao.dart';
import '../generated/l10n.dart';

/// Mostra um diálogo para criação de um novo usuário (perfil).
Future<void> showAddUserDialog({
  required BuildContext context,
  required Box<Usuario> usuariosBox,
  required VoidCallback onUsuarioCriado,
}) async {
  await showDialog(
    context: context,
    builder: (context) {
      final s = S.of(context);
      final cs = Theme.of(context).colorScheme;
      final controller = TextEditingController();

      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(s.novoPerfil, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),

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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    iconSize: 28,
                    icon: Icon(Icons.close_rounded, color: cs.tertiary),
                    tooltip: s.limpar,
                    onPressed: () => Navigator.of(context).pop(),
                  ),

                  IconButton(
                    iconSize: 28,
                    icon: Icon(Icons.check_rounded, color: cs.secondary),
                    tooltip: s.confirmButtonText,
                    onPressed: () async {
                      final userName = controller.text.trim();

                      if (userName.isEmpty) {
                        mostrarNotificacao(
                          context: context,
                          mensagem: s.digiteumNome,
                          background: AppColors.terciaria,
                        );
                        return;
                      }

                      if (usuariosBox.containsKey(userName)) {
                        mostrarNotificacao(
                          context: context,
                          mensagem: s.perfilExiste,
                          background: AppColors.terciaria,
                        );
                        return;
                      }

                      mostrarNotificacao(
                        context: context,
                        mensagem: s.perfilCadastrado,
                        background: AppColors.secundaria,
                      );

                      // Marca migração como concluída para novos usuários
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('migration_done_$userName', true);

                      // Abre as novas caixas do usuário
                      await openUserCofre(userName);

                      // Adiciona o novo usuário à caixa principal de perfis
                      await usuariosBox.put(userName, Usuario(nome: userName));

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
