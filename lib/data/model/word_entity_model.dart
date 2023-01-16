import 'dart:convert';

/// id : 32
/// word : ""
/// star : 0
/// body : ""
/// synonyms : ""
/// anthonims : ""
/// comment : ""
/// example : ""
/// link_word : ""
/// examples : ""
/// more_examples : ""
/// word_class : {"id":1,"word_class":""}
/// word_class_body : ""
/// word_class_body_meaning : ""
/// image : ""
/// words_uz : [{"id":38,"word":""}]
/// collocation : [{"id":2180,"body":""}]
/// culture : [{"id":25,"body":""}]
/// difference : [{"id":60,"word":"","body":""}]
/// grammar : [{"id":25,"body":""}]
/// metaphor : [{"id":25,"body":""}]
/// thesaurus : [{"id":25,"body":""}]
/// phrases : [{"id":221,"word":"","translate":[{"word":"","phrase_id":221}],"star":0,"examples":[{"value":""}],"synonyms":"","word_class_comment":"","parent_phrase":175,"parent_phrases":[{"id":176,"word":"","star":0,"examples":[{"value":""}],"synonyms":"","word_class_comment":"","parent_phrase":175,"translate":[{"word":"","phrase_id":176}]}]}]
/// parents : []

WordEntityModel wordEntityModelFromJson(String str) => WordEntityModel.fromJson(json.decode(str));

String wordEntityModelToJson(WordEntityModel data) => json.encode(data.toJson());

