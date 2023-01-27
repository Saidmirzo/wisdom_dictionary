import 'package:wisdom/data/model/parents_model.dart';
import 'package:wisdom/data/model/phrases_with_all.dart';
import 'package:wisdom/data/model/search_result_uz_model.dart';
import 'package:wisdom/data/model/word_and_parents_and_phrases_and_translate_model.dart';
import 'package:wisdom/data/model/word_and_parents_and_phrases_parent_phrases_and_translate_model.dart';
import 'package:wisdom/data/model/word_and_phrases_and_translate_model.dart';
import 'package:wisdom/data/model/word_and_words_uz_model.dart';
import 'package:wisdom/data/model/word_model.dart';
import 'package:wisdom/data/model/words_and_parents_and_words_uz_model.dart';

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
            synonyms: wordWithAll.word!.synonyms,
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

  // Word
  List<SearchResultUzModel> mapWordDtoListToSearchUz(
      List<WordAndWordsUzModel>? searchByWordUzEntity, String searchText, String type) {
    List<SearchResultUzModel> searchResultUzList = [];
    List<SearchResultUzModel> execute = [];

    for (var element in searchByWordUzEntity!) {
      mapWordDtoToSearchResultUz(element, type, searchText, execute).forEach((element) {
        searchResultUzList.add(element);
        execute.add(element);
      });
    }

    return searchResultUzList;
  }

  List<SearchResultUzModel> mapWordDtoToSearchResultUz(
      WordAndWordsUzModel model, String type, String searchText, List<SearchResultUzModel> executor) {
    List<SearchResultUzModel> searchResultList = [];

    if (model.word!.startsWith(searchText) &&
        model.word![0] == searchText[0] &&
        model.word![0].toLowerCase() == searchText[0].toLowerCase() &&
        model.word![0].toUpperCase() == searchText[0].toUpperCase()) {
      var result = SearchResultUzModel(
          id: model.id,
          word: model.word ?? "",
          type: type,
          wordClass: model.wordClass,
          star: model.word == searchText ? 3 : 0);
      if (!executor.contains(result)) searchResultList.add(result);
    }
    return searchResultList;
  }

  List<SearchResultUzModel> mapWordDtoListToSearchParentUz(
      List<WordsAndParentsAndWordsUzModel>? searchByWordUzEntity, String searchText, String type) {
    List<SearchResultUzModel> searchResultUzList = [];
    List<SearchResultUzModel> execute = [];

    for (var element in searchByWordUzEntity!) {
      mapWordDtoToSearchResultParentUz(element, type, searchText, execute).forEach((element) {
        searchResultUzList.add(element);
        execute.add(element);
      });
    }

    return searchResultUzList;
  }

  List<SearchResultUzModel> mapWordDtoToSearchResultParentUz(
      WordsAndParentsAndWordsUzModel model, String type, String searchText, List<SearchResultUzModel> executor) {
    List<SearchResultUzModel> searchResultList = [];

    if (model.word!.startsWith(searchText) &&
        model.word![0] == searchText[0] &&
        model.word![0].toLowerCase() == searchText[0].toLowerCase() &&
        model.word![0].toUpperCase() == searchText[0].toUpperCase()) {
      var result = SearchResultUzModel(
          id: model.id,
          word: model.word ?? "",
          type: type,
          wordClass: model.wordClass,
          star: model.word == searchText ? 3 : 0);
      if (!executor.contains(result)) searchResultList.add(result);
    }
    return searchResultList;
  }

  List<SearchResultUzModel> mapWordDtoListToSearchPhrasesUz(
      List<WordAndPhrasesAndTranslateModel>? translateModel, String searchText, String type) {
    List<SearchResultUzModel> searchResultUzList = [];

    for (var element in translateModel!) {
      mapWordDtoToSearchUzResultForPhrase(element, type, searchText).forEach((element) {
        searchResultUzList.add(element);
      });
    }

    return searchResultUzList;
  }

  List<SearchResultUzModel> mapWordDtoToSearchUzResultForPhrase(
      WordAndPhrasesAndTranslateModel model, String type, String searchText) {
    List<SearchResultUzModel> searchResultList = [];

    if (model.word!.startsWith(searchText) &&
        model.word![0] == searchText[0] &&
        model.word![0].toLowerCase() == searchText[0].toLowerCase() &&
        model.word![0].toUpperCase() == searchText[0].toUpperCase()) {
      var result = SearchResultUzModel(
          id: model.id,
          word: model.word ?? "",
          type: type,
          wordClass: model.wordClass,
          star: model.word == searchText ? 3 : 0);
      searchResultList.add(result);
    }
    return searchResultList;
  }

  List<SearchResultUzModel> mapWordDtoListToSearchUzParentPhrase(
      List<WordAndParentsAndPhrasesAndTranslateModel>? translateModel, String searchText, String type) {
    List<SearchResultUzModel> searchResultUzList = [];
    List<SearchResultUzModel> execute = [];

    for (var element in translateModel!) {
      mapWordDtoToSearchResultParentTranslate(element, type, searchText, execute).forEach((element) {
        searchResultUzList.add(element);
        execute.add(element);
      });
    }
    return searchResultUzList;
  }

  List<SearchResultUzModel> mapWordDtoToSearchResultParentTranslate(WordAndParentsAndPhrasesAndTranslateModel model,
      String type, String searchText, List<SearchResultUzModel> execute) {
    List<SearchResultUzModel> searchResultList = [];

    if (model.word!.startsWith(searchText)) {
      var result = SearchResultUzModel(
          id: model.id,
          word: model.word ?? "",
          type: type,
          wordClass: model.wordClass,
          star: model.word == searchText ? 3 : 0);
      if (!execute.contains(result)) searchResultList.add(result);
    }
    return searchResultList;
  }

  List<SearchResultUzModel> mapWordDtoListToSearchUzParentPhraseTranslate(
      List<WordAndParentsAndPhrasesParentPhrasesAndTranslateModel>? translateModel, String searchText, String type) {
    List<SearchResultUzModel> searchResultUzList = [];
    List<String> execute = [];

    for (var element in translateModel!) {
      mapWordDtoToSearchResultParentPhraseTranslate(element, type, searchText, execute).forEach((element) {
        searchResultUzList.add(element);
      });
    }
    return searchResultUzList;
  }

  List<SearchResultUzModel> mapWordDtoToSearchResultParentPhraseTranslate(
      WordAndParentsAndPhrasesParentPhrasesAndTranslateModel model,
      String type,
      String searchText,
      List<String> execute) {
    List<SearchResultUzModel> searchResultList = [];

    if (model.word!.startsWith(searchText) && (!execute.contains(model.word ?? ""))) {
      var result = SearchResultUzModel(
          id: model.id,
          word: model.word ?? "",
          type: type,
          wordClass: model.wordClass,
          star: model.word == searchText ? 3 : 0);
      searchResultList.add(result);
    }
    return searchResultList;
  }
}
