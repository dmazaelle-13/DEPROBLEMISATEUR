import 'package:flutter/material.dart';

const Color chaosBlue = Color(0xFF24436A);
const Color deepBlue = Color(0xFF12243D);
const Color heartGold = Color(0xFFFFD66B);
const Color softGold = Color(0xFFFFF0BE);
const Color calmWhite = Color(0xFFF7F8FC);
const Color mistGrey = Color(0xFFEBF0F6);
const Color stormGrey = Color(0xFF53657A);
const Color softCoral = Color(0xFFE9928C);
const Color leafGreen = Color(0xFF4E806C);

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: chaosBlue,
    primary: chaosBlue,
    secondary: heartGold,
    surface: Colors.white,
    brightness: Brightness.light,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: calmWhite,
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, letterSpacing: -1, color: deepBlue),
      headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: deepBlue),
      titleLarge: TextStyle(fontSize: 21, fontWeight: FontWeight.w750, color: deepBlue),
      titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: deepBlue),
      bodyLarge: TextStyle(fontSize: 17, height: 1.5, color: stormGrey),
      bodyMedium: TextStyle(fontSize: 15, height: 1.5, color: stormGrey),
      labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: calmWhite,
      foregroundColor: deepBlue,
      elevation: 0,
      centerTitle: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: mistGrey)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: mistGrey)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: chaosBlue, width: 1.5)),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      margin: EdgeInsets.zero,
    ),
  );
}
