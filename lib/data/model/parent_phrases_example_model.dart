class ParentPhrasesExampleModel {
  ParentPhrasesExampleModel({
      this.id, 
      this.value, 
      this.phraseId,});

  ParentPhrasesExampleModel.fromJson(dynamic json) {
    id = json['id'];
    value = json['value'];
    phraseId = json['phrase_id'];
  }
  int? id;
  String? value;
  int? phraseId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['value'] = value;
    map['phrase_id'] = phraseId;
    return map;
  }

}