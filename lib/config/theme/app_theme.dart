import 'package:flutter/material.dart';

class AppTheme {
  static final ColorScheme _colorTheme = ColorScheme.fromSeed(seedColor: Colors.orange);

  static ThemeData themeData() {
    return ThemeData(
        colorScheme: _colorTheme,
      );
  }
}