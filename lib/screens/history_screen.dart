import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/models/problem_model.dart';
import 'package:le_deproblematisateur/services/problem_service.dart';
import 'package:le_deproblematisateur/theme/app_theme.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<ProblemModel>> _problems;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() => _problems = ProblemService.loadProblems();

  Future<void> _delete(ProblemModel problem) async {
    await ProblemService.deleteProblem(problem.id);
    if (mounted) setState(_refresh);
  }

  Future<void> _toggle(ProblemModel problem) async {
    await ProblemService.setCompleted(problem, !problem.completed);
    if (mounted) setState(_refresh);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Mon parcours'), actions: [IconButton(onPressed: () => setState(_refresh), tooltip: 'Actualiser', icon: const Icon(Icons.refresh_rounded))]),
        body: FutureBuilder<List<ProblemModel>>(
          future: _problems,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
            final problems = snapshot.data ?? [];
            if (problems.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.spa_outlined, size: 54, color: chaosBlue),
                    const SizedBox(height: 16),
                    Text('Ton historique est encore vide', style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
                    const SizedBox(height: 8),
                    const Text('Les problèmes que tu enregistres apparaîtront ici. Ils restent sur cet appareil.', textAlign: TextAlign.center, style: TextStyle(color: stormGrey, height: 1.5)),
                  ]),
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: problems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final problem = problems[index];
                final date = DateTime.tryParse(problem.createdAt)?.toLocal();
                final dateLabel = date == null ? '' : '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      Icon(problem.completed ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded, color: problem.completed ? leafGreen : heartGold),
                      const SizedBox(width: 10),
                      Expanded(child: Text(problem.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: deepBlue))),
                      PopupMenuButton<String>(
                        onSelected: (value) => value == 'delete' ? _delete(problem) : _toggle(problem),
                        itemBuilder: (_) => [
                          PopupMenuItem(value: 'toggle', child: Text(problem.completed ? 'Rouvrir' : 'Marquer comme fait')),
                          const PopupMenuItem(value: 'delete', child: Text('Supprimer')),
                        ],
                      ),
                    ]),
                    if (problem.description.isNotEmpty) Padding(padding: const EdgeInsets.only(left: 34, top: 6), child: Text(problem.description, maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(color: stormGrey, height: 1.45))),
                    Padding(padding: const EdgeInsets.only(left: 34, top: 10), child: Text('$dateLabel  ·  ${problem.urgency}  ·  ${problem.timeAvailable}', style: const TextStyle(fontSize: 12, color: stormGrey))),
                  ]),
                );
              },
            );
          },
        ),
      );
}
