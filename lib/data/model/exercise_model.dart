class ExerciseModel {
  ExerciseModel({
    required this.id,
    required this.word,
  });

  final int id;
  final String word;
}

class ExerciseFinalModel {
  ExerciseFinalModel({
    required this.id,
    required this.word,
    required this.translation,
    required this.result,
    required this.number,
  });

  final int id;
  final String word;
  final String translation;
  final bool result;
  final String number;
}
