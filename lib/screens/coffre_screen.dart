import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/theme/app_theme.dart';
import 'package:le_deproblematisateur/widgets/section_card.dart';

class CoffreScreen extends StatelessWidget {
  const CoffreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final solutions = [
      '📱 Faire une liste des 3 choses qui importent réellement.',
      '🧾 Préparer un plan de paiement ou de remboursement progressif.',
      '📅 Découper la tâche en bloc de 15 minutes.',
      '🫶 Demander une aide ou une personne de confiance.',
      '📦 Trouver la solution la moins chère, la plus simple, la plus rapide.',
      '🧠 Refaire un test de réalité : est-ce que je peux vivre avec comme ça ?',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('📚 COFFRE DES SOLUTIONS')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionCard(
                title: '🔧 L’idée',
                body:
                    'Le but est d'avoir un coffre rempli d'"'"'outils simples pour faire le prochain pas sans se perdre dans l'"'"'idéal.',
                icon: Icons.backpack_outlined,
                accent: deepBlue,
              ),
              const SizedBox(height: 20),
              Text(
                'Solutions utiles',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...solutions.map(
                (solution) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    solution,
                    style: const TextStyle(
                      fontSize: 16,
                      color: deepBlue,
                      height: 1.5,
                    ),
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
