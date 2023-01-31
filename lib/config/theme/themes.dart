import 'package:flutter/material.dart';

abstract class Themes {
  const Themes._();

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}

