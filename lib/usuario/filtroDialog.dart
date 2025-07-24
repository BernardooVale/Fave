import 'package:flutter/material.dart';

import '../cores.dart';
import '../notificacao/notificacao.dart';

import '../generated/l10n.dart';

class filtroDialog extends StatefulWidget {
  final Set<String> tiposAtuais; // ex: {'pastas', 'senhas', 'documentos'}

  const filtroDialog({Key? key, required this.tiposAtuais}) : super(key: key);

  @override
  State<filtroDialog> createState() => _filtroDialogState();
}

class _filtroDialogState extends State<filtroDialog> {
  late Set<String> selecionados;

  @override
  void initState() {
    super.initState();
    selecionados = Set.from(widget.tiposAtuais);
  }

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

    final s = S.of(context);

    return AlertDialog(
      title: Text(s.filterByTypesTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: Text(s.foldersFilterLabel),
            value: selecionados.contains('pastas'),
            onChanged: (_) => _toggleTipo('pastas'),
          ),
          CheckboxListTile(
            title: Text(s.passwordsFilterLabel),
            value: selecionados.contains('senhas'),
            onChanged: (_) => _toggleTipo('senhas'),
          ),
          CheckboxListTile(
            title: Text(s.documentsFilterLabel),
            value: selecionados.contains('documentos'),
            onChanged: (_) => _toggleTipo('documentos'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: Text(
              s.cancelButtonText,
              style: TextStyle(
                color: AppColors.terciaria
              ),
          ),
        ),
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
                color: selecionados.isEmpty ? Colors.grey : AppColors.mel
              ),
          ),
        ),
      ],
    );
  }
}
