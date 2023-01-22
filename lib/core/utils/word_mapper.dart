import 'package:wisdom/data/model/parents_model.dart';
import 'package:wisdom/data/model/phrases_with_all.dart';
import 'package:wisdom/data/model/word_model.dart';

import '../../data/model/search_result_model.dart';
import '../../data/model/word_and_parents_and_phrases_model.dart';
import '../../data/model/word_and_phrases_model.dart';
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
              wordClasswordClass: e.wordClass?.wordClass),
        ),
      );

  ParentsWithAll wordWithAllToParentsWithAll(WordWithAll wordWithAll) => ParentsWithAll(
        ParentsModel(
            id: 0,
            wordId: wordWithAll.word!.id,
            word: wordWithAll.word!.word!,
            star: wordWithAll.word!.star,
            synonyms: wordWithAll.word!.synonyms!,
            anthonims: wordWithAll.word!.anthonims,
            body: wordWithAll.word!.body,
            comment: wordWithAll.word!.comment,
            examples: wordWithAll.word!.examples,
            moreExamples: wordWithAll.word!.moreExamples,
            image: wordWithAll.word!.image,
            linkWord: wordWithAll.word!.linkWord,
            wordClassid: wordWithAll.word!.wordClassid,
            wordClasswordId: wordWithAll.word!.wordClasswordId,
            wordClasswordClass: wordWithAll.word!.wordClasswordClass,
            example: wordWithAll.word!.example,
            wordClassBody: wordWithAll.word!.wordClassBody,
            wordClassBodyMeaning: wordWithAll.word!.wordClassBodyMeaning),
        wordWithAll.wordsUz,
        wordWithAll.collocation,
        wordWithAll.culture,
        wordWithAll.difference,
        wordWithAll.grammar,
        wordWithAll.metaphor,
        wordWithAll.thesaurus,
        wordWithAll.phrasesWithAll,
      );

  List<SearchResultModel> wordEntityListToSearchResultList(List<WordModel> model, String type) =>
      List<SearchResultModel>.from(
        model.map(
          (e) => SearchResultModel(
              id: e.id,
              word: e.word,
              wordClassid: e.wordClassid,
              wordClasswordId: e.wordClasswordId,
              wordClasswordClass: e.wordClasswordClass,
              type: type),
        ),
      );

  List<SearchResultModel> wordEntityListToSearchPhraseList(
          List<WordAndPhrasesModel> model, String type, String search) =>
      List<SearchResultModel>.from(
        model.map(
          (e) {
            var phraseWord = "";
            if (e.pWord!.startsWith(search) &&
                (e.pWord![0] == search[0] ||
                    e.pWord![0].toUpperCase() == search[0] ||
                    e.pWord![0].toLowerCase() == search[0])) {
              phraseWord = e.pWord.toString();
            }
            return SearchResultModel(
                id: e.id!,
                word: phraseWord,
                wordClassid: e.wordClassid,
                wordClasswordId: e.wordClasswordId,
                wordClasswordClass: e.wordClasswordClass,
                type: type);
          },
        ),
      );

  Future<List<SearchResultModel>> wordEntityListToSearchPhraseParentList(
      List<WordAndParentsAndPhrasesModel> list, String type, String search) {
    var arrayForSearch = <SearchResultModel>[];
    var prevResult = <String>[];
    for (var wordDto in list) {
      mapWordDtoToSearchResultFroParentPhrase(wordDto, type, search, prevResult).forEach((element) {
        if (element.word!.isNotEmpty) {
          arrayForSearch.add(element);
          prevResult.add(element.word!);
          mapWordDtoToSearchResultFroParentPhraseList(wordDto, type, search, prevResult).forEach((second) {
            prevResult.add(second.word!);
            arrayForSearch.add(second);
          });
        }
      });
    }
    return Future.value(arrayForSearch);
  }

  List<SearchResultModel> mapWordDtoToSearchResultFroParentPhrase(
      WordAndParentsAndPhrasesModel parentsAndPhrasesModel, String type, String search, List<String> exclude) {
    var phraseWord = "";
    List<SearchResultModel> searchResultList = [];
    if (parentsAndPhrasesModel.pWord!.startsWith(search) &&
        (!exclude.contains(parentsAndPhrasesModel!.pWord.toString()))) {
      phraseWord = parentsAndPhrasesModel.pWord.toString();
      searchResultList.add(SearchResultModel(
        id: parentsAndPhrasesModel.id,
        word: phraseWord,
        wordClassid: parentsAndPhrasesModel.wordClassid,
        wordClasswordId: parentsAndPhrasesModel.wordClasswordId,
        wordClasswordClass: parentsAndPhrasesModel.wordClasswordClass,
        type: type,
      ));
    }
    return searchResultList;
  }

  List<SearchResultModel> mapWordDtoToSearchResultFroParentPhraseList(
      WordAndParentsAndPhrasesModel parentsAndPhrasesModel, String type, String search, List<String> exclude) {
    List<SearchResultModel> searchResultList = [];
    if (parentsAndPhrasesModel.pWord!.startsWith(search) && !exclude.contains(parentsAndPhrasesModel.pWord)) {
      searchResultList.add(
        SearchResultModel(
            id: parentsAndPhrasesModel.id,
            word: parentsAndPhrasesModel.pWord.toString(),
            wordClassid: parentsAndPhrasesModel.wordClassid,
            wordClasswordId: parentsAndPhrasesModel.wordClasswordId,
            wordClasswordClass: parentsAndPhrasesModel.wordClasswordClass,
            type: type),
      );
    }
    return searchResultList;
  }
}
