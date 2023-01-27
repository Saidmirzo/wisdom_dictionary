import 'dart:convert';

import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/data/model/recent_model.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/search_repository.dart';

import '../../../../data/model/search_result_model.dart';

class SearchPageViewModel extends BaseViewModel {
  SearchPageViewModel({
    required super.context,
    required this.preferenceHelper,
    required this.dbHelper,
    required this.searchRepository,
    required this.localViewModel,
  });

  final SharedPreferenceHelper preferenceHelper;
  final SearchRepository searchRepository;
  final DBHelper dbHelper;
  final LocalViewModel localViewModel;
  List<RecentModel> recentList = [];
  String initTag = 'initTag';
  String searchTag = 'searchTag';
  String searchText = '';
  String searchLangMode = '';
  String searchLangKey = "searchLangKey";

  getSearchLanguageMode() async {
    searchLangMode = preferenceHelper.getString(searchLangKey, "en");
  }

  setSearchLanguageMode() {
    if (searchLangMode == "en") {
      searchLangMode = "uz";
    } else {
      searchLangMode = "en";
    }
    preferenceHelper.putString(searchLangKey, searchLangMode);
    notifyListeners();
  }

  void searchByWord(String searchText) {
    safeBlock(
      () async {
        this.searchText = searchText;
        if (searchText.isNotEmpty) {
          if (searchLangMode == 'en') {
            await searchRepository.searchByWord(searchText.toString());
          } else {
            await searchRepository.searchByUzWord(searchText.toString());
          }
        } else {
          await searchRepository.cleanList(searchLangMode);
          init();
        }
        if (searchRepository.searchResultList.isNotEmpty || searchRepository.searchResultUzList.isNotEmpty) {
          setSuccess(tag: searchTag);
        }
      },
      callFuncName: 'searchByWord',
    );
  }

  init() {
    safeBlock(
      () async {
        recentList.clear();
        var result = await getRecentHistory();
        await getSearchLanguageMode();
        if (result.isNotEmpty) {
          recentList.addAll(result);
          setSuccess(tag: initTag);
        }
      },
      callFuncName: 'init',
    );
  }

  goBackToMain() {
    localViewModel.changePageIndex(0);
  }

  goOnDetail(var model) {
    safeBlock(
      () async {
        RecentModel recentModel = RecentModel();
        if (model is SearchResultModel) {
          recentModel =
              RecentModel(id: model.id, word: model.word, wordClass: model.wordClasswordClass, type: model.type);
        } else {
          recentModel = model as RecentModel;
        }
        saveRecentHistory(recentModel);
        localViewModel.wordDetailModel = recentModel;
        localViewModel.changePageIndex(18);
      },
      callFuncName: 'goOnDetail',
    );
  }

  Future<void> saveRecentHistory(RecentModel recent) async {
    var _recentList = await getRecentHistory();
    if (_recentList.length == 10) {
      _recentList.removeAt(_recentList.length - 1);
    }
    var result = _recentList.singleWhere((it) => it.id == recent.id, orElse: () => RecentModel());
    if (result.word != null) {
      _recentList.remove(result);
    }
    _recentList.insert(0, recent);
    var json = jsonEncode(_recentList);
    if (searchLangMode == "en") {
      preferenceHelper.putString(Constants.KEY_RECENT, json);
    } else {
      preferenceHelper.putString(Constants.KEY_RECENT_UZ, json);
    }
  }

  void cleanHistory() {
    if (searchLangMode == 'en') {
      preferenceHelper.putString(Constants.KEY_RECENT, "");
    } else {
      preferenceHelper.putString(Constants.KEY_RECENT_UZ, "");
    }
    init();
  }

  Future<List<RecentModel>> getRecentHistory() async {
    List<RecentModel> newList = [];
    var json = "";
    if (searchLangMode == 'uz') {
      json = preferenceHelper.getString(Constants.KEY_RECENT, "");
    } else {
      json = preferenceHelper.getString(Constants.KEY_RECENT_UZ, "");
    }
    if (json.isNotEmpty) {
      List<dynamic> jsonList = jsonDecode(json);
      List<RecentModel> list = List<RecentModel>.from(jsonList.map((e) => RecentModel.fromJson(e)));
      newList.addAll(list);
    }
    return newList;
  }
}
