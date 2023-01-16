class ParentPhrasesTranslateModel {
  ParentPhrasesTranslateModel({
      this.id, 
      this.word, 
      this.phraseId, 
      this.parentPhraseId,});

  ParentPhrasesTranslateModel.fromJson(dynamic json) {
    id = json['id'];
    word = json['word'];
    phraseId = json['phrase_id'];
    parentPhraseId = json['parent_phrase_id'];
  }
  int? id;
  String? word;
  int? phraseId;
  int? parentPhraseId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['word'] = word;
    map['phrase_id'] = phraseId;
    map['parent_phrase_id'] = parentPhraseId;
    return map;
  }

}