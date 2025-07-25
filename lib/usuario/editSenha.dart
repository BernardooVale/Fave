import 'package:flutter/material.dart';
import '../cores.dart';
import 'senhaAleatoria.dart';
import '../generated/l10n.dart';

/// Exibe um diálogo para editar uma senha, permitindo modificar o nome e a senha.
/// Também permite gerar uma senha aleatória via modal bottom sheet.
///
/// [nomeInicial] e [senhaInicial] são os valores iniciais exibidos nos campos.
/// [onConfirmar] é chamado quando o usuário confirma, passando os novos valores.
Future<void> showEditarSenhaDialog({
  required BuildContext context,
  required String nomeInicial,
  required String senhaInicial,
  required void Function(String novoNome, String novaSenha) onConfirmar,
}) async {
  // Controladores para os campos de texto, inicializados com os valores recebidos
  final nomeController = TextEditingController(text: nomeInicial);
  final senhaController = TextEditingController(text: senhaInicial);

  await showDialog(
      context: context,
      barrierDismissible: true, // Permite fechar o diálogo ao tocar fora dele
      builder: (context) {
        final s = S.of(context);

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Título do diálogo
                Text(s.editPasswordTitle, style: Theme.of(context).textTheme.titleLarge),

                const SizedBox(height: 16),

                // Campo para editar o nome da senha
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: s.passwordNameLabel),
                ),

                const SizedBox(height: 16),

                // Campo para editar a senha em si
                TextField(
                  controller: senhaController,
                  decoration: InputDecoration(labelText: s.passwordLabel),
                ),

                const SizedBox(height: 12),

                // Link para abrir o popup de geração de senha aleatória
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColors.fundo,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (ctx) => SenhaAleatoriaPopup(
                          onSenhaGerada: (senha) => senhaController.text = senha,
                        ),
                      );
                    },
                    child: Text(
                      s.randomPasswordText,
                      style: TextStyle(
                        color: AppColors.mel,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Botões Cancelar e Confirmar alinhados horizontalmente
                Row(
                  children: [
                    // Botão Cancelar: fecha o diálogo sem salvar alterações
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.terciaria,
                          side: BorderSide(color: AppColors.terciaria),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(s.cancelButtonText),
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Botão Confirmar: valida campos e executa callback com novos valores
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secundaria,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          final novoNome = nomeController.text.trim();
                          final novaSenha = senhaController.text.trim();

                          // Só confirma se ambos os campos estiverem preenchidos
                          if (novoNome.isNotEmpty && novaSenha.isNotEmpty) {
                            onConfirmar(novoNome, novaSenha);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(s.confirmButtonText, style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
  );
}