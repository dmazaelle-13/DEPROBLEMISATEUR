import 'package:flutter/material.dart';

class ProblemModel {
  final String title;
  final String description;
  final String urgency;
  final String energy;
  final String budget;
  final String timeAvailable;

  const ProblemModel({
    required this.title,
    required this.description,
    required this.urgency,
    required this.energy,
    required this.budget,
    required this.timeAvailable,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'urgency': urgency,
      'energy': energy,
      'budget': budget,
      'timeAvailable': timeAvailable,
    };
  }

  factory ProblemModel.fromMap(Map<String, dynamic> map) {
    return ProblemModel(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      urgency: map['urgency'] ?? 'Moyenne',
      energy: map['energy'] ?? 'Moyenne',
      budget: map['budget'] ?? 'Modéré',
      timeAvailable: map['timeAvailable'] ?? 'Peu de temps',
    );
  }
}