class WordEntityModel {
  WordEntityModel({
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
    WordClass? wordClass,
    String? wordClassBody,
    String? wordClassBodyMeaning,
    String? image,
    List<WordsUz>? wordsUz,
    List<Collocation>? collocation,
    List<Culture>? culture,
    List<Difference>? difference,
    List<Grammar>? grammar,
    List<Metaphor>? metaphor,
    List<Thesaurus>? thesaurus,
    List<Phrases>? phrases,
    List<WordEntityModel>? parents,
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
    _wordClass = wordClass;
    _wordClassBody = wordClassBody;
    _wordClassBodyMeaning = wordClassBodyMeaning;
    _image = image;
    _wordsUz = wordsUz;
    _collocation = collocation;
    _culture = culture;
    _difference = difference;
    _grammar = grammar;
    _metaphor = metaphor;
    _thesaurus = thesaurus;
    _phrases = phrases;
    _parents = parents;
  }

  WordEntityModel.fromJson(dynamic json) {
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
    _wordClass = json['word_class'] != null ? WordClass.fromJson(json['word_class']) : null;
    _wordClassBody = json['word_class_body'];
    _wordClassBodyMeaning = json['word_class_body_meaning'];
    _image = json['image'];
    if (json['words_uz'] != null) {
      _wordsUz = [];
      json['words_uz'].forEach((v) {
        _wordsUz?.add(WordsUz.fromJson(v));
      });
    }
    if (json['collocation'] != null) {
      _collocation = [];
      json['collocation'].forEach((v) {
        _collocation?.add(Collocation.fromJson(v));
      });
    }
    if (json['culture'] != null) {
      _culture = [];
      json['culture'].forEach((v) {
        _culture?.add(Culture.fromJson(v));
      });
    }
    if (json['difference'] != null) {
      _difference = [];
      json['difference'].forEach((v) {
        _difference?.add(Difference.fromJson(v));
      });
    }
    if (json['grammar'] != null) {
      _grammar = [];
      json['grammar'].forEach((v) {
        _grammar?.add(Grammar.fromJson(v));
      });
    }
    if (json['metaphor'] != null) {
      _metaphor = [];
      json['metaphor'].forEach((v) {
        _metaphor?.add(Metaphor.fromJson(v));
      });
    }
    if (json['thesaurus'] != null) {
      _thesaurus = [];
      json['thesaurus'].forEach((v) {
        _thesaurus?.add(Thesaurus.fromJson(v));
      });
    }
    if (json['phrases'] != null) {
      _phrases = [];
      json['phrases'].forEach((v) {
        _phrases?.add(Phrases.fromJson(v));
      });
    }
    if (json['parents'] != null) {
      _parents = [];
      json['parents'].forEach((v) {
        _parents?.add(WordEntityModel.fromJson(v));
      });
    }
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
  WordClass? _wordClass;
  String? _wordClassBody;
  String? _wordClassBodyMeaning;
  String? _image;
  List<WordsUz>? _wordsUz;
  List<Collocation>? _collocation;
  List<Culture>? _culture;
  List<Difference>? _difference;
  List<Grammar>? _grammar;
  List<Metaphor>? _metaphor;
  List<Thesaurus>? _thesaurus;
  List<Phrases>? _phrases;
  List<WordEntityModel>? _parents;

  WordEntityModel copyWith({
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
    WordClass? wordClass,
    String? wordClassBody,
    String? wordClassBodyMeaning,
    String? image,
    List<WordsUz>? wordsUz,
    List<Collocation>? collocation,
    List<Culture>? culture,
    List<Difference>? difference,
    List<Grammar>? grammar,
    List<Metaphor>? metaphor,
    List<Thesaurus>? thesaurus,
    List<Phrases>? phrases,
    List<WordEntityModel>? parents,
  }) =>
      WordEntityModel(
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
        wordClass: wordClass ?? _wordClass,
        wordClassBody: wordClassBody ?? _wordClassBody,
        wordClassBodyMeaning: wordClassBodyMeaning ?? _wordClassBodyMeaning,
        image: image ?? _image,
        wordsUz: wordsUz ?? _wordsUz,
        collocation: collocation ?? _collocation,
        culture: culture ?? _culture,
        difference: difference ?? _difference,
        grammar: grammar ?? _grammar,
        metaphor: metaphor ?? _metaphor,
        thesaurus: thesaurus ?? _thesaurus,
        phrases: phrases ?? _phrases,
        parents: parents ?? _parents,
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

  WordClass? get wordClass => _wordClass;

  String? get wordClassBody => _wordClassBody;

  String? get wordClassBodyMeaning => _wordClassBodyMeaning;

  String? get image => _image;

  List<WordsUz>? get wordsUz => _wordsUz;

  List<Collocation>? get collocation => _collocation;

  List<Culture>? get culture => _culture;

  List<Difference>? get difference => _difference;

  List<Grammar>? get grammar => _grammar;

  List<Metaphor>? get metaphor => _metaphor;

  List<Thesaurus>? get thesaurus => _thesaurus;

  List<Phrases>? get phrases => _phrases;

  List<WordEntityModel>? get parents => _parents;

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
    if (_wordClass != null) {
      map['word_class'] = _wordClass?.toJson();
    }
    map['word_class_body'] = _wordClassBody;
    map['word_class_body_meaning'] = _wordClassBodyMeaning;
    map['image'] = _image;
    if (_wordsUz != null) {
      map['words_uz'] = _wordsUz?.map((v) => v.toJson()).toList();
    }
    if (_collocation != null) {
      map['collocation'] = _collocation?.map((v) => v.toJson()).toList();
    }
    if (_culture != null) {
      map['culture'] = _culture?.map((v) => v.toJson()).toList();
    }
    if (_difference != null) {
      map['difference'] = _difference?.map((v) => v.toJson()).toList();
    }
    if (_grammar != null) {
      map['grammar'] = _grammar?.map((v) => v.toJson()).toList();
    }
    if (_metaphor != null) {
      map['metaphor'] = _metaphor?.map((v) => v.toJson()).toList();
    }
    if (_thesaurus != null) {
      map['thesaurus'] = _thesaurus?.map((v) => v.toJson()).toList();
    }
    if (_phrases != null) {
      map['phrases'] = _phrases?.map((v) => v.toJson()).toList();
    }
    if (_parents != null) {
      map['parents'] = _parents?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 221
/// word : ""
/// translate : [{"word":"","phrase_id":221}]
/// star : 0
/// examples : [{"value":""}]
/// synonyms : ""
/// word_class_comment : ""
/// parent_phrase : 175
/// parent_phrases : [{"id":176,"word":"","star":0,"examples":[{"value":""}],"synonyms":"","word_class_comment":"","parent_phrase":175,"translate":[{"word":"","phrase_id":176}]}]

Phrases phrasesFromJson(String str) => Phrases.fromJson(json.decode(str));

String phrasesToJson(Phrases data) => json.encode(data.toJson());

class Phrases {
  Phrases({
    int? id,
    String? word,
    List<Translate>? translate,
    int? star,
    List<Examples>? examples,
    String? synonyms,
    String? wordClassComment,
    int? parentPhrase,
    List<ParentPhrases>? parentPhrases,
  }) {
    _id = id;
    _word = word;
    _translate = translate;
    _star = star;
    _examples = examples;
    _synonyms = synonyms;
    _wordClassComment = wordClassComment;
    _parentPhrase = parentPhrase;
    _parentPhrases = parentPhrases;
  }

  Phrases.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    if (json['translate'] != null) {
      _translate = [];
      json['translate'].forEach((v) {
        _translate?.add(Translate.fromJson(v));
      });
    }
    _star = json['star'];
    if (json['examples'] != null) {
      _examples = [];
      json['examples'].forEach((v) {
        _examples?.add(Examples.fromJson(v));
      });
    }
    _synonyms = json['synonyms'];
    _wordClassComment = json['word_class_comment'];
    _parentPhrase = json['parent_phrase'];
    if (json['parent_phrases'] != null) {
      _parentPhrases = [];
      json['parent_phrases'].forEach((v) {
        _parentPhrases?.add(ParentPhrases.fromJson(v));
      });
    }
  }

  int? _id;
  String? _word;
  List<Translate>? _translate;
  int? _star;
  List<Examples>? _examples;
  String? _synonyms;
  String? _wordClassComment;
  int? _parentPhrase;
  List<ParentPhrases>? _parentPhrases;

  Phrases copyWith({
    int? id,
    String? word,
    List<Translate>? translate,
    int? star,
    List<Examples>? examples,
    String? synonyms,
    String? wordClassComment,
    int? parentPhrase,
    List<ParentPhrases>? parentPhrases,
  }) =>
      Phrases(
        id: id ?? _id,
        word: word ?? _word,
        translate: translate ?? _translate,
        star: star ?? _star,
        examples: examples ?? _examples,
        synonyms: synonyms ?? _synonyms,
        wordClassComment: wordClassComment ?? _wordClassComment,
        parentPhrase: parentPhrase ?? _parentPhrase,
        parentPhrases: parentPhrases ?? _parentPhrases,
      );

  int? get id => _id;

  String? get word => _word;

  List<Translate>? get translate => _translate;

  int? get star => _star;

  List<Examples>? get examples => _examples;

  String? get synonyms => _synonyms;

  String? get wordClassComment => _wordClassComment;

  int? get parentPhrase => _parentPhrase;

  List<ParentPhrases>? get parentPhrases => _parentPhrases;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    if (_translate != null) {
      map['translate'] = _translate?.map((v) => v.toJson()).toList();
    }
    map['star'] = _star;
    if (_examples != null) {
      map['examples'] = _examples?.map((v) => v.toJson()).toList();
    }
    map['synonyms'] = _synonyms;
    map['word_class_comment'] = _wordClassComment;
    map['parent_phrase'] = _parentPhrase;
    if (_parentPhrases != null) {
      map['parent_phrases'] = _parentPhrases?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 176
/// word : ""
/// star : 0
/// examples : [{"value":""}]
/// synonyms : ""
/// word_class_comment : ""
/// parent_phrase : 175
/// translate : [{"word":"","phrase_id":176}]

ParentPhrases parentPhrasesFromJson(String str) => ParentPhrases.fromJson(json.decode(str));

String parentPhrasesToJson(ParentPhrases data) => json.encode(data.toJson());

class ParentPhrases {
  ParentPhrases({
    int? id,
    String? word,
    int? star,
    List<Examples>? examples,
    String? synonyms,
    String? wordClassComment,
    int? parentPhrase,
    List<Translate>? translate,
  }) {
    _id = id;
    _word = word;
    _star = star;
    _examples = examples;
    _synonyms = synonyms;
    _wordClassComment = wordClassComment;
    _parentPhrase = parentPhrase;
    _translate = translate;
  }

  ParentPhrases.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _star = json['star'];
    if (json['examples'] != null) {
      _examples = [];
      json['examples'].forEach((v) {
        _examples?.add(Examples.fromJson(v));
      });
    }
    _synonyms = json['synonyms'];
    _wordClassComment = json['word_class_comment'];
    _parentPhrase = json['parent_phrase'];
    if (json['translate'] != null) {
      _translate = [];
      json['translate'].forEach((v) {
        _translate?.add(Translate.fromJson(v));
      });
    }
  }

  int? _id;
  String? _word;
  int? _star;
  List<Examples>? _examples;
  String? _synonyms;
  String? _wordClassComment;
  int? _parentPhrase;
  List<Translate>? _translate;

  ParentPhrases copyWith({
    int? id,
    String? word,
    int? star,
    List<Examples>? examples,
    String? synonyms,
    String? wordClassComment,
    int? parentPhrase,
    List<Translate>? translate,
  }) =>
      ParentPhrases(
        id: id ?? _id,
        word: word ?? _word,
        star: star ?? _star,
        examples: examples ?? _examples,
        synonyms: synonyms ?? _synonyms,
        wordClassComment: wordClassComment ?? _wordClassComment,
        parentPhrase: parentPhrase ?? _parentPhrase,
        translate: translate ?? _translate,
      );

  int? get id => _id;

  String? get word => _word;

  int? get star => _star;

  List<Examples>? get examples => _examples;

  String? get synonyms => _synonyms;

  String? get wordClassComment => _wordClassComment;

  int? get parentPhrase => _parentPhrase;

  List<Translate>? get translate => _translate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['star'] = _star;
    if (_examples != null) {
      map['examples'] = _examples?.map((v) => v.toJson()).toList();
    }
    map['synonyms'] = _synonyms;
    map['word_class_comment'] = _wordClassComment;
    map['parent_phrase'] = _parentPhrase;
    if (_translate != null) {
      map['translate'] = _translate?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// word : ""
/// phrase_id : 176

Translate translateFromJson(String str) => Translate.fromJson(json.decode(str));

String translateToJson(Translate data) => json.encode(data.toJson());

class Translate {
  Translate({
    String? word,
    int? phraseId,
  }) {
    _word = word;
    _phraseId = phraseId;
  }

  Translate.fromJson(dynamic json) {
    _word = json['word'];
    _phraseId = json['phrase_id'];
  }

  String? _word;
  int? _phraseId;

  Translate copyWith({
    String? word,
    int? phraseId,
  }) =>
      Translate(
        word: word ?? _word,
        phraseId: phraseId ?? _phraseId,
      );

  String? get word => _word;

  int? get phraseId => _phraseId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['word'] = _word;
    map['phrase_id'] = _phraseId;
    return map;
  }
}

/// value : ""

Examples examplesFromJson(String str) => Examples.fromJson(json.decode(str));

String examplesToJson(Examples data) => json.encode(data.toJson());

class Examples {
  Examples({
    String? value,
  }) {
    _value = value;
  }

  Examples.fromJson(dynamic json) {
    _value = json['value'];
  }

  String? _value;

  Examples copyWith({
    String? value,
  }) =>
      Examples(
        value: value ?? _value,
      );

  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['value'] = _value;
    return map;
  }
}

/// id : 25
/// body : ""

Thesaurus thesaurusFromJson(String str) => Thesaurus.fromJson(json.decode(str));

String thesaurusToJson(Thesaurus data) => json.encode(data.toJson());

class Thesaurus {
  Thesaurus({
    int? id,
    String? body,
  }) {
    _id = id;
    _body = body;
  }

  Thesaurus.fromJson(dynamic json) {
    _id = json['id'];
    _body = json['body'];
  }

  int? _id;
  String? _body;

  Thesaurus copyWith({
    int? id,
    String? body,
  }) =>
      Thesaurus(
        id: id ?? _id,
        body: body ?? _body,
      );

  int? get id => _id;

  String? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['body'] = _body;
    return map;
  }
}

/// id : 25
/// body : ""

Metaphor metaphorFromJson(String str) => Metaphor.fromJson(json.decode(str));

String metaphorToJson(Metaphor data) => json.encode(data.toJson());

class Metaphor {
  Metaphor({
    int? id,
    String? body,
  }) {
    _id = id;
    _body = body;
  }

  Metaphor.fromJson(dynamic json) {
    _id = json['id'];
    _body = json['body'];
  }

  int? _id;
  String? _body;

  Metaphor copyWith({
    int? id,
    String? body,
  }) =>
      Metaphor(
        id: id ?? _id,
        body: body ?? _body,
      );

  int? get id => _id;

  String? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['body'] = _body;
    return map;
  }
}

/// id : 25
/// body : ""

Grammar grammarFromJson(String str) => Grammar.fromJson(json.decode(str));

String grammarToJson(Grammar data) => json.encode(data.toJson());

class Grammar {
  Grammar({
    int? id,
    String? body,
  }) {
    _id = id;
    _body = body;
  }

  Grammar.fromJson(dynamic json) {
    _id = json['id'];
    _body = json['body'];
  }

  int? _id;
  String? _body;

  Grammar copyWith({
    int? id,
    String? body,
  }) =>
      Grammar(
        id: id ?? _id,
        body: body ?? _body,
      );

  int? get id => _id;

  String? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['body'] = _body;
    return map;
  }
}

/// id : 60
/// word : ""
/// body : ""

Difference differenceFromJson(String str) => Difference.fromJson(json.decode(str));

String differenceToJson(Difference data) => json.encode(data.toJson());

class Difference {
  Difference({
    int? id,
    String? word,
    String? body,
  }) {
    _id = id;
    _word = word;
    _body = body;
  }

  Difference.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
    _body = json['body'];
  }

  int? _id;
  String? _word;
  String? _body;

  Difference copyWith({
    int? id,
    String? word,
    String? body,
  }) =>
      Difference(
        id: id ?? _id,
        word: word ?? _word,
        body: body ?? _body,
      );

  int? get id => _id;

  String? get word => _word;

  String? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word'] = _word;
    map['body'] = _body;
    return map;
  }
}

