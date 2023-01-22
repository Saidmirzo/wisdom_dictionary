class WordsUzModel {
  WordsUzModel({
    this.id,
    this.wordId,
    this.word,
  });

  WordsUzModel.fromJson(dynamic json) {
    id = json['id'];
    wordId = json['word_id'];
    word = json['word'];
  }

  int? id;
  int? wordId;
  String? word;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['word_id'] = wordId;
    map['word'] = word;
    return map;
  }
}
