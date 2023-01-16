class DifferenceModel {
  DifferenceModel({
      this.id, 
      this.wordId, 
      this.word, 
      this.body,});

  DifferenceModel.fromJson(dynamic json) {
    id = json['id'];
    wordId = json['word_id'];
    word = json['word'];
    body = json['body'];
  }

  int? id;
  int? wordId;
  String? word;
  String? body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['word_id'] = wordId;
    map['word'] = word;
    map['body'] = body;
    return map;
  }

}