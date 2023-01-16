import 'dart:convert';

/// id : 43
/// version : 1649925522
/// type : "words"
/// files : [{"path":"offline/version-43/words-1.json"}]

WordPathModel wordPathModelFromJson(String str) => WordPathModel.fromJson(json.decode(str));

String wordPathModelToJson(WordPathModel data) => json.encode(data.toJson());

class WordPathModel {
  WordPathModel({
    int? id,
    int? version,
    String? type,
    List<Files>? files,
  }) {
    _id = id;
    _version = version;
    _type = type;
    _files = files;
  }

  WordPathModel.fromJson(dynamic json) {
    _id = json['id'];
    _version = json['version'];
    _type = json['type'];
    if (json['files'] != null) {
      _files = [];
      json['files'].forEach((v) {
        _files?.add(Files.fromJson(v));
      });
    }
  }

  int? _id;
  int? _version;
  String? _type;
  List<Files>? _files;

  WordPathModel copyWith({
    int? id,
    int? version,
    String? type,
    List<Files>? files,
  }) =>
      WordPathModel(
        id: id ?? _id,
        version: version ?? _version,
        type: type ?? _type,
        files: files ?? _files,
      );

  int? get id => _id;

  int? get version => _version;

  String? get type => _type;

  List<Files>? get files => _files;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['version'] = _version;
    map['type'] = _type;
    if (_files != null) {
      map['files'] = _files?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// path : "offline/version-43/words-1.json"

Files filesFromJson(String str) => Files.fromJson(json.decode(str));

String filesToJson(Files data) => json.encode(data.toJson());

class Files {
  Files({
    String? path,
  }) {
    _path = path;
  }

  Files.fromJson(dynamic json) {
    _path = json['path'];
  }

  String? _path;

  Files copyWith({
    String? path,
  }) =>
      Files(
        path: path ?? _path,
      );

  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['path'] = _path;
    return map;
  }
}
