class PhrasesTranslateModel {
  PhrasesTranslateModel({
      this.id, 
      this.phrasesId, 
      this.word,});

  PhrasesTranslateModel.fromJson(dynamic json) {
    id = json['id'];
    phrasesId = json['phrases_id'];
    word = json['word'];
  }
  int? id;
  int? phrasesId;
  String? word;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['phrases_id'] = phrasesId;
    map['word'] = word;
    return map;
  }

}