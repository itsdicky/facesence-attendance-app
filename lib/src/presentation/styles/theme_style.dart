import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sistem_presensi/src/presentation/styles/color_style.dart';

class ThemeStyle {

  ThemeStyle._();

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: ColorStyle.indigoPurpleSwatches,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(
        fontSize: 36,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      headlineLarge: GoogleFonts.montserrat(
        fontSize: 22,
        fontWeight: FontWeight.w800,
      ),
      headlineMedium: GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w800,
      ),
      headlineSmall: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      titleSmall: GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelLarge: GoogleFonts.montserrat(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      labelMedium: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.w400,
      )
    ),
  );
}