import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/models/problem_model.dart';
import 'package:le_deproblematisateur/services/problem_service.dart';
import 'package:le_deproblematisateur/theme/app_theme.dart';

class ProblemFlowScreen extends StatefulWidget {
  const ProblemFlowScreen({super.key});

  @override
  State<ProblemFlowScreen> createState() => _ProblemFlowScreenState();
}

class _ProblemFlowScreenState extends State<ProblemFlowScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _urgency = 'Moyenne';
  String _energy = 'Moyenne';
  String _budget = 'Modéré';
  String _time = 'Peu de temps';
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    final problem = ProblemModel(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      urgency: _urgency,
      energy: _energy,
      budget: _budget,
      timeAvailable: _time,
    );
    await ProblemService.saveProblem(problem);
    if (!mounted) return;
    setState(() => _isSaving = false);
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => SolutionScreen(problem: problem)));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('🌪️ Démêler la situation')),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              children: [
                const Text('On ne règle pas tout d’un coup. On commence par comprendre.', style: TextStyle(fontSize: 18, height: 1.5, color: stormGrey)),
                const SizedBox(height: 20),
                TextFormField(controller: _titleController, maxLength: 70, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(labelText: 'En quelques mots, qu’est-ce qui se passe ?', hintText: 'Ex. Je suis en retard sur une facture'), validator: (value) => value == null || value.trim().isEmpty ? 'Ajoute un petit titre pour t’y retrouver.' : null),
                const SizedBox(height: 14),
                TextFormField(controller: _descriptionController, minLines: 3, maxLines: 6, textCapitalization: TextCapitalization.sentences, decoration: const InputDecoration(labelText: 'Ce que tu veux noter (facultatif)', hintText: 'Écris librement. Tu peux rester vague.'), maxLength: 500),
                const SizedBox(height: 8),
                _DropdownField(label: 'À quel point est-ce urgent ?', value: _urgency, items: const ['Très urgent', 'Urgent', 'Moyenne', 'Peu urgent'], onChanged: (value) => setState(() => _urgency = value)),
                const SizedBox(height: 12),
                _DropdownField(label: 'Quelle énergie as-tu ?', value: _energy, items: const ['Faible', 'Moyenne', 'Bonne', 'Élevée'], onChanged: (value) => setState(() => _energy = value)),
                const SizedBox(height: 12),
                _DropdownField(label: 'Quel budget peux-tu y consacrer ?', value: _budget, items: const ['0 €', 'Très limité', 'Modéré', 'Suffisant'], onChanged: (value) => setState(() => _budget = value)),
                const SizedBox(height: 12),
                _DropdownField(label: 'Combien de temps as-tu ?', value: _time, items: const ['Peu de temps', '1h', 'Quelques heures', 'Plusieurs jours'], onChanged: (value) => setState(() => _time = value)),
                const SizedBox(height: 22),
                FilledButton.icon(onPressed: _isSaving ? null : _submit, icon: _isSaving ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.arrow_forward_rounded), label: Text(_isSaving ? 'Enregistrement…' : 'Trouver mon prochain pas'), style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(54), backgroundColor: deepBlue, foregroundColor: Colors.white)),
                const SizedBox(height: 12),
                const Text('Tes notes restent enregistrées localement sur cet appareil.', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: stormGrey)),
              ],
            ),
          ),
        ),
      );
}

class _DropdownField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;
  const _DropdownField({required this.label, required this.value, required this.items, required this.onChanged});

  @override
  Widget build(BuildContext context) => DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(labelText: label),
        items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
        onChanged: (newValue) { if (newValue != null) onChanged(newValue); },
      );
}

class SolutionScreen extends StatelessWidget {
  final ProblemModel problem;
  const SolutionScreen({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    final solutions = ProblemService.generateSolutions(problem);
    final questions = ProblemService.generateQuestions(problem);
    return Scaffold(
      appBar: AppBar(title: const Text('Ton prochain pas')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 30),
        children: [
          Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(gradient: const LinearGradient(colors: [heartGold, softGold]), borderRadius: BorderRadius.circular(24)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('💛 On a démêlé un premier fil', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: deepBlue)),
            const SizedBox(height: 10),
            Text(ProblemService.buildProblemSummary(problem), style: const TextStyle(color: deepBlue, height: 1.5)),
            if (problem.description.isNotEmpty) ...[const SizedBox(height: 10), Text(problem.description, style: const TextStyle(color: deepBlue, height: 1.5))],
          ])),
          const SizedBox(height: 24),
          Text('Des pistes adaptées à tes ressources', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...solutions.asMap().entries.map((entry) => _StepCard(number: entry.key + 1, text: entry.value)),
          const SizedBox(height: 20),
          Text('Quelques questions pour clarifier', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...questions.map((question) => Padding(padding: const EdgeInsets.only(bottom: 8), child: ListTile(leading: const Icon(Icons.help_outline_rounded, color: chaosBlue), title: Text(question), tileColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))))),
          const SizedBox(height: 18),
          FilledButton.icon(onPressed: () async {
            await ProblemService.setCompleted(problem.copyWith(id: problem.id.isEmpty ? '' : problem.id), true);
            if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bravo pour ce pas. Tu peux continuer à ton rythme.')));
          }, icon: const Icon(Icons.favorite_rounded), label: const Text('J’ai fait mon prochain pas'), style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52), backgroundColor: chaosBlue)),
          TextButton(onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst), child: const Text('Retour à l’accueil')),
          const Center(child: Text('Pas parfait. Juste assez bon pour avancer. 🌪️💛', style: TextStyle(color: stormGrey))),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int number;
  final String text;
  const _StepCard({required this.number, required this.text});

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(backgroundColor: heartGold, foregroundColor: deepBlue, child: Text('$number', style: const TextStyle(fontWeight: FontWeight.w900))),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: deepBlue, height: 1.5))),
        ]),
      );
}
