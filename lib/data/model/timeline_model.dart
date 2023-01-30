import 'dart:convert';

/// word : {"count":1,"words_en_id":1,"words_en":{"id":1,"word":""}}
/// image : {"id":1,"image":""}
/// ad : {"id":1,"image":"","link":""}
/// difference : {"id":1,"word":""}
/// grammar : {"id":1,"word":""}
/// thesaurus : {"id":1,"word":""}
/// collocation : {"id":1,"worden":{"id":1,"word":""}}
/// metaphor : {"id":1,"worden":{"id":1,"word":""}}
/// speaking : {"id":1,"word":""}
/// status : true
/// error : 0

TimelineModel timelineModelFromJson(String str) => TimelineModel.fromJson(json.decode(str));

String timelineModelToJson(TimelineModel data) => json.encode(data.toJson());

class TimelineModel {
  TimelineModel({
    Word? word,
    ImageT? image,
    Ad? ad,
    Difference? difference,
    Collocation? grammar,
    Collocation? thesaurus,
    Collocation? collocation,
    Collocation? metaphor,
    Speaking? speaking,
    bool? status,
    int? error,
  }) {
    _word = word;
    _image = image;
    _ad = ad;
    _difference = difference;
    _grammar = grammar;
    _thesaurus = thesaurus;
    _collocation = collocation;
    _metaphor = metaphor;
    _speaking = speaking;
    _status = status;
    _error = error;
  }

  TimelineModel.fromJson(dynamic json) {
    _word = json['word'] != null ? Word.fromJson(json['word']) : null;
    _image = json['image'] != null ? ImageT.fromJson(json['image']) : null;
    _ad = json['ad'] != null ? Ad.fromJson(json['ad']) : null;
    _difference = json['difference'] != null ? Difference.fromJson(json['difference']) : null;
    _grammar = json['grammar'] != null ? Collocation.fromJson(json['grammar']) : null;
    _thesaurus = json['thesaurus'] != null ? Collocation.fromJson(json['thesaurus']) : null;
    _collocation = json['collocation'] != null ? Collocation.fromJson(json['collocation']) : null;
    _metaphor = json['metaphor'] != null ? Collocation.fromJson(json['metaphor']) : null;
    _speaking = json['speaking'] != null ? Speaking.fromJson(json['speaking']) : null;
    _status = json['status'];
    _error = json['error'];
  }

  Word? _word;
  ImageT? _image;
  Ad? _ad;
  Difference? _difference;
  Collocation? _grammar;
  Collocation? _thesaurus;
  Collocation? _collocation;
  Collocation? _metaphor;
  Speaking? _speaking;
  bool? _status;
  int? _error;

  TimelineModel copyWith({
    Word? word,
    ImageT? image,
    Ad? ad,
    Difference? difference,
    Collocation? grammar,
    Collocation? thesaurus,
    Collocation? collocation,
    Collocation? metaphor,
    Speaking? speaking,
    bool? status,
    int? error,
  }) =>
      TimelineModel(
        word: word ?? _word,
        image: image ?? _image,
        ad: ad ?? _ad,
        difference: difference ?? _difference,
        grammar: grammar ?? _grammar,
        thesaurus: thesaurus ?? _thesaurus,
        collocation: collocation ?? _collocation,
        metaphor: metaphor ?? _metaphor,
        speaking: speaking ?? _speaking,
        status: status ?? _status,
        error: error ?? _error,
      );

  Word? get word => _word;

  ImageT? get image => _image;

  Ad? get ad => _ad;

  Difference? get difference => _difference;

  Collocation? get grammar => _grammar;

  Collocation? get thesaurus => _thesaurus;

  Collocation? get collocation => _collocation;

  Collocation? get metaphor => _metaphor;

  Speaking? get speaking => _speaking;

  bool? get status => _status;

