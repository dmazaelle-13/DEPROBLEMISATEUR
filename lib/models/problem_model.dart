class ProblemModel {
  final String id;
  final String title;
  final String description;
  final String urgency;
  final String energy;
  final String budget;
  final String timeAvailable;
  final String createdAt;
  final bool completed;

  const ProblemModel({
    required this.title,
    required this.description,
    required this.urgency,
    required this.energy,
    required this.budget,
    required this.timeAvailable,
    this.id = '',
    this.createdAt = '',
    this.completed = false,
  });

  ProblemModel copyWith({String? id, String? createdAt, bool? completed}) {
    return ProblemModel(
      id: id ?? this.id,
      title: title,
      description: description,
      urgency: urgency,
      energy: energy,
      budget: budget,
      timeAvailable: timeAvailable,
      createdAt: createdAt ?? this.createdAt,
      completed: completed ?? this.completed,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'urgency': urgency,
        'energy': energy,
        'budget': budget,
        'timeAvailable': timeAvailable,
        'createdAt': createdAt,
        'completed': completed,
      };

  factory ProblemModel.fromMap(Map<String, dynamic> map) => ProblemModel(
        id: map['id'] as String? ?? '',
        title: map['title'] as String? ?? '',
        description: map['description'] as String? ?? '',
        urgency: map['urgency'] as String? ?? 'Moyenne',
        energy: map['energy'] as String? ?? 'Moyenne',
        budget: map['budget'] as String? ?? 'Modéré',
        timeAvailable: map['timeAvailable'] as String? ?? 'Peu de temps',
        createdAt: map['createdAt'] as String? ?? '',
        completed: map['completed'] as bool? ?? false,
      );
}
