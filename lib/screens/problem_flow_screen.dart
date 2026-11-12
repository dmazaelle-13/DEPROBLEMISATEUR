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

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final problem = ProblemModel(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      urgency: _urgency,
      energy: _energy,
      budget: _budget,
      timeAvailable: _time,
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SolutionScreen(problem: problem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('🌪️ MON PROBLÈME')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Décris ton problème pour retrouver le prochain pas possible.',
                  style: TextStyle(
                    fontSize: 18,
                    color: stormGrey,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Titre du problème',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Donne un titre' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Décris ce qui se passe',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      value == null || value.trim().isEmpty ? 'Explique le problème' : null,
                ),
                const SizedBox(height: 18),
                _buildDropdown('Niveau d’urgence', _urgency, ['Très urgent', 'Urgent', 'Moyenne', 'Peu urgent'],
                    (value) => setState(() => _urgency = value ?? 'Moyenne')),
                const SizedBox(height: 12),
                _buildDropdown('Énergie disponible', _energy, ['Faible', 'Moyenne', 'Bonne', 'Élevée'],
                    (value) => setState(() => _energy = value ?? 'Moyenne')),
                const SizedBox(height: 12),
                _buildDropdown('Budget', _budget, ['0 €', 'Très limité', 'Modéré', 'Suffisant'],
                    (value) => setState(() => _budget = value ?? 'Modéré')),
                const SizedBox(height: 12),
                _buildDropdown('Temps disponible', _time, ['Peu de temps', '1h', 'Quelques heures', 'Plusieurs jours'],
                    (value) => setState(() => _time = value ?? 'Peu de temps')),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: deepBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    icon: const Icon(Icons.arrow_forward_rounded),
                    label: const Text('Voir les solutions'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class SolutionScreen extends StatelessWidget {
  final ProblemModel problem;

  const SolutionScreen({super.key, required this.problem});

  @override
  Widget build(BuildContext context) {
    final solutions = ProblemService.generateSolutions(problem);
    final questions = ProblemService.generateQuestions(problem);

    return Scaffold(
      appBar: AppBar(title: const Text('🛠️ SOLUTIONS')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [heartGold, softGold],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🌪️ Résumé du tourbillon',
                      style: TextStyle(
                        color: deepBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ProblemService.buildProblemSummary(problem),
                      style: const TextStyle(
                        color: deepBlue,
                        fontSize: 16,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Quelques pistes concrètes',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...solutions.map(
                (solution) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
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
              const SizedBox(height: 22),
              Text(
                'Questions à se poser',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              ...questions.map(
                (question) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: mistGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.help_outline_rounded, color: chaosBlue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          question,
                          style: const TextStyle(
                            color: deepBlue,
                            fontSize: 15,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Le but n’est pas d’être parfait.\nLe but est de faire le prochain bon pas, assez bon pour aujourd’hui.',
                style: TextStyle(
                  fontSize: 16,
                  color: stormGrey,
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
