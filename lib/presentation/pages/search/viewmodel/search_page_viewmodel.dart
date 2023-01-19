import 'dart:convert';

import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/data/model/recent_model.dart';
import 'package:wisdom/data/model/word_model.dart';
import 'package:wisdom/domain/repositories/search_repository.dart';

class SearchPageViewModel extends BaseViewModel {
  SearchPageViewModel(
      {required super.context, required this.preferenceHelper, required this.dbHelper, required this.searchRepository});

  final SharedPreferenceHelper preferenceHelper;
  final SearchRepository searchRepository;
  final DBHelper dbHelper;
  List<RecentModel> recentList = [];
  String initTag = 'initTag';
  String searchTag = 'searchTag';

  void searchByWord(String searchText) {
    safeBlock(
      () async {
        if (searchText.isNotEmpty) {
          await searchRepository.searchByWord(searchText.toString());
        } else {
          searchRepository.wordList = [];
          init();
        }
        setSuccess(tag: searchTag);
      },
      callFuncName: 'searchByWord',
    );
  }

  init() {
    safeBlock(
      () async {
        recentList = [];
        var recent = await getRecentHistory();
        recentList.addAll(recent);
        setSuccess(tag: initTag);
      },
      callFuncName: 'init',
    );
    setSuccess(tag: initTag);
  }

  saveRecentHistory(RecentModel recent) async {
    var _recentList = await getRecentHistory();
    if (_recentList.length == 10) {
      _recentList.removeAt(_recentList.length - 1);
    }
    if (_recentList.contains(recent)) {
      _recentList.remove(recent);
    }
    _recentList.insert(0, recent);
    var json = jsonEncode(_recentList);
    preferenceHelper.putString(Constants.KEY_RECENT, json);
  }

  Future<List<RecentModel>> getRecentHistory() async {
    List<RecentModel> newList = [];
    var list = (jsonDecode(preferenceHelper.getString(Constants.KEY_RECENT, "")) as List<dynamic>).cast<RecentModel>();
    newList.addAll(list);
    return newList;
  }
}