  int? get error => _error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_word != null) {
      map['word'] = _word?.toJson();
    }
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    if (_ad != null) {
      map['ad'] = _ad?.toJson();
    }
    if (_difference != null) {
      map['difference'] = _difference?.toJson();
    }
    if (_grammar != null) {
      map['grammar'] = _grammar?.toJson();
    }
    if (_thesaurus != null) {
      map['thesaurus'] = _thesaurus?.toJson();
    }
    if (_collocation != null) {
      map['collocation'] = _collocation?.toJson();
    }
    if (_metaphor != null) {
      map['metaphor'] = _metaphor?.toJson();
    }
    if (_speaking != null) {
      map['speaking'] = _speaking?.toJson();
    }
    map['status'] = _status;
    map['error'] = _error;
    return map;
  }

  set word(Word? value) {
    _word = value;
  }

  set error(int? value) {
    _error = value;
  }

  set status(bool? value) {
    _status = value;
  }

  set speaking(Speaking? value) {
    _speaking = value;
  }

  set metaphor(Collocation? value) {
    _metaphor = value;
  }

  set collocation(Collocation? value) {
    _collocation = value;
  }

  set thesaurus(Collocation? value) {
    _thesaurus = value;
  }

  set grammar(Collocation? value) {
    _grammar = value;
  }

  set difference(Difference? value) {
    _difference = value;
  }

  set ad(Ad? value) {
    _ad = value;
  }

  set image(ImageT? value) {
    _image = value;
  }
}

/// id : 1
/// word : ""

Speaking speakingFromJson(String str) => Speaking.fromJson(json.decode(str));

String speakingToJson(Speaking data) => json.encode(data.toJson());

class Speaking {
  Speaking({
    int? id,
    String? word,
  }) {
    _id = id;
    _word = word;
  }

  Speaking.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
  }

  int? _id;
  String? _word;

  Speaking copyWith({
    int? id,
    String? word,
  }) =>
      Speaking(
        id: id ?? _id,
        word: word ?? _word,
      );

  int? get id => _id;

  String? get word => _word;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    return map;
  }
}

/// id : 1
/// worden : {"id":1,"word":""}

Metaphor metaphorFromJson(String str) => Metaphor.fromJson(json.decode(str));

String metaphorToJson(Metaphor data) => json.encode(data.toJson());

class Metaphor {
  Metaphor({
    int? id,
    Worden? worden,
  }) {
    _id = id;
    _worden = worden;
  }

  Metaphor.fromJson(dynamic json) {
    _id = json['id'];
    _worden = json['worden'] != null ? Worden.fromJson(json['worden']) : null;
  }

  int? _id;
  Worden? _worden;

  Metaphor copyWith({
    int? id,
    Worden? worden,
  }) =>
      Metaphor(
        id: id ?? _id,
        worden: worden ?? _worden,
      );

  int? get id => _id;

  Worden? get worden => _worden;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_worden != null) {
      map['worden'] = _worden?.toJson();
    }
    return map;
  }
}

/// id : 1
/// word : ""

Worden wordenFromJson(String str) => Worden.fromJson(json.decode(str));

String wordenToJson(Worden data) => json.encode(data.toJson());

class Worden {
  Worden({
    int? id,
    String? word,
  }) {
    _id = id;
    _word = word;
  }

  Worden.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
  }

  int? _id;
  String? _word;

  Worden copyWith({
    int? id,
    String? word,
  }) =>
      Worden(
        id: id ?? _id,
        word: word ?? _word,
      );

  int? get id => _id;

  String? get word => _word;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    return map;
  }
}

/// id : 1
/// worden : {"id":1,"word":""}

Collocation collocationFromJson(String str) => Collocation.fromJson(json.decode(str));

String collocationToJson(Collocation data) => json.encode(data.toJson());

class Collocation {
  Collocation({
    int? id,
    Worden? worden,
  }) {
    _id = id;
    _worden = worden;
  }

  Collocation.fromJson(dynamic json) {
    _id = json['id'];
    _worden = json['worden'] != null ? Worden.fromJson(json['worden']) : null;
  }

  int? _id;
  Worden? _worden;

  Collocation copyWith({
    int? id,
    Worden? worden,
  }) =>
      Collocation(
        id: id ?? _id,
        worden: worden ?? _worden,
      );

  int? get id => _id;

  Worden? get worden => _worden;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_worden != null) {
      map['worden'] = _worden?.toJson();
    }
    return map;
  }
}

/// id : 1
/// word : ""

Thesaurus thesaurusFromJson(String str) => Thesaurus.fromJson(json.decode(str));

String thesaurusToJson(Thesaurus data) => json.encode(data.toJson());

class Thesaurus {
  Thesaurus({
    int? id,
    String? word,
  }) {
    _id = id;
    _word = word;
  }

  Thesaurus.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
  }

  int? _id;
  String? _word;

  Thesaurus copyWith({
    int? id,
    String? word,
  }) =>
      Thesaurus(
        id: id ?? _id,
        word: word ?? _word,
      );

  int? get id => _id;

  String? get word => _word;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    return map;
  }
}

/// id : 1
/// word : ""

Grammar grammarFromJson(String str) => Grammar.fromJson(json.decode(str));

