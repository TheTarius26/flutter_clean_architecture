import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light => ThemeData.light().copyWith(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      );

  static ThemeData get dark => ThemeData.dark();
}
