class PhrasesExampleModel {
  PhrasesExampleModel({
      this.id, 
      this.phraseId, 
      this.value,});

  PhrasesExampleModel.fromJson(dynamic json) {
    id = json['id'];
    phraseId = json['phrase_id'];
    value = json['value'];
  }
  int? id;
  int? phraseId;
  String? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['phrase_id'] = phraseId;
    map['value'] = value;
    return map;
  }

}