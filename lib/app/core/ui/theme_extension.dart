import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get primaryColorLigth => Theme.of(this).primaryColorLight;
  Color get buttonColor => Theme.of(this).primaryColor;
  Color get background => Theme.of(this).colorScheme.background;
  Color get errorColor => Theme.of(this).colorScheme.error;
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get titleStyle => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      );
}
