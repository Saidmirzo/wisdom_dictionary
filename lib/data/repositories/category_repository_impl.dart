import 'dart:convert';

import 'package:http/http.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/data/model/catalog_view_model.dart';
import 'package:wisdom/data/model/culture_model.dart';
import 'package:wisdom/data/model/word_with_collocation_model.dart';
import 'package:wisdom/data/model/word_with_difference_model.dart';
import 'package:wisdom/data/model/word_with_grammar_model.dart';
import 'package:wisdom/data/model/word_with_metaphor_model.dart';
import 'package:wisdom/data/model/word_with_theasurus_model.dart';
import '../../config/constants/urls.dart';
import '../../domain/repositories/category_repository.dart';
import '../model/catalog_model.dart';
import '../model/word_with_culture_model.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  CategoryRepositoryImpl(this.dbHelper);

  final DBHelper dbHelper;
  WordWithGrammarModel _grammarModel = WordWithGrammarModel();
  WordWithDifferenceModel _differenceModel = WordWithDifferenceModel();
  WordWithTheasurusModel _theasurusModel = WordWithTheasurusModel();
  WordWithCollocationModel _collocationModel = WordWithCollocationModel();
  WordWithMetaphorModel _metaphorModel = WordWithMetaphorModel();
  WordWithCultureModel _cultureDetailModel = WordWithCultureModel();
  CatalogViewModel _spaekingModel = CatalogViewModel();
  List<CatalogModel> _grammarWordsList = [];
  List<CatalogModel> _theasurusWordsList = [];
  List<CatalogModel> _differenceWordsList = [];
  List<CatalogModel> _metaphorWordsList = [];
  List<CatalogModel> _cultureWordsList = [];
  List<CatalogModel> _speakingWordsList = [];
  CultureModel _cultureModel = CultureModel();

  @override
  Future<void> getGrammarDetail(int gId) async {
    var response = await dbHelper.getTimeLineGrammar1(gId.toString());
    if (response != null) {
      _grammarModel =
          WordWithGrammarModel(id: response.id, word: response.word, gBody: response.gBody, gId: response.gId);
    }
  }

  @override
  Future<void> getDifferenceDetail(int dId) async {
    var response = await dbHelper.getTimeLineDifference(dId.toString());
    if (response != null) {
      _differenceModel = WordWithDifferenceModel(dId: response.dId, dBody: response.dBody, dWord: response.dWord);
    }
  }

  @override
  Future<void> getThesaurusDetail(int thId) async {
    var response = await dbHelper.getTimeLineThesaurus(thId.toString());
    if (response != null) {
      _theasurusModel =
          WordWithTheasurusModel(id: response.id, tId: response.tId, word: response.word, tBody: response.tBody);
    }
  }

  @override
  Future<void> getCollocationDetail(int cId) async {
    var response = await dbHelper.getTimeLineCollocation(cId.toString());
    if (response != null) {
      _collocationModel =
          WordWithCollocationModel(id: response.id, cId: response.cId, word: response.word, cBody: response.cBody);
    }
  }

  @override
  Future<void> getMetaphorDetail(int cId) async {
    var response = await dbHelper.getTimeLineMetaphor(cId.toString());
    if (response != null) {
      _metaphorModel =
          WordWithMetaphorModel(id: response.id, mId: response.mId, word: response.word, mBody: response.mBody);
    }
  }

  @override
  Future<void> getSpeakingDetail(int id) async {
    var response = await get(Urls.getSpeakingView(id));
    if (response.statusCode == 200) {
      _spaekingModel = CatalogViewModel.fromJson(jsonDecode(response.body));
    } else {
      throw VMException(response.body, callFuncName: 'getSpeakingDetail', response: response);
    }
  }

  @override
  Future<void> getCultureDetail(int id) async {
    var response = await dbHelper.getTimeLineCulture(id.toString());
    if (response != null) {
      _cultureDetailModel =
          WordWithCultureModel(id: response.id, cId: response.cId, word: response.word, cBody: response.cBody);
    }
  }

  @override
  Future<void> getGrammarWordsList(String? searchText) async {
    List<CatalogModel>? response = [];
    if (searchText != null) {
      response = await dbHelper.getIfWordIsWordenList("grammar", searchText);
    } else {
      response = await dbHelper.getCatalogsList("grammar");
    }
    if (response != null) {
      _grammarWordsList = [];
      _grammarWordsList.addAll(response);
    }
  }

  @override
  Future<void> getThesaurusWordsList(String? searchText) async {
    List<CatalogModel>? response = [];
    if (searchText != null) {
      response = await dbHelper.getIfWordIsWordenList("thesaurus", searchText);
    } else {
      response = await dbHelper.getCatalogsList("thesaurus");
    }
    if (response != null) {
      _theasurusWordsList = [];
      _theasurusWordsList.addAll(response);
    }
  }

  @override
  Future<void> getDifferenceWordsList(String? searchText) async {
    List<CatalogModel>? response;
    if (searchText != null) {
      response = await dbHelper.getCatalogWordList("differences", searchText);
    } else {
      response = await dbHelper.getCatalogsList("differences");
    }
    if (response != null) {
      _differenceWordsList = [];
      _differenceWordsList.addAll(response);
    }
  }

  @override
  Future<void> getMetaphorWordsList(String? searchText) async {
    List<CatalogModel>? response = [];
    if (searchText != null) {
      response = await dbHelper.getIfWordIsWordenList("metaphoras", searchText);
    } else {
      response = await dbHelper.getCatalogsList("metaphoras");
    }
    if (response != null) {
      _metaphorWordsList = [];
      _metaphorWordsList.addAll(response);
    }
  }

  @override
  Future<void> getCultureWordsList(String? searchText) async {
    List<CatalogModel>? response = [];
    if (searchText != null) {
      response = await dbHelper.getIfWordIsWordenList("culture", searchText);
    } else {
      response = await dbHelper.getCatalogsList("culture");
    }
    if (response != null) {
      _cultureWordsList = [];
      _cultureWordsList.addAll(response);
    }
  }

  @override
  Future<void> getSpeakingWordsList(String? categoryId, String? title, String? word) async {
    List<CatalogModel>? response = [];
    if (categoryId== null) {
      if (title != null) {
        response = await dbHelper.getTitleList("speaking", title);
      } else {
        response = await dbHelper.getCatalogsList("speaking");
      }
    } else if(word == null) {
      if (title != null) {
        response = await dbHelper.getTitleList(categoryId, title);
      } else {
        response = await dbHelper.getTitleList(categoryId, null);
      }
    } else {
      if (word != null) {
        response = await dbHelper.getCatalogWordList(categoryId, word);
      }
    }
    if (response != null) {
      _speakingWordsList = [];
      _speakingWordsList.addAll(response);
    }
  }

  @override
  WordWithGrammarModel get grammarDetailModel => _grammarModel;

  @override
  WordWithDifferenceModel get differenceDetailModel => _differenceModel;

  @override
  WordWithTheasurusModel get thesaurusDetailModel => _theasurusModel;

  @override
  WordWithCollocationModel get collocationDetailModel => _collocationModel;

  @override
  WordWithMetaphorModel get metaphorDetailModel => _metaphorModel;

  @override
  CatalogViewModel get speakingDetailModel => _spaekingModel;

  @override
  List<CatalogModel> get grammarWordsList => _grammarWordsList;

  @override
  List<CatalogModel> get thesaurusWordsList => _theasurusWordsList;

  @override
  List<CatalogModel> get differenceWordsList => _differenceWordsList;

  @override
  List<CatalogModel> get metaphorWordsList => _metaphorWordsList;

  @override
  List<CatalogModel> get cultureWordsList => _cultureWordsList;

  @override
  CultureModel get cultureModel => _cultureModel;

  @override
  set cultureModel(CultureModel cultureModel) {
    _cultureModel = cultureModel;
  }

  @override
  WordWithCultureModel get cultureDetailModel => _cultureDetailModel;

  @override
  List<CatalogModel> get speakingWordsList => _speakingWordsList;
}
