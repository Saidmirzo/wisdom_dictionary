import 'package:wisdom/data/model/word_entity_model.dart';
import 'package:wisdom/data/model/word_path_model/word_path_model.dart';

abstract class WordEntityRepository {
  Future<void> getWordEntity(String pathUri);
  Future<void> getWordsVersion();
  Future<void> getWordsPaths();

  List<WordEntityModel> get wordWordEntityList;
  WordPathModel get wordPathModel;
}