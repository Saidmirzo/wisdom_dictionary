import 'dart:convert';

/// id : 1
/// word : ""
/// c_id : 1
/// c_body : ""

WordWithCollocationModel wordWithCollocationModelFromJson(String str) =>
    WordWithCollocationModel.fromJson(json.decode(str));

String wordWithCollocationModelToJson(WordWithCollocationModel data) => json.encode(data.toJson());

class WordWithCollocationModel {
  WordWithCollocationModel({
    int? id,
    String? word,
    int? cId,
    String? cBody,
  }) {
    _id = id;
    _word = word;
    _cId = cId;
    _cBody = cBody;
  }

  WordWithCollocationModel.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _cId = json['c_id'];
    _cBody = json['c_body'];
  }

  int? _id;
  String? _word;
  int? _cId;
  String? _cBody;

  WordWithCollocationModel copyWith({
    int? id,
    String? word,
    int? cId,
    String? cBody,
  }) =>
      WordWithCollocationModel(
        id: id ?? _id,
        word: word ?? _word,
        cId: cId ?? _cId,
        cBody: cBody ?? _cBody,
      );

  int? get id => _id;

  String? get word => _word;

  int? get cId => _cId;

  String? get cBody => _cBody;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['c_id'] = _cId;
    map['c_body'] = _cBody;
    return map;
  }
}
