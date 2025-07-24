import 'package:flutter/material.dart';
import '../cores.dart';
import 'senhaAleatoria.dart'; // onde está o SenhaAleatoriaPopup
import '../generated/l10n.dart';

Future<void> showEditarSenhaDialog({
  required BuildContext context,
  required String nomeInicial,
  required String senhaInicial,
  required void Function(String novoNome, String novaSenha) onConfirmar,
}) async {
  final nomeController = TextEditingController(text: nomeInicial);
  final senhaController = TextEditingController(text: senhaInicial);

  await showDialog(
    context: context,
    barrierDismissible: true,
      builder: (context) {
        final s = S.of(context); // ← Traduções carregadas aqui

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          insetPadding: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(s.editPasswordTitle, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: s.passwordNameLabel),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: senhaController,
                  decoration: InputDecoration(labelText: s.passwordLabel),
                ),
                const SizedBox(height: 12),
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
                Row(
                  children: [
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
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secundaria,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          final novoNome = nomeController.text.trim();
                          final novaSenha = senhaController.text.trim();
                          if (novoNome.isNotEmpty && novaSenha.isNotEmpty) {
                            onConfirmar(novoNome, novaSenha);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(s.confirmButtonText, style: TextStyle(color: Colors.white)),
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