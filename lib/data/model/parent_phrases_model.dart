class ParentPhrasesModel {
  ParentPhrasesModel({
      this.id, 
      this.phraseId, 
      this.word, 
      this.star, 
      this.symonyms, 
      this.wordClassComment, 
      this.parentPhrase,});

  ParentPhrasesModel.fromJson(dynamic json) {
    id = json['id'];
    phraseId = json['phrase_id'];
    word = json['word'];
    star = json['star'];
    symonyms = json['symonyms'];
    wordClassComment = json['word_class_comment'];
    parentPhrase = json['parent_phrase'];
  }
  int? id;
  int? phraseId;
  String? word;
  int? star;
  String? symonyms;
  String? wordClassComment;
  String? parentPhrase;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['phrase_id'] = phraseId;
    map['word'] = word;
    map['star'] = star;
    map['symonyms'] = symonyms;
    map['word_class_comment'] = wordClassComment;
    map['parent_phrase'] = parentPhrase;
    return map;
  }

}