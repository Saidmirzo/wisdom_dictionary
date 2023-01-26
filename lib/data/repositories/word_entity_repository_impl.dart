import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/urls.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/services/custom_client.dart';
import 'package:wisdom/data/model/phrases_with_all.dart';
import 'package:wisdom/data/model/word_bank_model.dart';
import 'package:wisdom/data/model/word_entity_model.dart';
import 'package:wisdom/data/model/word_path_model/word_path_model.dart';
import 'package:wisdom/domain/repositories/word_entity_repository.dart';

class WordEntityRepositoryImpl extends WordEntityRepository {
  WordEntityRepositoryImpl({required this.client, required this.dbHelper});

  final CustomClient client;
  final DBHelper dbHelper;
  List<WordEntityModel> _wordEntityList = [];
  List<WordBankModel> _wordBankModel = [];
  WordPathModel _wordPathModel = WordPathModel();
  WordWithAll _requitedWordWithAll = WordWithAll();

  // getting words from api
  @override
  Future<void> getWordEntity(String pathUri) async {
    var response = await get(Uri.parse('${Urls.baseUrl}$pathUri'));
    if (response.statusCode == 200) {
      _wordEntityList = [for (final item in jsonDecode(response.body)) WordEntityModel.fromJson(item)];
    } else {
      throw VMException(response.body, callFuncName: 'getWordEntity', response: response);
    }
    log('word are downloaded');
  }

  // getting words version, paths
  @override
  Future<void> getWordsPaths() async {
    var response = await get(Urls.getWordsPaths);
    if (response.statusCode == 200) {
      _wordPathModel = WordPathModel.fromJson(jsonDecode(response.body));
    } else {
      throw VMException(response.body, callFuncName: 'getWordsPaths', response: response);
    }
    log('word paths are downloaded');
  }

  @override
  Future<void> getWordsVersion() {
    throw UnimplementedError();
  }

  @override
  List<WordEntityModel> get wordWordEntityList => _wordEntityList;

  @override
  WordPathModel get wordPathModel => _wordPathModel;

  @override
  Future<void> getRequiredWord(int wordId) async {
    var response = await dbHelper.getWord1(wordId);
    if (response != null) {
      _requitedWordWithAll = response;
    }
  }

  @override
  WordWithAll get requiredWordWithAllModel => _requitedWordWithAll;

  @override
  Future<void> saveWordBank(WordBankModel model) async {
    _wordBankModel.add(model);
    dbHelper.saveToWordBank(model);
  }

  @override
  Future<void> getWordBankList(String text) async {
    _wordBankModel.clear();
    var response = await dbHelper.getWordBankList();
    if (response != null && response.isNotEmpty) {
      if (text.isNotEmpty) {
        for (var item in response) {
          if ((item.word ?? "").toUpperCase().contains(text.toUpperCase())) {
            _wordBankModel.add(item);
          }
        }
      } else {
        _wordBankModel.addAll(response);
      }
    }
  }

  @override
  List<WordBankModel> get wordBankList => _wordBankModel;

  @override
  Future<void> deleteWorkBank(WordBankModel model) async {
    _wordBankModel.remove(model);
    dbHelper.deleteWordBank(model);
  }
}
