import 'package:flutter/material.dart';

abstract class AppStyles {
  static const mainColor = Color.fromARGB(255, 81, 109, 230);
  static const firstScreensButtonStyle = ButtonStyle(
      elevation: MaterialStatePropertyAll(0),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 14)),
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12))),
      ),
      backgroundColor: MaterialStatePropertyAll(mainColor));
}