String grammarToJson(Grammar data) => json.encode(data.toJson());

class Grammar {
  Grammar({
    int? id,
    String? word,
  }) {
    _id = id;
    _word = word;
  }

  Grammar.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
  }

  int? _id;
  String? _word;

  Grammar copyWith({
    int? id,
    String? word,
  }) =>
      Grammar(
        id: id ?? _id,
        word: word ?? _word,
      );

  int? get id => _id;

  String? get word => _word;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    return map;
  }
}

/// id : 1
/// word : ""

Difference differenceFromJson(String str) => Difference.fromJson(json.decode(str));

String differenceToJson(Difference data) => json.encode(data.toJson());

class Difference {
  Difference({
    int? id,
    String? word,
  }) {
    _id = id;
    _word = word;
  }

  Difference.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
  }

  int? _id;
  String? _word;

  Difference copyWith({
    int? id,
    String? word,
  }) =>
      Difference(
        id: id ?? _id,
        word: word ?? _word,
      );

  int? get id => _id;

  String? get word => _word;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    return map;
  }
}

/// id : 1
/// image : ""
/// link : ""

Ad adFromJson(String str) => Ad.fromJson(json.decode(str));

String adToJson(Ad data) => json.encode(data.toJson());

class Ad {
  Ad({
    int? id,
    String? image,
    String? link,
  }) {
    _id = id;
    _image = image;
    _link = link;
  }

  Ad.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _link = json['link'];
  }

  int? _id;
  String? _image;
  String? _link;

  Ad copyWith({
    int? id,
    String? image,
    String? link,
  }) =>
      Ad(
        id: id ?? _id,
        image: image ?? _image,
        link: link ?? _link,
      );

  int? get id => _id;

  String? get image => _image;

  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['link'] = _link;
    return map;
  }
}

/// id : 1
/// word : ""
/// image : ""

ImageT imageTFromJson(String str) => ImageT.fromJson(json.decode(str));

String imageTToJson(ImageT data) => json.encode(data.toJson());

class ImageT {
  ImageT({
    int? id,
    String? word,
    String? image,
  }) {
    _id = id;
    _word = word;
    _image = image;
  }

  ImageT.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _image = json['image'];
  }

  int? _id;
  String? _word;
  String? _image;

  ImageT copyWith({
    int? id,
    String? word,
    String? image,
  }) =>
      ImageT(
        id: id ?? _id,
        word: word ?? _word,
        image: image ?? _image,
      );

  int? get id => _id;

  String? get word => _word;

  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['image'] = _image;
    return map;
  }
}

/// count : 1
/// words_en_id : 1
/// words_en : {"id":1,"word":""}

Word wordFromJson(String str) => Word.fromJson(json.decode(str));

String wordToJson(Word data) => json.encode(data.toJson());

class Word {
  Word({
    int? count,
    int? wordsEnId,
    WordsEn? wordsEn,
  }) {
    _count = count;
    _wordsEnId = wordsEnId;
    _wordsEn = wordsEn;
  }

  Word.fromJson(dynamic json) {
    _count = json['count'];
    _wordsEnId = json['words_en_id'];
    _wordsEn = json['words_en'] != null ? WordsEn.fromJson(json['words_en']) : null;
  }

  int? _count;
  int? _wordsEnId;
  WordsEn? _wordsEn;

  Word copyWith({
    int? count,
    int? wordsEnId,
    WordsEn? wordsEn,
  }) =>
      Word(
        count: count ?? _count,
        wordsEnId: wordsEnId ?? _wordsEnId,
        wordsEn: wordsEn ?? _wordsEn,
      );

  int? get count => _count;

  int? get wordsEnId => _wordsEnId;

  WordsEn? get wordsEn => _wordsEn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['words_en_id'] = _wordsEnId;
    if (_wordsEn != null) {
      map['words_en'] = _wordsEn?.toJson();
    }
    return map;
  }
}

/// id : 1
/// word : ""

WordsEn wordsEnFromJson(String str) => WordsEn.fromJson(json.decode(str));

String wordsEnToJson(WordsEn data) => json.encode(data.toJson());

class WordsEn {
  WordsEn({
    int? id,
    String? word,
  }) {
    _id = id;
    _word = word;
  }

  WordsEn.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
  }

  int? _id;
  String? _word;

  WordsEn copyWith({
    int? id,
    String? word,
  }) =>
      WordsEn(
        id: id ?? _id,
        word: word ?? _word,
      );

  int? get id => _id;

  String? get word => _word;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    return map;
  }
}
