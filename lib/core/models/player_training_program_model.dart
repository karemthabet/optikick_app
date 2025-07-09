class TrainingProgram {
  final String focusArea;
  final List<String> exercises;

  TrainingProgram({required this.focusArea, required this.exercises});

  factory TrainingProgram.fromJson(Map<String, dynamic> json) {
    return TrainingProgram(
      focusArea: json['focus_area'],
      exercises: List<String>.from(json['exercises']),
    );
  }
}
