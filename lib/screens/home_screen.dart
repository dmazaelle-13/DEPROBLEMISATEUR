import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/models/problem_model.dart';
import 'package:le_deproblematisateur/screens/adequat_screen.dart';
import 'package:le_deproblematisateur/screens/coffre_screen.dart';
import 'package:le_deproblematisateur/screens/deproblematiser_screen.dart';
import 'package:le_deproblematisateur/screens/history_screen.dart';
import 'package:le_deproblematisateur/screens/panic_screen.dart';
import 'package:le_deproblematisateur/screens/patente_screen.dart';
import 'package:le_deproblematisateur/screens/problem_flow_screen.dart';
import 'package:le_deproblematisateur/theme/app_theme.dart';
import 'package:le_deproblematisateur/widgets/choice_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: _tab,
          children: [
            _HomeDashboard(onHistory: () => setState(() => _tab = 1)),
            const HistoryScreen(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _tab,
          onDestinationSelected: (index) => setState(() => _tab = index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home_rounded), label: 'Accueil'),
            NavigationDestination(icon: Icon(Icons.history_rounded), label: 'Mon parcours'),
          ],
        ),
      );
}

class _HomeDashboard extends StatelessWidget {
  final VoidCallback onHistory;
  const _HomeDashboard({required this.onHistory});

  void _open(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final modules = <(String, String, IconData, Color, Widget)>[
      ('🚨 PANIK', 'Respire. Observe. Agis.', Icons.spa_rounded, chaosBlue, const PanicScreen()),
      ('🛠️ DÉPROBLÉMATISER', 'Clarifie la situation et trouve un prochain pas.', Icons.handyman_rounded, heartGold, const DeproblematiserScreen()),
      ('📦 PATENTE À GOSSE', 'Débrouille-toi avec ce que tu as déjà.', Icons.inventory_2_outlined, stormGrey, const PatenteScreen()),
      ('💛 PARFAITEMENT ADÉQUAT', 'Assez bon pour aujourd’hui, c’est déjà bien.', Icons.favorite_rounded, softCoral, const AdequatScreen()),
      ('📚 COFFRE DES SOLUTIONS', 'Des idées simples à piocher.', Icons.auto_awesome_outlined, leafGreen, const CoffreScreen()),
    ];

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: [
                    const _WhirlwindMark(size: 48),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text('LE DÉPROBLÉMATISATEUR', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, letterSpacing: 1, color: deepBlue)),
                    ),
                    IconButton(onPressed: onHistory, tooltip: 'Mon parcours', icon: const Icon(Icons.history_rounded, color: chaosBlue)),
                  ],
                ),
                const SizedBox(height: 24),
                Text('On fait un pas à la fois.', style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 8),
                Text('Trouver le calme au centre du tourbillon.', style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 20),
                _PrimaryStartCard(onTap: () => _open(context, const ProblemFlowScreen())),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [chaosBlue, deepBlue], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('🌪️  →  💛', style: TextStyle(fontSize: 24)),
                    SizedBox(height: 12),
                    Text('Le but n’est pas d’éliminer le chaos.', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800)),
                    SizedBox(height: 6),
                    Text('C’est de retrouver assez de calme pour choisir le prochain pas possible.', style: TextStyle(color: Colors.white, height: 1.5)),
                  ]),
                ),
                const SizedBox(height: 28),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Choisis ce dont tu as besoin', style: Theme.of(context).textTheme.titleLarge),
                  TextButton(onPressed: onHistory, child: const Text('Historique')),
                ]),
                const SizedBox(height: 12),
                ...modules.map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ChoiceCard(title: item.$1, subtitle: item.$2, icon: item.$3, accent: item.$4, onTap: () => _open(context, item.$5)),
                    )),
                const SizedBox(height: 10),
                const Text('Si toi ou une autre personne êtes en danger immédiat, appelle les services d’urgence de ta région.', style: TextStyle(fontSize: 13, color: stormGrey, height: 1.5)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryStartCard extends StatelessWidget {
  final VoidCallback onTap;
  const _PrimaryStartCard({required this.onTap});

  @override
  Widget build(BuildContext context) => Material(
        color: heartGold,
        borderRadius: BorderRadius.circular(22),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(22),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(children: [
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('J’ai un problème', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: deepBlue)),
                SizedBox(height: 4),
                Text('On va le démêler ensemble.', style: TextStyle(color: deepBlue)),
              ])),
              Container(width: 46, height: 46, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle), child: const Icon(Icons.arrow_forward_rounded, color: deepBlue)),
            ]),
          ),
        ),
      );
}

class _WhirlwindMark extends StatelessWidget {
  final double size;
  const _WhirlwindMark({required this.size});

  @override
  Widget build(BuildContext context) => SizedBox(
        width: size,
        height: size,
        child: Stack(alignment: Alignment.center, children: [
          DecoratedBox(decoration: BoxDecoration(color: chaosBlue, borderRadius: BorderRadius.circular(size * .34)), child: SizedBox(width: size, height: size)),
          const Icon(Icons.cyclone_rounded, color: Colors.white, size: 31),
          const Positioned(right: 8, bottom: 7, child: Icon(Icons.favorite_rounded, color: heartGold, size: 14)),
        ]),
      );
}

// Keep this import used to make the app-wide history model easy to discover from the home module.
final ProblemModel? _homeProblemTypeReference = null;
