import 'dart:convert';
/// id : 1
/// word_class : ""
/// p_star : 1
/// word : ""

WordAndPhrasesAndTranslateModel wordAndPhrasesAndTranslateModelFromJson(String str) => WordAndPhrasesAndTranslateModel.fromJson(json.decode(str));
String wordAndPhrasesAndTranslateModelToJson(WordAndPhrasesAndTranslateModel data) => json.encode(data.toJson());
class WordAndPhrasesAndTranslateModel {
  WordAndPhrasesAndTranslateModel({
      int? id, 
      String? wordClass, 
      int? pStar, 
      String? word,}){
    _id = id;
    _wordClass = wordClass;
    _pStar = pStar;
    _word = word;
}

  WordAndPhrasesAndTranslateModel.fromJson(dynamic json) {
    _id = json['id'];
    _wordClass = json['word_class'];
    _pStar = json['p_star'];
    _word = json['word'];
  }
  int? _id;
  String? _wordClass;
  int? _pStar;
  String? _word;
WordAndPhrasesAndTranslateModel copyWith({  int? id,
  String? wordClass,
  int? pStar,
  String? word,
}) => WordAndPhrasesAndTranslateModel(  id: id ?? _id,
  wordClass: wordClass ?? _wordClass,
  pStar: pStar ?? _pStar,
  word: word ?? _word,
);
  int? get id => _id;
  String? get wordClass => _wordClass;
  int? get pStar => _pStar;
  String? get word => _word;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word_class'] = _wordClass;
    map['p_star'] = _pStar;
    map['word'] = _word;
    return map;
  }

}