import 'package:wisdom/data/model/word_model.dart';

import '../../data/model/word_entity_model.dart';

class WordMapper {

  List<WordModel> wordEntityToWordList(List<WordEntityModel> wordEntity) => List<WordModel>.from(
        wordEntity.map(
          (e) => WordModel(
            id: e.id,
            word: e.word,
            star: e.star,
            anthonims: e.anthonims,
            body: e.body,
            comment: e.comment,
            example: e.example,
            examples: e.examples,
            image: e.image,
            linkWord: e.linkWord,
            moreExamples: e.moreExamples,
            synonyms: e.synonyms,
            wordClassBody: e.wordClassBody,
            wordClassBodyMeaning: e.wordClassBodyMeaning,
            wordClassid: e.wordClass?.id,
            wordClasswordId: e.id,
            wordClasswordClass: e.wordClass?.wordClass
          ),
        ),
      );

}
