import 'package:flutter/material.dart';
import 'package:le_deproblematisateur/models/problem_model.dart';

class ProblemService {
  static String buildProblemSummary(ProblemModel problem) {
    return 'Le problème "$${problem.title}" demande de l’attention. ' 
        'Il est classé comme $${problem.urgency.toLowerCase()} avec une énergie ${problem.energy.toLowerCase()}.';
  }

  static List<String> generateSolutions(ProblemModel problem) {
    final solutions = <String>[];

    if (problem.urgency == 'Très urgent') {
      solutions.add('👉 Réduire le problème à une seule action immédiate de 10 minutes.');
    } else {
      solutions.add('👉 Séparer le problème en 3 sous-tâches simples et traitables séparément.');
    }

    if (problem.budget == '0 €' || problem.budget == 'Très limité') {
      solutions.add('👉 Utiliser ce que tu as déjà : ressources, outils, contacts, solutions improvisées.');
    } else {
      solutions.add('👉 Choisir la solution la plus simple et la moins coûteuse, sans sur-investir.');
    }

    if (problem.energy == 'Faible') {
      solutions.add('👉 Faire uniquement le minimum viable pour aujourd’hui et reporter le reste.');
    } else {
      solutions.add('👉 Définir un petit objectif réaliste pour restaurer le contrôle sans te dépasser.');
    }

    if (problem.timeAvailable == 'Peu de temps') {
      solutions.add('👉 Découper en mini-pas de 10 à 15 minutes maximum.');
    } else {
      solutions.add('👉 Planifier une session courte, claire et concrète dans la journée.');
    }

    solutions.add('👉 Demander une aide ciblée à une personne fiable ou un service adapté.');
    solutions.add('👉 Remettre la solution à l’échelle du besoin réel et non du besoin idéal.');

    return solutions;
  }

  static List<String> generateQuestions(ProblemModel problem) {
    return [
      'Qu’est-ce qui est vraiment urgent ?',
      'Qu’est-ce qu’il faut résoudre aujourd’hui ?',
      'Qu’est-ce que tu peux faire avec ce que tu as ?',
      'Quel est le prochain petit pas le plus simple ?',
      'Est-ce que cette solution est assez bonne pour aujourd’hui ?',
    ];
  }
}
