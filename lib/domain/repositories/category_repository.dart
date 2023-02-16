import 'package:wisdom/data/model/catalog_view_model.dart';
import 'package:wisdom/data/model/culture_model.dart';
import 'package:wisdom/data/model/word_entity_model.dart';
import 'package:wisdom/data/model/word_with_collocation_model.dart';
import 'package:wisdom/data/model/word_with_culture_model.dart';
import 'package:wisdom/data/model/word_with_difference_model.dart';
import 'package:wisdom/data/model/word_with_grammar_model.dart';
import 'package:wisdom/data/model/word_with_metaphor_model.dart';
import 'package:wisdom/data/model/word_with_theasurus_model.dart';

import '../../data/model/catalog_model.dart';

abstract class CategoryRepository {
  Future<void> getGrammarDetail(int gId);

  Future<void> getDifferenceDetail(int dId);

  Future<void> getThesaurusDetail(int thId);

  Future<void> getCollocationDetail(int cId);

  Future<void> getMetaphorDetail(int cId);

  Future<void> getSpeakingDetail(int id);

  Future<void> getCultureDetail(int id);

  Future<void> getGrammarWordsList(String? searchText);

  Future<void> getThesaurusWordsList(String? searchText);

  Future<void> getDifferenceWordsList(String? searchText);

  Future<void> getMetaphorWordsList(String? searchText);

  Future<void> getCultureWordsList(String? searchText);

  Future<void> getSpeakingWordsList(String? categoryId, String? title, String? word, bool isInside);

  WordWithGrammarModel get grammarDetailModel;

  WordWithDifferenceModel get differenceDetailModel;

  WordWithTheasurusModel get thesaurusDetailModel;

  WordWithCollocationModel get collocationDetailModel;

  WordWithMetaphorModel get metaphorDetailModel;

  WordWithCultureModel get cultureDetailModel;

  CatalogViewModel get speakingDetailModel;

  List<CatalogModel> get grammarWordsList;

  List<CatalogModel> get thesaurusWordsList;

  List<CatalogModel> get differenceWordsList;

  List<CatalogModel> get metaphorWordsList;

  List<CatalogModel> get cultureWordsList;

  List<CatalogModel> get speakingWordsList;

  CultureModel get cultureModel;

  set cultureModel(CultureModel cultureModel);
}
