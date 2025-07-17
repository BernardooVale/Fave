import 'package:flutter/material.dart';

void mostrarNotificacao({
  required BuildContext context,
  required String mensagem,
  required Color background,
  Duration duracao = const Duration(seconds: 2),
}) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) => _NotificacaoAnimada(
      mensagem: mensagem,
      background: background,
      duracao: duracao,
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(duracao + const Duration(milliseconds: 400), () {
    overlayEntry.remove();
  });
}

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
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Fade in
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Fade out
    Future.delayed(widget.duracao, () {
      setState(() {
        _opacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top + kToolbarHeight;

    return Positioned(
      top: top,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 400),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              color: widget.background,
              borderRadius: BorderRadius.zero,

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