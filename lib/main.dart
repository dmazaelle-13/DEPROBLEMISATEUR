import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/screens/home_screen.dart';
import 'package:le_deproblematisateur/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LeDeproblematisateurApp());
}

class LeDeproblematisateurApp extends StatelessWidget {
  const LeDeproblematisateurApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Le Déproblématisateur',
        theme: buildAppTheme(),
        home: const HomeScreen(),
      );
}
