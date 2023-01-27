import 'package:wisdom/data/model/search_result_uz_model.dart';

import '../../data/model/search_result_model.dart';

abstract class SearchRepository {
  Future<void> searchByWord(String searchText);

  Future<void> searchByUzWord(String searchText);

  Future<void> cleanList(String mode);

  List<SearchResultModel> get searchResultList;

  List<SearchResultUzModel> get searchResultUzList;
}
