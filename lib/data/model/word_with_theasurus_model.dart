import 'dart:convert';
/// id : 1
/// word : ""
/// t_id : 2
/// t_body : ""

WordWithTheasurusModel wordWithTheasurusModelFromJson(String str) => WordWithTheasurusModel.fromJson(json.decode(str));
String wordWithTheasurusModelToJson(WordWithTheasurusModel data) => json.encode(data.toJson());
class WordWithTheasurusModel {
  WordWithTheasurusModel({
      int? id, 
      String? word, 
      int? tId, 
      String? tBody,}){
    _id = id;
    _word = word;
    _tId = tId;
    _tBody = tBody;
}

  WordWithTheasurusModel.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _tId = json['t_id'];
    _tBody = json['t_body'];
  }
  int? _id;
  String? _word;
  int? _tId;
  String? _tBody;
WordWithTheasurusModel copyWith({  int? id,
  String? word,
  int? tId,
  String? tBody,
}) => WordWithTheasurusModel(  id: id ?? _id,
  word: word ?? _word,
  tId: tId ?? _tId,
  tBody: tBody ?? _tBody,
);
  int? get id => _id;
  String? get word => _word;
  int? get tId => _tId;
  String? get tBody => _tBody;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['t_id'] = _tId;
    map['t_body'] = _tBody;
    return map;
  }

}