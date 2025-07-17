import 'package:flutter/material.dart';

import '../cores.dart';
import '../notificacao/notificacao.dart';

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
    return AlertDialog(
      title: const Text('Filtrar por tipos'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckboxListTile(
            title: const Text('Pastas'),
            value: selecionados.contains('pastas'),
            onChanged: (_) => _toggleTipo('pastas'),
          ),
          CheckboxListTile(
            title: const Text('Senhas'),
            value: selecionados.contains('senhas'),
            onChanged: (_) => _toggleTipo('senhas'),
          ),
          CheckboxListTile(
            title: const Text('Documentos'),
            value: selecionados.contains('documentos'),
            onChanged: (_) => _toggleTipo('documentos'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(null),
          child: const Text(
              'Cancelar',
              style: TextStyle(
                color: AppColors.terciaria
              ),
          ),
        ),
        TextButton(
          onPressed: selecionados.isEmpty
              ? () => mostrarNotificacao(
                  context: context,
                  mensagem: 'Selecione algum item',
                  background: AppColors.terciaria,
                )
              : () => Navigator.of(context).pop(selecionados),
          child: Text(
              'Aplicar',
              style: TextStyle(
                color: selecionados.isEmpty ? Colors.grey : AppColors.mel
              ),
          ),
        ),
      ],
    );
  }
}