/// id : 25
/// body : ""

Culture cultureFromJson(String str) => Culture.fromJson(json.decode(str));

String cultureToJson(Culture data) => json.encode(data.toJson());

class Culture {
  Culture({
    int? id,
    String? body,
  }) {
    _id = id;
    _body = body;
  }

  Culture.fromJson(dynamic json) {
    _id = json['id'];
    _body = json['body'];
  }

  int? _id;
  String? _body;

  Culture copyWith({
    int? id,
    String? body,
  }) =>
      Culture(
        id: id ?? _id,
        body: body ?? _body,
      );

  int? get id => _id;

  String? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['body'] = _body;
    return map;
  }
}

/// id : 2180
/// body : ""

Collocation collocationFromJson(String str) => Collocation.fromJson(json.decode(str));

String collocationToJson(Collocation data) => json.encode(data.toJson());

class Collocation {
  Collocation({
    int? id,
    String? body,
  }) {
    _id = id;
    _body = body;
  }

  Collocation.fromJson(dynamic json) {
    _id = json['id'];
    _body = json['body'];
  }

  int? _id;
  String? _body;

  Collocation copyWith({
    int? id,
    String? body,
  }) =>
      Collocation(
        id: id ?? _id,
        body: body ?? _body,
      );

  int? get id => _id;

