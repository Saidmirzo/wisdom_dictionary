import 'dart:convert';

/// tableId : 1
/// id : 2
/// category : ""
/// word : ""
/// wordenid : 1
/// wordenword : ""
/// title : ""

CatalogModel catalogModelFromJson(String str) => CatalogModel.fromJson(json.decode(str));

String catalogModelToJson(CatalogModel data) => json.encode(data.toJson());

class CatalogModel {
  CatalogModel({
    int? tableId,
    int? id,
    String? category,
    String? word,
    int? wordenid,
    String? wordenword,
    String? title,
  }) {
    _tableId = tableId;
    _id = id;
    _category = category;
    _word = word;
    _wordenid = wordenid;
    _wordenword = wordenword;
    _title = title;
  }

  CatalogModel.fromJson(dynamic json) {
    _tableId = json['tableId'];
    _id = json['id'];
    _category = json['category'];
    _word = json['word'];
    _wordenid = json['wordenid'];
    _wordenword = json['wordenword'];
    _title = json['title'];
  }

  int? _tableId;
  int? _id;
  String? _category;
  String? _word;
  int? _wordenid;
  String? _wordenword;
  String? _title;

  CatalogModel copyWith({
    int? tableId,
    int? id,
    String? category,
    String? word,
    int? wordenid,
    String? wordenword,
    String? title,
  }) =>
      CatalogModel(
        tableId: tableId ?? _tableId,
        id: id ?? _id,
        category: category ?? _category,
        word: word ?? _word,
        wordenid: wordenid ?? _wordenid,
        wordenword: wordenword ?? _wordenword,
        title: title ?? _title,
      );

  int? get tableId => _tableId;

  int? get id => _id;

  String? get category => _category;

  String? get word => _word;

  int? get wordenid => _wordenid;

  String? get wordenword => _wordenword;

  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tableId'] = _tableId;
    map['id'] = _id;
    map['category'] = _category;
    map['word'] = _word;
    map['wordenid'] = _wordenid;
    map['wordenword'] = _wordenword;
    map['title'] = _title;
    return map;
  }

  set title(String? value) {
    _title = value;
  }

  set wordenword(String? value) {
    _wordenword = value;
  }

  set wordenid(int? value) {
    _wordenid = value;
  }

  set word(String? value) {
    _word = value;
  }

  set category(String? value) {
    _category = value;
  }

  set id(int? value) {
    _id = value;
  }

  set tableId(int? value) {
    _tableId = value;
  }
}
