import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/screens/adequat_screen.dart';
import 'package:le_deproblematisateur/screens/coffre_screen.dart';
import 'package:le_deproblematisateur/screens/deproblematiser_screen.dart';
import 'package:le_deproblematisateur/screens/panic_screen.dart';
import 'package:le_deproblematisateur/screens/patente_screen.dart';
import 'package:le_deproblematisateur/theme/app_theme.dart';
import 'package:le_deproblematisateur/widgets/choice_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final entries = [
      (
        title: '🚨 PANIK',
        subtitle: 'Respire. Observe. Agis.',
        icon: Icons.warning_amber_rounded,
        accent: chaosBlue,
        screen: const PanicScreen(),
      ),
      (
        title: '🛠️ DÉPROBLÉMATISER',
        subtitle: 'Transformer les problèmes en déproblèmes.',
        icon: Icons.build_circle_outlined,
        accent: heartGold,
        screen: const DeproblematiserScreen(),
      ),
      (
        title: '📦 PATENTE À GOSSE',
        subtitle: 'Utilise ce que tu as avant de chercher ce qu’il te manque.',
        icon: Icons.inventory_2_outlined,
        accent: stormGrey,
        screen: const PatenteScreen(),
      ),
      (
        title: '💛 PARFAITEMENT ADÉQUAT',
        subtitle: 'Est-ce suffisamment bon pour aujourd’hui ?',
        icon: Icons.favorite_rounded,
        accent: softCoral,
        screen: const AdequatScreen(),
      ),
      (
        title: '📚 COFFRE DES SOLUTIONS',
        subtitle: 'Des idées concrètes pour avancer.',
        icon: Icons.backpack_outlined,
        accent: deepBlue,
        screen: const CoffreScreen(),
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: softGold,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '🌪️💛 LE DÉPROBLÉMATISATEUR',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: deepBlue,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Trouver le calme au centre du tourbillon.',
                style: theme.textTheme.headlineLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'Transformer les problèmes en déproblèmes.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [chaosBlue, deepBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '💛 La phrase fondatrice',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Le Déproblématisateur n’est pas là pour éliminer le chaos.\nIl est là pour aider les gens à retrouver leur capacité d’agir à l’intérieur du chaos.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: heartGold,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Text(
                          '🌪️💛',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 26),
              Text(
                'Choisis ton module',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: ChoiceCard(
                    title: entry.title,
                    subtitle: entry.subtitle,
                    icon: entry.icon,
                    accent: entry.accent,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => entry.screen),
                      );
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
