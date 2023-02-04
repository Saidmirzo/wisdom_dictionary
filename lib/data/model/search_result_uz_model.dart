import 'dart:convert';

/// id : 1
/// word : ""
/// word_class : ""
/// type : ""
/// star : 0
/// same : ["",""]

SearchResultUzModel searchResultUzModelFromJson(String str) => SearchResultUzModel.fromJson(json.decode(str));

String searchResultUzModelToJson(SearchResultUzModel data) => json.encode(data.toJson());

class SearchResultUzModel {
  SearchResultUzModel({
    int? id,
    String? word,
    String? wordClass,
    String? type,
    int? star,
    List<String>? same,
  }) {
    _id = id;
    _word = word;
    _wordClass = wordClass;
    _type = type;
    _star = star;
    _same = same;
  }

  SearchResultUzModel.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _wordClass = json['word_class'];
    _type = json['type'];
    _star = json['star'];
    _same = json['same'] != null ? json['same'].cast<String>() : [];
  }

  int? _id;
  String? _word;
  String? _wordClass;
  String? _type;
  int? _star;
  List<String>? _same;

  SearchResultUzModel copyWith({
    int? id,
    String? word,
    String? wordClass,
    String? type,
    int? star,
    List<String>? same,
  }) =>
      SearchResultUzModel(
        id: id ?? _id,
        word: word ?? _word,
        wordClass: wordClass ?? _wordClass,
        type: type ?? _type,
        star: star ?? _star,
        same: same ?? _same,
      );

  int? get id => _id;

  String? get word => _word;

  String? get wordClass => _wordClass;

  String? get type => _type;

  int? get star => _star;

  List<String>? get same => _same;

  set same(List<String>? value) {
    _same = value;
  }

  @override
  String toString() {
    return _same.toString().replaceAll('[', '').replaceAll(']', '');
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['word_class'] = _wordClass;
    map['type'] = _type;
    map['star'] = _star;
    map['same'] = _same;
    return map;
  }
}
