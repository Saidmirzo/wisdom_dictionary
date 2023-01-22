import '../../data/model/search_result_model.dart';

abstract class SearchRepository {
  Future<void> searchByWord(String searchText);

  Future<void> cleanList();

  List<SearchResultModel> get searchResultList;
}
