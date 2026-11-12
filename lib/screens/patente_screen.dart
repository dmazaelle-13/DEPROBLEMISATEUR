import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/theme/app_theme.dart';
import 'package:le_deproblematisateur/widgets/section_card.dart';

class PatenteScreen extends StatelessWidget {
  const PatenteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('⏱️ Temps', 'Que peux-tu faire en 10 minutes ?'),
      ('💸 Budget', 'Quel est le coût le plus bas pour avancer ?'),
      ('🧰 Ressources', 'Qu’est-ce que tu as déjà sous la main ?'),
      ('🧠 Créativité', 'Quel moyen de faire autrement ?'),
      ('📦 Réparation', 'Qu’est-ce qu’on peut rapiécer sans tout refaire ?'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('📦 PATENTE À GOSSE')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionCard(
                title: '🛠️ La règle',
                body:
                    'Créer avec ce qu’on a déjà. Pas parfait. Pas cher. Pas compliqué. Juste assez bon pour avancer.',
                icon: Icons.handyman_rounded,
                accent: stormGrey,
              ),
              const SizedBox(height: 18),
              Text(
                'Patente à Gosse',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...items.map(
                (item) => Container(
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
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: mistGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            item.$1,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          item.$2,
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
