import 'dart:convert';
/// parentId : 1
/// wordId : 1
/// translation : ""
/// word : ""

SpeakingViewModel speakingViewModelFromJson(String str) => SpeakingViewModel.fromJson(json.decode(str));
String speakingViewModelToJson(SpeakingViewModel data) => json.encode(data.toJson());
class SpeakingViewModel {
  SpeakingViewModel({
      int? parentId, 
      int? wordId, 
      String? translation, 
      String? word,}){
    _parentId = parentId;
    _wordId = wordId;
    _translation = translation;
    _word = word;
}

  SpeakingViewModel.fromJson(dynamic json) {
    _parentId = json['parentId'];
    _wordId = json['wordId'];
    _translation = json['translation'];
    _word = json['word'];
  }
  int? _parentId;
  int? _wordId;
  String? _translation;
  String? _word;
SpeakingViewModel copyWith({  int? parentId,
  int? wordId,
  String? translation,
  String? word,
}) => SpeakingViewModel(  parentId: parentId ?? _parentId,
  wordId: wordId ?? _wordId,
  translation: translation ?? _translation,
  word: word ?? _word,
);
  int? get parentId => _parentId;
  int? get wordId => _wordId;
  String? get translation => _translation;
  String? get word => _word;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['parentId'] = _parentId;
    map['wordId'] = _wordId;
    map['translation'] = _translation;
    map['word'] = _word;
    return map;
  }

}