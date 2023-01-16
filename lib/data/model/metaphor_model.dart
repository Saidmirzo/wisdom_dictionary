class MetaphorModel {
  MetaphorModel({
    this.id,
    this.wordId,
    this.body,
  });

  MetaphorModel.fromJson(dynamic json) {
    id = json['id'];
    wordId = json['word_id'];
    body = json['body'];
  }

  int? id;
  int? wordId;
  String? body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['word_id'] = wordId;
    map['body'] = body;
    return map;
  }
}
