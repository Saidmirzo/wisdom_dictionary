class ParentsModel {
  ParentsModel({
      this.id, 
      this.wordId, 
      this.word, 
      this.star, 
      this.body, 
      this.synonyms, 
      this.anthonims, 
      this.comment, 
      this.example, 
      this.linkWord, 
      this.examples, 
      this.moreExamples, 
      this.wordClassBody, 
      this.wordClassBodyMeaning, 
      this.image, 
      this.wordClassid, 
      this.wordClasswordId, 
      this.wordClasswordClass,});

  ParentsModel.fromJson(dynamic json) {
    id = json['id'];
    wordId = json['word_id'];
    word = json['word'];
    star = json['star'];
    body = json['body'];
    synonyms = json['synonyms'];
    anthonims = json['anthonims'];
    comment = json['comment'];
    example = json['example'];
    linkWord = json['link_word'];
    examples = json['examples'];
    moreExamples = json['more_examples'];
    wordClassBody = json['word_class_body'];
    wordClassBodyMeaning = json['word_class_body_meaning'];
    image = json['image'];
    wordClassid = json['word_classid'];
    wordClasswordId = json['word_classword_id'];
    wordClasswordClass = json['word_classword_class'];
  }
  int? id;
  int? wordId;
  String? word;
  String? star;
  String? body;
  String? synonyms;
  String? anthonims;
  String? comment;
  String? example;
  String? linkWord;
  String? examples;
  String? moreExamples;
  String? wordClassBody;
  String? wordClassBodyMeaning;
  String? image;
  int? wordClassid;
  int? wordClasswordId;
  String? wordClasswordClass;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['word_id'] = wordId;
    map['word'] = word;
    map['star'] = star;
    map['body'] = body;
    map['synonyms'] = synonyms;
    map['anthonims'] = anthonims;
    map['comment'] = comment;
    map['example'] = example;
    map['link_word'] = linkWord;
    map['examples'] = examples;
    map['more_examples'] = moreExamples;
    map['word_class_body'] = wordClassBody;
    map['word_class_body_meaning'] = wordClassBodyMeaning;
    map['image'] = image;
    map['word_classid'] = wordClassid;
    map['word_classword_id'] = wordClasswordId;
    map['word_classword_class'] = wordClasswordClass;
    return map;
  }

}