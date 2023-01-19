import 'dart:convert';

/// id : 1
/// word : ""
/// word_classid : 1
/// word_classword_id : ""
/// word_classword_class : ""
/// type : ""

SearchResultModel searchResultModelFromJson(String str) => SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) => json.encode(data.toJson());

class SearchResultModel {
  SearchResultModel({
    int? id,
    String? word,
    int? wordClassid,
    int? wordClasswordId,
    String? wordClasswordClass,
    String? type,
  }) {
    _id = id;
    _word = word;
    _wordClassid = wordClassid;
    _wordClasswordId = wordClasswordId;
    _wordClasswordClass = wordClasswordClass;
    _type = type;
  }

  SearchResultModel.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _wordClassid = json['word_classid'];
    _wordClasswordId = json['word_classword_id'];
    _wordClasswordClass = json['word_classword_class'];
    _type = json['type'];
  }

  int? _id;
  String? _word;
  int? _wordClassid;
  int? _wordClasswordId;
  String? _wordClasswordClass;
  String? _type;

  SearchResultModel copyWith({
    int? id,
    String? word,
    int? wordClassid,
    int? wordClasswordId,
    String? wordClasswordClass,
    String? type,
  }) =>
      SearchResultModel(
        id: id ?? _id,
        word: word ?? _word,
        wordClassid: wordClassid ?? _wordClassid,
        wordClasswordId: wordClasswordId ?? _wordClasswordId,
        wordClasswordClass: wordClasswordClass ?? _wordClasswordClass,
        type: type ?? _type,
      );

  int? get id => _id;

  String? get word => _word;

  int? get wordClassid => _wordClassid;

  int? get wordClasswordId => _wordClasswordId;

  String? get wordClasswordClass => _wordClasswordClass;

  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['word_classid'] = _wordClassid;
    map['word_classword_id'] = _wordClasswordId;
    map['word_classword_class'] = _wordClasswordClass;
    map['type'] = _type;
    return map;
  }
}
