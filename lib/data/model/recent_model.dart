import 'dart:convert';
/// id : 1
/// word : ""
/// word_class : ""
/// type : ""
/// same : ""

RecentModel recentModelFromJson(String str) => RecentModel.fromJson(json.decode(str));
String recentModelToJson(RecentModel data) => json.encode(data.toJson());
class RecentModel {
  RecentModel({
      int? id, 
      String? word, 
      String? wordClass, 
      String? type, 
      String? same,}){
    _id = id;
    _word = word;
    _wordClass = wordClass;
    _type = type;
    _same = same;
}

  RecentModel.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _wordClass = json['word_class'];
    _type = json['type'];
    _same = json['same'];
  }
  int? _id;
  String? _word;
  String? _wordClass;
  String? _type;
  String? _same;
RecentModel copyWith({  int? id,
  String? word,
  String? wordClass,
  String? type,
  String? same,
}) => RecentModel(  id: id ?? _id,
  word: word ?? _word,
  wordClass: wordClass ?? _wordClass,
  type: type ?? _type,
  same: same ?? _same,
);
  int? get id => _id;
  String? get word => _word;
  String? get wordClass => _wordClass;
  String? get type => _type;
  String? get same => _same;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['word_class'] = _wordClass;
    map['type'] = _type;
    map['same'] = _same;
    return map;
  }

}