import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/theme/app_theme.dart';
import 'package:le_deproblematisateur/widgets/section_card.dart';

class DeproblematiserScreen extends StatelessWidget {
  const DeproblematiserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final questions = [
      'Quel est le vrai problème ?',
      'Que peut-on distinguer comme urgent et comme important ?',
      'Qu’est-ce qui est déjà dans ma poche ?',
      'Quel est le prochain petit pas réaliste ?',
      'Que peux-je faire aujourd’hui sans me détruire ?',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('🛠️ DÉPROBLÉMATISER')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionCard(
                title: '🌪️💛 Le principe',
                body:
                    'Le but n’est pas d’éliminer le chaos. Le but est de retrouver le calme au centre du chaos pour faire le prochain pas.',
                icon: Icons.auto_fix_high_rounded,
                accent: heartGold,
              ),
              const SizedBox(height: 18),
              Text(
                'Questions utiles',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...questions.map(
                (question) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.help_outline_rounded, color: heartGold),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          question,
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
              const SizedBox(height: 12),
              const SectionCard(
                title: '🧠 Slogan moteur',
                body:
                    'Transformer les problèmes en déproblèmes.\nPas en solutions parfaites. En petits pas réalistes.',
                icon: Icons.lightbulb_outline_rounded,
                accent: chaosBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
