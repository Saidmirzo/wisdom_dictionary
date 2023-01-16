import 'dart:convert';

/// id  : 1
/// word : ""
/// d_id : 1
/// d_word : ""

WordWithDifferenceNewModel wordWithDifferenceNewModelFromJson(String str) =>
    WordWithDifferenceNewModel.fromJson(json.decode(str));

String wordWithDifferenceNewModelToJson(WordWithDifferenceNewModel data) => json.encode(data.toJson());

class WordWithDifferenceNewModel {
  WordWithDifferenceNewModel({
    int? id,
    String? word,
    int? dId,
    String? dWord,
  }) {
    _id = id;
    _word = word;
    _dId = dId;
    _dWord = dWord;
  }

  WordWithDifferenceNewModel.fromJson(dynamic json) {
    _id = json['id '];
    _word = json['word'];
    _dId = json['d_id'];
    _dWord = json['d_word'];
  }

  int? _id;
  String? _word;
  int? _dId;
  String? _dWord;

  WordWithDifferenceNewModel copyWith({
    int? id,
    String? word,
    int? dId,
    String? dWord,
  }) =>
      WordWithDifferenceNewModel(
        id: id ?? _id,
        word: word ?? _word,
        dId: dId ?? _dId,
        dWord: dWord ?? _dWord,
      );

  int? get id => _id;

  String? get word => _word;

  int? get dId => _dId;

  String? get dWord => _dWord;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id '] = _id;
    map['word'] = _word;
    map['d_id'] = _dId;
    map['d_word'] = _dWord;
    return map;
  }
}
