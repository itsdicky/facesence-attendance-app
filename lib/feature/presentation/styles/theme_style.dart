import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistem_presensi/feature/presentation/styles/color_style.dart';

class ThemeStyle {

  ThemeStyle._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: ColorStyle.indigoPurpleSwatches,
    textTheme: GoogleFonts.montserratTextTheme(),
  );
}