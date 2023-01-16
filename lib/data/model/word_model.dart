import 'dart:convert';

/// id : 32
/// word : "A2 (level)"
/// star : 0
/// body : ""
/// synonyms : ""
/// anthonims : ""
/// comment : ""
/// example : ""
/// link_word : ""
/// examples : ""
/// more_examples : ""
/// word_class_body : ""
/// word_class_body_meaning : ""
/// image : ""
/// word_classid : 1
/// word_classword_id : 1
/// word_classword_class : ""

WordModel wordModelFromJson(String str) => WordModel.fromJson(json.decode(str));

String wordModelToJson(WordModel data) => json.encode(data.toJson());

class WordModel {
  WordModel({
    int? id,
    String? word,
    String? star,
    String? body,
    String? synonyms,
    String? anthonims,
    String? comment,
    String? example,
    String? linkWord,
    String? examples,
    String? moreExamples,
    String? wordClassBody,
    String? wordClassBodyMeaning,
    String? image,
    int? wordClassid,
    int? wordClasswordId,
    String? wordClasswordClass,
  }) {
    _id = id;
    _word = word;
    _star = star;
    _body = body;
    _synonyms = synonyms;
    _anthonims = anthonims;
    _comment = comment;
    _example = example;
    _linkWord = linkWord;
    _examples = examples;
    _moreExamples = moreExamples;
    _wordClassBody = wordClassBody;
    _wordClassBodyMeaning = wordClassBodyMeaning;
    _image = image;
    _wordClassid = wordClassid;
    _wordClasswordId = wordClasswordId;
    _wordClasswordClass = wordClasswordClass;
  }

  WordModel.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _star = json['star'];
    _body = json['body'];
    _synonyms = json['synonyms'];
    _anthonims = json['anthonims'];
    _comment = json['comment'];
    _example = json['example'];
    _linkWord = json['link_word'];
    _examples = json['examples'];
    _moreExamples = json['more_examples'];
    _wordClassBody = json['word_class_body'];
    _wordClassBodyMeaning = json['word_class_body_meaning'];
    _image = json['image'];
    _wordClassid = json['word_classid'];
    _wordClasswordId = json['word_classword_id'];
    _wordClasswordClass = json['word_classword_class'];
  }

  int? _id;
  String? _word;
  String? _star;
  String? _body;
  String? _synonyms;
  String? _anthonims;
  String? _comment;
  String? _example;
  String? _linkWord;
  String? _examples;
  String? _moreExamples;
  String? _wordClassBody;
  String? _wordClassBodyMeaning;
  String? _image;
  int? _wordClassid;
  int? _wordClasswordId;
  String? _wordClasswordClass;

  WordModel copyWith({
    int? id,
    String? word,
    String? star,
    String? body,
    String? synonyms,
    String? anthonims,
    String? comment,
    String? example,
    String? linkWord,
    String? examples,
    String? moreExamples,
    String? wordClassBody,
    String? wordClassBodyMeaning,
    String? image,
    int? wordClassid,
    int? wordClasswordId,
    String? wordClasswordClass,
  }) =>
      WordModel(
        id: id ?? _id,
        word: word ?? _word,
        star: star ?? _star,
        body: body ?? _body,
        synonyms: synonyms ?? _synonyms,
        anthonims: anthonims ?? _anthonims,
        comment: comment ?? _comment,
        example: example ?? _example,
        linkWord: linkWord ?? _linkWord,
        examples: examples ?? _examples,
        moreExamples: moreExamples ?? _moreExamples,
        wordClassBody: wordClassBody ?? _wordClassBody,
        wordClassBodyMeaning: wordClassBodyMeaning ?? _wordClassBodyMeaning,
        image: image ?? _image,
        wordClassid: wordClassid ?? _wordClassid,
        wordClasswordId: wordClasswordId ?? _wordClasswordId,
        wordClasswordClass: wordClasswordClass ?? _wordClasswordClass,
      );

  int? get id => _id;

  String? get word => _word;

  String? get star => _star;

  String? get body => _body;

  String? get synonyms => _synonyms;

  String? get anthonims => _anthonims;

  String? get comment => _comment;

  String? get example => _example;

  String? get linkWord => _linkWord;

  String? get examples => _examples;

  String? get moreExamples => _moreExamples;

  String? get wordClassBody => _wordClassBody;

  String? get wordClassBodyMeaning => _wordClassBodyMeaning;

  String? get image => _image;

  int? get wordClassid => _wordClassid;

  int? get wordClasswordId => _wordClasswordId;

  String? get wordClasswordClass => _wordClasswordClass;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['star'] = _star;
    map['body'] = _body;
    map['synonyms'] = _synonyms;
    map['anthonims'] = _anthonims;
    map['comment'] = _comment;
    map['example'] = _example;
    map['link_word'] = _linkWord;
    map['examples'] = _examples;
    map['more_examples'] = _moreExamples;
    map['word_class_body'] = _wordClassBody;
    map['word_class_body_meaning'] = _wordClassBodyMeaning;
    map['image'] = _image;
    map['word_classid'] = _wordClassid;
    map['word_classword_id'] = _wordClasswordId;
    map['word_classword_class'] = _wordClasswordClass;
    return map;
  }
}
