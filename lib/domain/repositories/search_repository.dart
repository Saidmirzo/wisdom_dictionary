import '../../data/model/word_model.dart';

abstract class SearchRepository {
  Future<void> searchByWord(String searchText);

  List<WordModel> get wordList;
  set wordList(List<WordModel> newList);
}
