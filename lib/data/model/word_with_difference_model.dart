import 'dart:convert';
/// d_id : 1
/// d_word : ""
/// d_body : ""

WordWithDifferenceModel wordWithDifferenceFromJson(String str) => WordWithDifferenceModel.fromJson(json.decode(str));
String wordWithDifferenceToJson(WordWithDifferenceModel data) => json.encode(data.toJson());
class WordWithDifferenceModel {
  WordWithDifferenceModel({
      int? dId, 
      String? dWord, 
      String? dBody,}){
    _dId = dId;
    _dWord = dWord;
    _dBody = dBody;
}

  WordWithDifferenceModel.fromJson(dynamic json) {
    _dId = json['d_id'];
    _dWord = json['d_word'];
    _dBody = json['d_body'];
  }
  int? _dId;
  String? _dWord;
  String? _dBody;
WordWithDifferenceModel copyWith({  int? dId,
  String? dWord,
  String? dBody,
}) => WordWithDifferenceModel(  dId: dId ?? _dId,
  dWord: dWord ?? _dWord,
  dBody: dBody ?? _dBody,
);
  int? get dId => _dId;
  String? get dWord => _dWord;
  String? get dBody => _dBody;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['d_id'] = _dId;
    map['d_word'] = _dWord;
    map['d_body'] = _dBody;
    return map;
  }

}