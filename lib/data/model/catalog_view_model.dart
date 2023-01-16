import 'dart:convert';
/// id : 1
/// body : ""
/// word : ""
/// status : true
/// error : 1

CatalogViewModel catalogViewModelFromJson(String str) => CatalogViewModel.fromJson(json.decode(str));
String catalogViewModelToJson(CatalogViewModel data) => json.encode(data.toJson());
class CatalogViewModel {
  CatalogViewModel({
      int? id, 
      String? body, 
      String? word, 
      bool? status, 
      int? error,}){
    _id = id;
    _body = body;
    _word = word;
    _status = status;
    _error = error;
}

  CatalogViewModel.fromJson(dynamic json) {
    _id = json['id'];
    _body = json['body'];
    _word = json['word'];
    _status = json['status'];
    _error = json['error'];
  }
  int? _id;
  String? _body;
  String? _word;
  bool? _status;
  int? _error;
CatalogViewModel copyWith({  int? id,
  String? body,
  String? word,
  bool? status,
  int? error,
}) => CatalogViewModel(  id: id ?? _id,
  body: body ?? _body,
  word: word ?? _word,
  status: status ?? _status,
  error: error ?? _error,
);
  int? get id => _id;
  String? get body => _body;
  String? get word => _word;
  bool? get status => _status;
  int? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['body'] = _body;
    map['word'] = _word;
    map['status'] = _status;
    map['error'] = _error;
    return map;
  }

}