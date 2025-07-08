import 'package:flutter/material.dart';

class AppTheme {
  static final ColorScheme _colorTheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(242, 130, 33, 1),
    onPrimary: Color.fromRGBO(28, 20, 13, 1),
    secondary: Color.fromRGBO(245, 237, 232, 1),
    onSecondary: Color.fromRGBO(156, 112, 74, 1),
    error: Colors.red.shade700,
    onError: Colors.white,
    surface: Color.fromRGBO(252, 250, 247, 1),
    onSurface: Colors.black87,
  );

  static ThemeData themeData() {
    return ThemeData(
        colorScheme: _colorTheme,
      );
  }
}