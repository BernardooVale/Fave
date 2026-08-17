import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../cores.dart';

class AzulejoPatternPainter extends CustomPainter {
  final Color color;
  final double opacity;

  AzulejoPatternPainter({this.color = AppColors.azulejo, this.opacity = 0.05});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5;

    const tileSize = 40.0;
    for (double x = 0; x < size.width; x += tileSize) {
      for (double y = 0; y < size.height; y += tileSize) {
        _drawTile(canvas, Offset(x, y), tileSize, paint);
      }
    }
  }

  void _drawTile(Canvas canvas, Offset offset, double size, Paint paint) {
    final rect = Rect.fromLTWH(offset.dx, offset.dy, size, size);
    canvas.drawRect(rect, paint);
    
    // Desenha pequenos diamantes ou flores geométricas
    final center = offset + Offset(size / 2, size / 2);
    final r = size * 0.3;
    
    final path = Path()
      ..moveTo(center.dx, center.dy - r)
      ..lineTo(center.dx + r, center.dy)
      ..lineTo(center.dx, center.dy + r)
      ..lineTo(center.dx - r, center.dy)
      ..close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class OrnamentalBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.brass.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final margin = 4.0;
    final rect = Rect.fromLTWH(margin, margin, size.width - margin * 2, size.height - margin * 2);
    
    // Cantos em "L" ornamental
    const cornerSize = 12.0;
    
    // Top-Left
    canvas.drawLine(Offset(rect.left, rect.top + cornerSize), Offset(rect.left, rect.top), paint);
    canvas.drawLine(Offset(rect.left, rect.top), Offset(rect.left + cornerSize, rect.top), paint);
    
    // Top-Right
    canvas.drawLine(Offset(rect.right - cornerSize, rect.top), Offset(rect.right, rect.top), paint);
    canvas.drawLine(Offset(rect.right, rect.top), Offset(rect.right, rect.top + cornerSize), paint);
    
    // Bottom-Left
    canvas.drawLine(Offset(rect.left, rect.bottom - cornerSize), Offset(rect.left, rect.bottom), paint);
    canvas.drawLine(Offset(rect.left, rect.bottom), Offset(rect.left + cornerSize, rect.bottom), paint);
    
    // Bottom-Right
    canvas.drawLine(Offset(rect.right - cornerSize, rect.bottom), Offset(rect.right, rect.bottom), paint);
    canvas.drawLine(Offset(rect.right, rect.bottom), Offset(rect.right, rect.bottom - cornerSize), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
