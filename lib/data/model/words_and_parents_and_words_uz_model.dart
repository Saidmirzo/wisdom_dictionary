import 'dart:convert';
/// id : 1
/// word_class : ""
/// star : ""
/// word : ""

WordsAndParentsAndWordsUzModel wordsAndParentsAndWordsUzModelFromJson(String str) => WordsAndParentsAndWordsUzModel.fromJson(json.decode(str));
String wordsAndParentsAndWordsUzModelToJson(WordsAndParentsAndWordsUzModel data) => json.encode(data.toJson());
class WordsAndParentsAndWordsUzModel {
  WordsAndParentsAndWordsUzModel({
      int? id, 
      String? wordClass, 
      String? star, 
      String? word,}){
    _id = id;
    _wordClass = wordClass;
    _star = star;
    _word = word;
}

  WordsAndParentsAndWordsUzModel.fromJson(dynamic json) {
    _id = json['id'];
    _wordClass = json['word_class'];
    _star = json['star'];
    _word = json['word'];
  }
  int? _id;
  String? _wordClass;
  String? _star;
  String? _word;
WordsAndParentsAndWordsUzModel copyWith({  int? id,
  String? wordClass,
  String? star,
  String? word,
}) => WordsAndParentsAndWordsUzModel(  id: id ?? _id,
  wordClass: wordClass ?? _wordClass,
  star: star ?? _star,
  word: word ?? _word,
);
  int? get id => _id;
  String? get wordClass => _wordClass;
  String? get star => _star;
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