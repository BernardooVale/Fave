import 'package:flutter/material.dart';

class AppColors {
  // Brand Identity - Mel & Brass
  static const Color mel = Color(0xFFCC8F00);        // Ouro Vivo / Mel (Original Brand)
  static const Color brass = Color(0xFFC5A059);      // Latão / Ouro Envelhecido (Modernized Accent)
  static const Color wood = Color(0xFF3D2B1F);       // Madeira Nobre (Depth)
  static const Color ivory = Color(0xFFFFFDD0);      // Marfim / Creme (Legibility)
  static const Color fundo = Color(0xFF1A1919);      // Deep Charcoal (Background)

  // Category Specific Accents
  static const Color terracotta = Color(0xFFA0522D); // Folders (Barro/Terracota)
  static const Color azulejo = Color(0xFF0055A4);    // Passwords (Cobalt Portuguese Blue)
  static const Color botanical = Color(0xFF5E8B5E);  // Documents (Vibrant Leaf Green)

  // Theme Mappings
  static const Color primaria = mel;
  static const Color secundaria = brass;
  static const Color terciaria = Color(0xFF7D5252);  // Desaturated Dusty Red (Destructive Actions)
  static const Color pasta = terracotta;
  static const Color doc = botanical;

  // Gradientes e Texturas
  static const List<Color> bronzeGradient = [
    Color(0xFFC5A059),
    Color(0xFFE5C17A),
    Color(0xFF9E7E43),
  ];
}
