import 'package:flutter/material.dart';

const Color chaosBlue = Color(0xFF1F355A);
const Color deepBlue = Color(0xFF0F1C32);
const Color heartGold = Color(0xFFF7D76C);
const Color softGold = Color(0xFFFFE8A3);
const Color calmWhite = Color(0xFFF9F9F9);
const Color mistGrey = Color(0xFFEEF3F8);
const Color stormGrey = Color(0xFF495D73);
const Color softCoral = Color(0xFFEF9A9A);

ThemeData buildAppTheme() {
  final base = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: calmWhite,
    colorScheme: ColorScheme.fromSeed(
      seedColor: chaosBlue,
      brightness: Brightness.light,
      primary: chaosBlue,
      secondary: heartGold,
      surface: calmWhite,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        letterSpacing: -1,
        color: deepBlue,
      ),
      headlineMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: deepBlue,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: deepBlue,
      ),
      bodyLarge: TextStyle(
        fontSize: 18,
        color: stormGrey,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: stormGrey,
      ),
      labelLarge: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: deepBlue,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: calmWhite,
      foregroundColor: deepBlue,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );

  return base.copyWith(
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.zero,
    ),
  );
}
