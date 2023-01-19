import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/utils/word_mapper.dart';
import 'package:wisdom/data/model/word_model.dart';
import 'package:wisdom/domain/repositories/search_repository.dart';

class SearchRepositoryImpl extends SearchRepository {
  SearchRepositoryImpl(this.dbHelper, this.mapper);

  final DBHelper dbHelper;
  final WordMapper mapper;

  List<WordModel> _wordList = [];

  @override
  Future<void> searchByWord(String searchText) async {

    var searchByWordEntity = await dbHelper.searchByWord(searchText);
    var searchByWordList = mapper.wordEntityListToSearchResultList(searchByWordEntity!, 'word');

    var searchByPhrasesEntity = await dbHelper.searchByPhrases(searchText);
    var searchByPhrasesList = await dbHelper.searchByPhrases(searchText);


    var searchByPhrases1 = await dbHelper.searchByWordParent1(searchText);
    // if (response != null) {
    //   _wordList = [];
    //   _wordList.addAll();
    // }
  }

  @override
  List<WordModel> get wordList => _wordList;

  @override
  set wordList(List<WordModel> newList) {
    _wordList = newList;
  }
}
