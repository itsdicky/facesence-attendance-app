import 'package:flutter/material.dart';

import 'color_style.dart';

class CWidgetStyle {

  CWidgetStyle._();

  static InputDecoration textfieldDecoration({String? hintText}) {
    return InputDecoration(
      filled: true,
      fillColor: ColorStyle.lightGrey,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorStyle.indigoPurpleSwatches.shade100, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(18))
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorStyle.indigoPurpleSwatches.shade100, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(18))
      ),
      hintText: hintText,
      hintStyle: const TextStyle(
        color: ColorStyle.darkGrey,
      ),
    );
  }

  static InputDecoration dropdownButtonDecoration() {
    return InputDecoration(
      isDense: true,
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorStyle.indigoPurpleSwatches.shade100, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(18))
      ),
      filled: true,
      fillColor: ColorStyle.lightGrey,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorStyle.indigoPurpleSwatches.shade100, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(18))
      ),
    );
  }

  static ButtonStyle textButtonStyle() {
    return TextButton.styleFrom(
      foregroundColor: ColorStyle.white,
      backgroundColor: ColorStyle.indigoPurple,
      minimumSize: const Size.fromHeight(56),
      textStyle: const TextStyle(
        fontSize: 16,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    );
  }

  static ButtonStyle outlinedButtonStyle() {
    return OutlinedButton.styleFrom(
      foregroundColor: ColorStyle.indigoPurple,
      minimumSize: const Size.fromHeight(56),
      textStyle: const TextStyle(
        fontSize: 16,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
    );
  }
}