  String? get body => _body;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['body'] = _body;
    return map;
  }
}

/// id : 38
/// word : ""

WordsUz wordsUzFromJson(String str) => WordsUz.fromJson(json.decode(str));

String wordsUzToJson(WordsUz data) => json.encode(data.toJson());

class WordsUz {
  WordsUz({
    int? id,
    String? word,
  }) {
    _id = id;
    _word = word;
  }

  WordsUz.fromJson(dynamic json) {
    _id = json['id'];
    _word = json['word'];
  }

  int? _id;
  String? _word;

  WordsUz copyWith({
    int? id,
    String? word,
  }) =>
      WordsUz(
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
/// word_class : ""

WordClass wordClassFromJson(String str) => WordClass.fromJson(json.decode(str));

String wordClassToJson(WordClass data) => json.encode(data.toJson());

class WordClass {
  WordClass({
    int? id,
    String? wordClass,
  }) {
    _id = id;
    _wordClass = wordClass;
  }

  WordClass.fromJson(dynamic json) {
    _id = json['id'];
    _wordClass = json['word_class'];
  }

  int? _id;
  String? _wordClass;

  WordClass copyWith({
    int? id,
    String? wordClass,
  }) =>
      WordClass(
        id: id ?? _id,
        wordClass: wordClass ?? _wordClass,
      );

  int? get id => _id;

  String? get wordClass => _wordClass;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['word_class'] = _wordClass;
    return map;
  }
}
