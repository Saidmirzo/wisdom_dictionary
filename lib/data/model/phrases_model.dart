class PhrasesModel {
  PhrasesModel({
      this.pId, 
      this.pWordId, 
      this.pWord, 
      this.pStar, 
      this.pSynonyms, 
      this.pWordClassComment, 
      this.pParentPhrase,});

  PhrasesModel.fromJson(dynamic json) {
    pId = json['p_id'];
    pWordId = json['p_word_id'];
    pWord = json['p_word'];
    pStar = json['p_star'];
    pSynonyms = json['p_synonyms'];
    pWordClassComment = json['p_word_class_comment'];
    pParentPhrase = json['p_parent_phrase'];
  }
  int? pId;
  int? pWordId;
  String? pWord;
  int? pStar;
  String? pSynonyms;
  String? pWordClassComment;
  String? pParentPhrase;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['p_id'] = pId;
    map['p_word_id'] = pWordId;
    map['p_word'] = pWord;
    map['p_star'] = pStar;
    map['p_synonyms'] = pSynonyms;
    map['p_word_class_comment'] = pWordClassComment;
    map['p_parent_phrase'] = pParentPhrase;
    return map;
  }

}