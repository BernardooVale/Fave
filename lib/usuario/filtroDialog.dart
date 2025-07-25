import 'package:flutter/material.dart';

import '../cores.dart';
import '../notificacao/notificacao.dart';
import '../generated/l10n.dart';

/// Diálogo que permite ao usuário filtrar por tipos de item: pastas, senhas e documentos.
/// Recebe o conjunto inicial de tipos selecionados via [tiposAtuais].
class filtroDialog extends StatefulWidget {
  final Set<String> tiposAtuais; // Exemplo: {'pastas', 'senhas', 'documentos'}

  const filtroDialog({Key? key, required this.tiposAtuais}) : super(key: key);

  @override
  State<filtroDialog> createState() => _filtroDialogState();
}

class _filtroDialogState extends State<filtroDialog> {
  late Set<String> selecionados;

  @override
  void initState() {
    super.initState();
    // Inicializa o estado local com uma cópia dos tipos atualmente selecionados
    selecionados = Set.from(widget.tiposAtuais);
  }

  /// Alterna a seleção do tipo passado por parâmetro
  void _toggleTipo(String tipo) {
    setState(() {
      if (selecionados.contains(tipo)) {
        selecionados.remove(tipo);
      } else {
        selecionados.add(tipo);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context); // Strings localizadas

    return AlertDialog(
      title: Text(s.filterByTypesTitle), // Título do diálogo

      content: Column(
        mainAxisSize: MainAxisSize.min, // Ajusta o tamanho da coluna ao conteúdo
        children: [
          // Checkbox para filtro "Pastas"
          CheckboxListTile(
            title: Text(s.foldersFilterLabel),
            value: selecionados.contains('pastas'),
            onChanged: (_) => _toggleTipo('pastas'),
          ),
          // Checkbox para filtro "Senhas"
          CheckboxListTile(
            title: Text(s.passwordsFilterLabel),
            value: selecionados.contains('senhas'),
            onChanged: (_) => _toggleTipo('senhas'),
          ),
          // Checkbox para filtro "Documentos"
          CheckboxListTile(
            title: Text(s.documentsFilterLabel),
            value: selecionados.contains('documentos'),
            onChanged: (_) => _toggleTipo('documentos'),
          ),
        ],
      ),

      actions: [
        // Botão Cancelar: fecha o diálogo e retorna null (nenhuma alteração)
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(
            s.cancelButtonText,
            style: TextStyle(color: AppColors.terciaria),
          ),
        ),

        // Botão Aplicar: se nenhum filtro estiver selecionado,
        // mostra uma notificação; senão fecha e retorna os selecionados
        TextButton(
          onPressed: selecionados.isEmpty
              ? () => mostrarNotificacao(
            context: context,
            mensagem: s.selectAnItemNotification,
            background: AppColors.terciaria,
          )
              : () => Navigator.of(context).pop(selecionados),
          child: Text(
            s.applyButtonText,
            style: TextStyle(
              color: selecionados.isEmpty ? Colors.grey : AppColors.mel,
            ),
          ),
        ),
      ],
    );
  }
}