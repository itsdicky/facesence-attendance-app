import 'package:flutter/material.dart';

import 'color_style.dart';

class WidgetStyle {

  WidgetStyle._();

  static InputDecoration textfieldDecoration({required String hintText}) {
    return InputDecoration(
      filled: true,
      fillColor: ColorStyle.lightGrey,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
      border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(18))
      ),
      hintText: hintText
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