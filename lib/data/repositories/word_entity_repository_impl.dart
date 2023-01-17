import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/urls.dart';
import 'package:wisdom/core/services/custom_client.dart';
import 'package:wisdom/data/model/word_entity_model.dart';
import 'package:wisdom/data/model/word_path_model/word_path_model.dart';
import 'package:wisdom/domain/repositories/word_entity_repository.dart';

class WordEntityRepositoryImpl extends WordEntityRepository {
  WordEntityRepositoryImpl({required this.client});

  final CustomClient client;
  List<WordEntityModel> _wordEntityList = [];
  WordPathModel _wordPathModel = WordPathModel();

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
}
