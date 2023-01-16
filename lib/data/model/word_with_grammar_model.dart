import 'dart:convert';

/// id : 1
/// word : ""
/// g_id : ""
/// g_body : ""

WordWithGrammarModel wordWithGrammarFromJson(String str) => WordWithGrammarModel.fromJson(json.decode(str));

String wordWithGrammarToJson(WordWithGrammarModel data) => json.encode(data.toJson());

class WordWithGrammarModel {
  WordWithGrammarModel({
    int? id,
    String? word,
    int? gId,
    String? gBody,
  }) {
    _id = id;
    _word = word;
    _gId = gId;
    _gBody = gBody;
  }

  WordWithGrammarModel.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _gId = json['g_id'];
    _gBody = json['g_body'];
  }

  int? _id;
  String? _word;
  int? _gId;
  String? _gBody;

  WordWithGrammarModel copyWith({
    int? id,
    String? word,
    int? gId,
    String? gBody,
  }) =>
      WordWithGrammarModel(
        id: id ?? _id,
        word: word ?? _word,
        gId: gId ?? _gId,
        gBody: gBody ?? _gBody,
      );

  int? get id => _id;

  String? get word => _word;

  int? get gId => _gId;

  String? get gBody => _gBody;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['g_id'] = _gId;
    map['g_body'] = _gBody;
    return map;
  }
}
