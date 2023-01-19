import 'dart:convert';
/// id : 1
/// word_classid : 1
/// word_classword_id : 1
/// word_classword_class : ""
/// p_word : ""

WordAndParentsAndPhrases wordAndParentsAndPhrasesFromJson(String str) => WordAndParentsAndPhrases.fromJson(json.decode(str));
String wordAndParentsAndPhrasesToJson(WordAndParentsAndPhrases data) => json.encode(data.toJson());
class WordAndParentsAndPhrases {
  WordAndParentsAndPhrases({
      int? id, 
      int? wordClassid, 
      int? wordClasswordId, 
      String? wordClasswordClass, 
      String? pWord,}){
    _id = id;
    _wordClassid = wordClassid;
    _wordClasswordId = wordClasswordId;
    _wordClasswordClass = wordClasswordClass;
    _pWord = pWord;
}

  WordAndParentsAndPhrases.fromJson(dynamic json) {
    _id = json['id'];
    _wordClassid = json['word_classid'];
    _wordClasswordId = json['word_classword_id'];
    _wordClasswordClass = json['word_classword_class'];
    _pWord = json['p_word'];
  }
  int? _id;
  int? _wordClassid;
  int? _wordClasswordId;
  String? _wordClasswordClass;
  String? _pWord;
WordAndParentsAndPhrases copyWith({  int? id,
  int? wordClassid,
  int? wordClasswordId,
  String? wordClasswordClass,
  String? pWord,
}) => WordAndParentsAndPhrases(  id: id ?? _id,
  wordClassid: wordClassid ?? _wordClassid,
  wordClasswordId: wordClasswordId ?? _wordClasswordId,
  wordClasswordClass: wordClasswordClass ?? _wordClasswordClass,
  pWord: pWord ?? _pWord,
);
  int? get id => _id;
  int? get wordClassid => _wordClassid;
  int? get wordClasswordId => _wordClasswordId;
  String? get wordClasswordClass => _wordClasswordClass;
  String? get pWord => _pWord;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word_classid'] = _wordClassid;
    map['word_classword_id'] = _wordClasswordId;
    map['word_classword_class'] = _wordClasswordClass;
    map['p_word'] = _pWord;
    return map;
  }

}