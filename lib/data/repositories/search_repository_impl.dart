import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/utils/word_mapper.dart';
import 'package:wisdom/data/model/search_result_model.dart';
import 'package:wisdom/domain/repositories/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl(this.dbHelper, this.mapper);

  final DBHelper dbHelper;
  final WordMapper mapper;

  List<SearchResultModel> _searchResult = [];

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
  Future<void> cleanList() async {
    _searchResult.clear();
  }

  @override
  List<SearchResultModel> get searchResultList => _searchResult;
}
