import 'dart:convert';

/// id : 1
/// name : {"uz":"","en":""}
/// days : 1
/// price : 1

TariffsModel tariffsModelFromJson(String str) => TariffsModel.fromJson(json.decode(str));

String tariffsModelToJson(TariffsModel data) => json.encode(data.toJson());

class TariffsModel {
  TariffsModel({
    int? id,
    Name? name,
    int? days,
    int? price,
  }) {
    _id = id;
    _name = name;
    _days = days;
    _price = price;
  }

  TariffsModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'] != null ? Name.fromJson(json['name']) : null;
    _days = json['days'];
    _price = json['price'];
  }

  int? _id;
  Name? _name;
  int? _days;
  int? _price;

  TariffsModel copyWith({
    int? id,
    Name? name,
    int? days,
    int? price,
  }) =>
      TariffsModel(
        id: id ?? _id,
        name: name ?? _name,
        days: days ?? _days,
        price: price ?? _price,
      );

  int? get id => _id;

  Name? get name => _name;

  int? get days => _days;

  int? get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_name != null) {
      map['name'] = _name?.toJson();
    }
    map['days'] = _days;
    map['price'] = _price;
    return map;
  }
}

/// uz : ""
/// en : ""

Name nameFromJson(String str) => Name.fromJson(json.decode(str));

String nameToJson(Name data) => json.encode(data.toJson());

class Name {
  Name({
    String? uz,
    String? en,
  }) {
    _uz = uz;
    _en = en;
  }

  Name.fromJson(dynamic json) {
    _uz = json['uz'];
    _en = json['en'];
  }

  String? _uz;
  String? _en;

  Name copyWith({
    String? uz,
    String? en,
  }) =>
      Name(
        uz: uz ?? _uz,
        en: en ?? _en,
      );

  String? get uz => _uz;

  String? get en => _en;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['uz'] = _uz;
    map['en'] = _en;
    return map;
  }
}
