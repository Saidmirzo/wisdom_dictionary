import 'dart:convert';
/// id : 1
/// word : ""
/// m_id : 1
/// m_body : ""

WordWithMetaphorModel wordWithMetaphorModelFromJson(String str) => WordWithMetaphorModel.fromJson(json.decode(str));
String wordWithMetaphorModelToJson(WordWithMetaphorModel data) => json.encode(data.toJson());
class WordWithMetaphorModel {
  WordWithMetaphorModel({
      int? id, 
      String? word, 
      int? mId, 
      String? mBody,}){
    _id = id;
    _word = word;
    _mId = mId;
    _mBody = mBody;
}

  WordWithMetaphorModel.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _mId = json['m_id'];
    _mBody = json['m_body'];
  }
  int? _id;
  String? _word;
  int? _mId;
  String? _mBody;
WordWithMetaphorModel copyWith({  int? id,
  String? word,
  int? mId,
  String? mBody,
}) => WordWithMetaphorModel(  id: id ?? _id,
  word: word ?? _word,
  mId: mId ?? _mId,
  mBody: mBody ?? _mBody,
);
  int? get id => _id;
  String? get word => _word;
  int? get mId => _mId;
  String? get mBody => _mBody;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['m_id'] = _mId;
    map['m_body'] = _mBody;
    return map;
  }

}