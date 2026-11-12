import 'dart:convert';

import 'package:le_deproblematisateur/models/problem_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProblemService {
  static const _storageKey = 'saved_problems_v1';

  static String buildProblemSummary(ProblemModel problem) {
    return '« ${problem.title} » demande de l’attention. Tu l’as évalué comme ${problem.urgency.toLowerCase()}, avec une énergie ${problem.energy.toLowerCase()} et ${problem.timeAvailable.toLowerCase()}.';
  }

  static List<String> generateSolutions(ProblemModel problem) {
    final solutions = <String>[];
    if (problem.urgency == 'Très urgent') {
      solutions.add('Choisis une seule action de sécurité ou de stabilisation à faire maintenant. Si quelqu’un est en danger, contacte immédiatement les services d’urgence locaux.');
    } else if (problem.urgency == 'Urgent') {
      solutions.add('Note l’échéance réelle, puis identifie une action courte qui réduit le risque aujourd’hui.');
    } else {
      solutions.add('Découpe la situation en trois petites tâches et commence par celle qui débloque les autres.');
    }

    if (problem.budget == '0 €' || problem.budget == 'Très limité') {
      solutions.add('Commence par les ressources déjà disponibles : objets, compétences, contacts, services gratuits ou possibilité de réparer/réutiliser.');
    } else {
      solutions.add('Compare les options simples et peu coûteuses avant d’engager une dépense importante.');
    }

    solutions.add(problem.energy == 'Faible'
        ? 'Vise le minimum viable : une action de cinq minutes, puis une pause. Tu peux demander à quelqu’un de t’accompagner.'
        : 'Choisis un objectif réaliste et limite-le à une courte période pour préserver ton énergie.');
    solutions.add(problem.timeAvailable == 'Peu de temps'
        ? 'Réserve dix minutes et fais uniquement le premier geste concret.'
        : 'Bloque une courte plage de temps et définis à l’avance ce qui signifiera « assez pour aujourd’hui ».');
    solutions.add('Demande une aide précise à une personne de confiance : expliquer, appeler, transporter, relire ou rester avec toi.');
    solutions.add('Vérifie si une version « suffisamment bonne pour aujourd’hui » répond déjà au besoin principal.');
    return solutions;
  }

  static List<String> generateQuestions(ProblemModel problem) => const [
        'Qu’est-ce que je sais avec certitude, et qu’est-ce que je redoute seulement ?',
        'Qu’est-ce qui doit être fait maintenant, et qu’est-ce qui peut attendre ?',
        'Quelles ressources ai-je déjà sous la main ?',
        'Quel est le plus petit pas possible en moins de 15 minutes ?',
        'À qui puis-je demander une aide précise ?',
      ];

  static Future<List<ProblemModel>> loadProblems() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .whereType<Map<String, dynamic>>()
          .map(ProblemModel.fromMap)
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    } on FormatException {
      return [];
    } on TypeError {
      return [];
    }
  }

  static Future<void> saveProblem(ProblemModel problem) async {
    final problems = await loadProblems();
    final id = problem.id.isEmpty ? DateTime.now().microsecondsSinceEpoch.toString() : problem.id;
    final saved = problem.copyWith(id: id, createdAt: problem.createdAt.isEmpty ? DateTime.now().toIso8601String() : problem.createdAt);
    problems.removeWhere((item) => item.id == id);
    problems.insert(0, saved);
    await _write(problems);
  }

  static Future<void> setCompleted(ProblemModel problem, bool completed) async {
    final problems = await loadProblems();
    final index = problems.indexWhere((item) => item.id == problem.id);
    if (index < 0) return;
    problems[index] = problems[index].copyWith(completed: completed);
    await _write(problems);
  }

  static Future<void> deleteProblem(String id) async {
    final problems = await loadProblems();
    problems.removeWhere((item) => item.id == id);
    await _write(problems);
  }

  static Future<void> _write(List<ProblemModel> problems) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(problems.map((problem) => problem.toMap()).toList()));
  }
}
