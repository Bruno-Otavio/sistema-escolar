import 'package:flutter/material.dart';

class LightTheme {
  final ThemeData _theme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: const Color(0xFFedf2f4),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFd90429),
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Color(0xFFedf2f4),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF2b2d42),
      secondary: Color(0xFF8d99ae),
      tertiary: Color(0xFFef233c),
      tertiaryFixed: Color(0xFFd90429),
      surface: Color(0xFFedf2f4),
      onSurface: Color(0xFFFFFFFF),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFFedf2f4),
      ),
      headlineMedium: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2b2d42),
      ),
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF2b2d42),
      ),
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Color(0xFFedf2f4),
      ),
      labelSmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: Color(0xFFedf2f4),
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Color(0xFFedf2f4),
      ),
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Color(0xFF2b2d42)
      ),
    ),
  );

  ThemeData get theme => _theme;
}
