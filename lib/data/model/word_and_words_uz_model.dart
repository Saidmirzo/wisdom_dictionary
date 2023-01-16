import 'dart:convert';
/// id : 1
/// word_class : ""
/// star : ""
/// word : ""

WordAndWordsUzModel wordAndWordsUzModelFromJson(String str) => WordAndWordsUzModel.fromJson(json.decode(str));
String wordAndWordsUzModelToJson(WordAndWordsUzModel data) => json.encode(data.toJson());
class WordAndWordsUzModel {
  WordAndWordsUzModel({
      int? id, 
      String? wordClass, 
      String? star, 
      String? word,}){
    _id = id;
    _wordClass = wordClass;
    _star = star;
    _word = word;
}

  WordAndWordsUzModel.fromJson(dynamic json) {
    _id = json['id'];
    _wordClass = json['word_class'];
    _star = json['star'];
    _word = json['word'];
  }
  int? _id;
  String? _wordClass;
  String? _star;
  String? _word;
WordAndWordsUzModel copyWith({  int? id,
  String? wordClass,
  String? star,
  String? word,
}) => WordAndWordsUzModel(  id: id ?? _id,
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