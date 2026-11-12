import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/theme/app_theme.dart';
import 'package:le_deproblematisateur/widgets/section_card.dart';

class PanicScreen extends StatelessWidget {
  const PanicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      'Respire profondément pendant 10 secondes.',
      'Observe sans juger : ce qui est vrai, ce qui est imaginé.',
      'Identifier le vrai problème et ce qui est seulement une réaction.',
      'Choisir le prochain petit pas possible.',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('🚨 PANIK')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Quand tout semble urgent, on ne cherche pas la perfection — on cherche le prochain pas possible.',
                style: TextStyle(fontSize: 18, height: 1.5, color: stormGrey),
              ),
              const SizedBox(height: 20),
              const SectionCard(
                title: '🌪️ Le tourbillon',
                body:
                    'Les scénarios catastrophes tournent. Les « et si ? » tournent. Les urgences tournent. Les émotions tournent.',
                icon: Icons.tornado_rounded,
                accent: chaosBlue,
              ),
              const SizedBox(height: 16),
              Text(
                '🧭 Le protocole',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...steps.asMap().entries.map((entry) {
                final index = entry.key + 1;
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: chaosBlue,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            '$index',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: const TextStyle(
                            fontSize: 16,
                            color: stormGrey,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 12),
              const SectionCard(
                title: '💛 Citoyen du calme',
                body:
                    'La bonne question n’est pas : “Pourquoi ça m’arrive ?”\nLa bonne question est : “Quel est le prochain petit pas possible ?”',
                icon: Icons.psychology_alt_rounded,
                accent: heartGold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
