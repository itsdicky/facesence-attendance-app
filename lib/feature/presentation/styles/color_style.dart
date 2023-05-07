import 'dart:ui';
import 'package:flutter/material.dart';

class ColorStyle {

  ColorStyle._();

  static const transparent = Colors.transparent;
  static const white = Colors.white;
  static const black = Colors.black;
  static const indigoPurple = Color(0xFF4537ED);
  static const darkGrey = Color(0xFF969696);
  static const lightGrey = Color(0xFFF1F1F9);
  static const pinkyRed = Color(0xFFF46A7B);

  static const MaterialColor indigoPurpleSwatches = MaterialColor(
    _indigoPurplePrimaryValue,
    <int, Color>{
      50: Color(0xFFc7c3fa),
      100: Color(0xFFa29bf6),
      200: Color(0xFF7d73f2),
      300: Color(0xFF6a5ff1),
      400: Color(0xFF584bef),
      500: Color(_indigoPurplePrimaryValue),
      600: Color(0xFF3e32d5),
      700: Color(0xFF372cbe),
      800: Color(0xFF3027a6),
      900: Color(0xFF29218e),
    },
  );
  static const int _indigoPurplePrimaryValue = 0xFF4537ED;
}