class ExerciseModel {
  ExerciseModel({
    required this.id,
    required this.word,
    required this.wordClass,
    required this.wordClassBody,
    required this.translation,
    required this.example,
  });

  final int id;
  final String word;
  final String wordClass;
  final String wordClassBody;
  final String translation;
  final String example;
}

class ExerciseFinalModel {
  ExerciseFinalModel({
    required this.id,
    required this.word,
    required this.translation,
    required this.result,
  });

  @override
  bool operator ==(Object other) {
    return (other is ExerciseFinalModel) &&
        other.id == id &&
        other.word == word &&
        other.translation == translation &&
        other.result == result;
  }

  @override
  int get hashCode => id.hashCode ^ word.hashCode ^ translation.hashCode ^ result.hashCode;

  final int id;
  final String word;
  final String translation;
  final bool result;
}
