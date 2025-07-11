import 'package:flutter/material.dart';
import '../cores.dart';
import 'senhaAleatoria.dart'; // onde está o SenhaAleatoriaPopup

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
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: const EdgeInsets.all(24),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Editar Senha', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome da Senha'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: senhaController,
              decoration: const InputDecoration(labelText: 'Senha'),
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
                  'Senha aleatória',
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
                    child: const Text('Cancelar'),
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
                    child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}