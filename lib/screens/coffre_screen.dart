import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/theme/app_theme.dart';

class CoffreScreen extends StatefulWidget {
  const CoffreScreen({super.key});

  @override
  State<CoffreScreen> createState() => _CoffreScreenState();
}

class _CoffreScreenState extends State<CoffreScreen> {
  String _query = '';

  static const _solutions = <(String, String, String)>[
    ('⏱️', 'Le pas de 10 minutes', 'Choisis un seul geste qui peut être commencé et terminé en dix minutes.'),
    ('🧾', 'Faire une liste courte', 'Écris les trois choses qui comptent vraiment. Le reste attend.'),
    ('🫶', 'Demander une aide précise', 'Au lieu de « aide-moi », essaie « peux-tu rester avec moi pendant cet appel ? »'),
    ('📦', 'La patente à gosse', 'Regarde ce que tu as déjà : outils, objets, savoir-faire, contacts ou solutions de récupération.'),
    ('🧠', 'Test de réalité', 'Qu’est-ce que je sais ? Qu’est-ce que j’imagine ? Quelle information me manque ?'),
    ('💛', 'Assez bon pour aujourd’hui', 'Définis le minimum qui répond au besoin principal, sans chercher la perfection.'),
    ('🌬️', 'Revenir au présent', 'Pose les pieds au sol, remarque cinq choses autour de toi et relâche les épaules.'),
    ('📅', 'Découper l’échéance', 'Transforme une grosse tâche en étapes courtes avec une prochaine action claire.'),
  ];

  @override
  Widget build(BuildContext context) {
    final items = _solutions.where((item) => '${item.$2} ${item.$3}'.toLowerCase().contains(_query.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('📚 Coffre des solutions')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        const Text('Pioche une idée. Garde seulement celles qui t’aident.', style: TextStyle(fontSize: 17, color: stormGrey, height: 1.5)),
        const SizedBox(height: 16),
        TextField(onChanged: (value) => setState(() => _query = value), decoration: const InputDecoration(prefixIcon: Icon(Icons.search_rounded), hintText: 'Rechercher une idée')),
        const SizedBox(height: 16),
        ...items.map((item) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(item.$1, style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(item.$2, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: deepBlue)), const SizedBox(height: 6), Text(item.$3, style: const TextStyle(color: stormGrey, height: 1.5))])),
              ]),
            )),
        if (items.isEmpty) const Padding(padding: EdgeInsets.all(24), child: Text('Aucune idée trouvée. Essaie un autre mot.', textAlign: TextAlign.center)),
      ]),
    );
  }
}
