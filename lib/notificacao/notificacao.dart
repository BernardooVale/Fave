import 'package:flutter/material.dart';

/// Exibe uma notificação temporária animada na parte superior da tela.
///
/// [context]: contexto atual.
/// [mensagem]: texto a ser exibido.
/// [background]: cor de fundo da notificação.
/// [duracao]: tempo de exibição antes do fade-out.
void mostrarNotificacao({
  required BuildContext context,
  required String mensagem,
  required Color background,
  Duration duracao = const Duration(seconds: 2),
}) {
  final overlay = Overlay.of(context);

  // Cria a entry que será exibida por cima da interface.
  final overlayEntry = OverlayEntry(
    builder: (context) => _NotificacaoAnimada(
      mensagem: mensagem,
      background: background,
      duracao: duracao,
    ),
  );

  // Insere a notificação na tela.
  overlay.insert(overlayEntry);

  // Aguarda a duração + tempo de animação e remove do overlay.
  Future.delayed(duracao + const Duration(milliseconds: 400), () {
    overlayEntry.remove();
  });
}

/// Widget interno e animado que representa a notificação.
class _NotificacaoAnimada extends StatefulWidget {
  final String mensagem;
  final Color background;
  final Duration duracao;

  const _NotificacaoAnimada({
    required this.mensagem,
    required this.background,
    required this.duracao,
  });

  @override
  State<_NotificacaoAnimada> createState() => _NotificacaoAnimadaState();
}

class _NotificacaoAnimadaState extends State<_NotificacaoAnimada> {
  double _opacity = 0.0; // Opacidade inicial (invisível)

  @override
  void initState() {
    super.initState();

    // Animação de fade in logo após a construção do widget
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Após a duração desejada, inicia o fade out
    Future.delayed(widget.duracao, () {
      setState(() {
        _opacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define a posição do topo levando em conta a status bar e AppBar
    final top = MediaQuery.of(context).padding.top + kToolbarHeight;

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 400), // Tempo de transição
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: widget.background,
              borderRadius: BorderRadius.zero, // Pode ser personalizado futuramente
            ),
            child: Text(
              widget.mensagem,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}