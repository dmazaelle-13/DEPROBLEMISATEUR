import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/theme/app_theme.dart';
import 'package:le_deproblematisateur/widgets/section_card.dart';

class AdequatScreen extends StatelessWidget {
  const AdequatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final checks = [
      'Est-ce assez bon pour aujourd’hui ?',
      'Est-ce que cela répond au besoin principal ?',
      'Est-ce que cela réduit la pression ?',
      'Est-ce que je peux le faire sans me briser ?',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('💛 PARFAITEMENT ADÉQUAT')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SectionCard(
                title: '💛 La phrase qui sauve',
                body:
                    'Est-ce suffisamment bon pour aujourd’hui ?\nCette phrase combat le perfectionnisme.',
                icon: Icons.favorite_rounded,
                accent: softCoral,
              ),
              const SizedBox(height: 20),
              ...checks.map(
                (item) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded, color: heartGold),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 16,
                            color: deepBlue,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
