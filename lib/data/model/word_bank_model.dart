import 'dart:convert';

/// id : 1
/// word : ""
/// translation : ""
/// number : 1
/// example : ""
/// created_at : ""

WordBankModel wordBankModelFromJson(String str) => WordBankModel.fromJson(json.decode(str));

String wordBankModelToJson(WordBankModel data) => json.encode(data.toJson());

class WordBankModel {
  WordBankModel({
    int? id,
    String? word,
    String? translation,
    int? number,
    String? example,
    String? createdAt,
  }) {
    _id = id;
    _word = word;
    _translation = translation;
    _number = number;
    _example = example;
    _createdAt = createdAt;
  }

  WordBankModel.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _translation = json['translation'];
    _number = json['number'];
    _example = json['example'];
    _createdAt = json['created_at'];
  }

  int? _id;
  String? _word;
  String? _translation;
  int? _number;
  String? _example;
  String? _createdAt;

  WordBankModel copyWith({
    int? id,
    String? word,
    String? translation,
    int? number,
    String? example,
    String? createdAt,
  }) =>
      WordBankModel(
        id: id ?? _id,
        word: word ?? _word,
        translation: translation ?? _translation,
        number: number ?? _number,
        example: example ?? _example,
        createdAt: createdAt ?? _createdAt,
      );

  int? get id => _id;

  String? get word => _word;

  String? get translation => _translation;

  int? get number => _number;

  String? get example => _example;

  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['translation'] = _translation;
    map['number'] = _number;
    map['example'] = _example;
    map['created_at'] = _createdAt;
    return map;
  }
}
