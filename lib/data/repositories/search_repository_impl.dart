import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/utils/word_mapper.dart';
import 'package:wisdom/data/model/search_result_model.dart';
import 'package:wisdom/domain/repositories/search_repository.dart';

import '../model/search_result_uz_model.dart';

class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl(this.dbHelper, this.mapper);

  final DBHelper dbHelper;
  final WordMapper mapper;

  final List<SearchResultModel> _searchResult = [];
  final List<SearchResultUzModel> _searchUzResult = [];

  @override
  Future<void> searchByWord(String searchText) async {
    var searchByWordEntity = await dbHelper.searchByWord(searchText);
    var searchByWordList = mapper.wordEntityListToSearchResultList(searchByWordEntity!, 'word');

    var searchByPhrasesEntity = await dbHelper.searchByPhrases(searchText);
    var searchByPhrasesList = mapper.wordEntityListToSearchPhraseList(searchByPhrasesEntity!, 'phrases', searchText);

    var searchByPhrases1Entity = await dbHelper.searchByWordParent1(searchText);
    var searchByPhrases1List =
        await mapper.wordEntityListToSearchPhraseParentList(searchByPhrases1Entity!, 'phrases', searchText);

    _searchResult.clear();
    _searchResult.addAll(searchByWordList);
    _searchResult.addAll(searchByPhrasesList);
    _searchResult.addAll(searchByPhrases1List);
  }

  @override
  Future<void> searchByUzWord(String searchText) async {
    var searchByWordUzEntity = await dbHelper.searchByWordUz1(searchText);
    var searchByWordUzList = mapper.mapWordDtoListToSearchUz(searchByWordUzEntity, searchText, 'word');

    var searchWordUzParent1 = await dbHelper.searchByWordParent2(searchText);
    var searchWordUzParent1List = mapper.mapWordDtoListToSearchParentUz(searchWordUzParent1, searchText, "word");

    var searchPhraseWordUzEntity1 = await dbHelper.searchByPhrasesUz1(searchText);
    var searchPhraseWordUzEntity1List =
        mapper.mapWordDtoListToSearchPhrasesUz(searchPhraseWordUzEntity1, searchText, "phrases");

    var searchPhraseParentUz = await dbHelper.searchByWordParent3(searchText);
    var searchPhraseParentUzList =
        mapper.mapWordDtoListToSearchUzParentPhrase(searchPhraseParentUz, searchText, "phrases");

    var searchPhraseDtoParentPhraseTranslate1 =
        await dbHelper.searchWordAndParentsAndPhrasesParentPhrasesAndTranslate(searchText);
    var searchPhraseDtoParentPhraseTranslate1List = mapper.mapWordDtoListToSearchUzParentPhraseTranslate(
        searchPhraseDtoParentPhraseTranslate1, searchText, "phrases");

    _searchUzResult.clear();
    _searchUzResult.addAll(searchByWordUzList);
    _searchUzResult.addAll(searchWordUzParent1List);
    _searchUzResult.addAll(searchPhraseWordUzEntity1List);
    _searchUzResult.addAll(searchPhraseParentUzList);
    _searchUzResult.addAll(searchPhraseDtoParentPhraseTranslate1List);

    _searchUzResult.sort((a, b) => (b.star ?? 0).compareTo((a.star ?? 0)));

    // _searchUzResult.reversed;
  }

  @override
  Future<void> cleanList(String mode) async {
    if (mode == "en") {
      _searchResult.clear();
    } else {
      _searchUzResult.clear();
    }
  }

  @override
  List<SearchResultModel> get searchResultList => _searchResult;

  @override
  List<SearchResultUzModel> get searchResultUzList => _searchUzResult;
}
