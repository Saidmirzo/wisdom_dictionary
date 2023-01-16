import 'dart:convert';
/// id : 1
/// word_class : ""
/// star : 1
/// word : ""

WordAndParentsAndPhrasesParentPhrasesAndTranslateModel wordAndParentsAndPhrasesParentPhrasesAndTranslateModelFromJson(String str) => WordAndParentsAndPhrasesParentPhrasesAndTranslateModel.fromJson(json.decode(str));
String wordAndParentsAndPhrasesParentPhrasesAndTranslateModelToJson(WordAndParentsAndPhrasesParentPhrasesAndTranslateModel data) => json.encode(data.toJson());
class WordAndParentsAndPhrasesParentPhrasesAndTranslateModel {
  WordAndParentsAndPhrasesParentPhrasesAndTranslateModel({
      int? id, 
      String? wordClass, 
      int? star, 
      String? word,}){
    _id = id;
    _wordClass = wordClass;
    _star = star;
    _word = word;
}

  WordAndParentsAndPhrasesParentPhrasesAndTranslateModel.fromJson(dynamic json) {
    _id = json['id'];
    _wordClass = json['word_class'];
    _star = json['star'];
    _word = json['word'];
  }
  int? _id;
  String? _wordClass;
  int? _star;
  String? _word;
WordAndParentsAndPhrasesParentPhrasesAndTranslateModel copyWith({  int? id,
  String? wordClass,
  int? star,
  String? word,
}) => WordAndParentsAndPhrasesParentPhrasesAndTranslateModel(  id: id ?? _id,
  wordClass: wordClass ?? _wordClass,
  star: star ?? _star,
  word: word ?? _word,
);
  int? get id => _id;
  String? get wordClass => _wordClass;
  int? get star => _star;
  String? get word => _word;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word_class'] = _wordClass;
    map['star'] = _star;
    map['word'] = _word;
    return map;
  }

}