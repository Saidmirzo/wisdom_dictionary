import 'package:wisdom/data/model/phrases_with_all.dart';
import 'package:wisdom/data/model/word_bank_model.dart';
import 'package:wisdom/data/model/word_entity_model.dart';
import 'package:wisdom/data/model/word_path_model/word_path_model.dart';

abstract class WordEntityRepository {
  Future<void> getWordEntity(String pathUri);

  Future<void> getWordsVersion();

  Future<void> getWordsPaths();

  Future<void> getRequiredWord(int wordId);

  Future<void> saveWordBank(WordBankModel model);

  Future<int> getWordBankCount();

  Future<void> deleteWorkBank(WordBankModel model);

  Future<void> getWordBankList(String text);

  List<WordBankModel> get wordBankList;

  WordWithAll get requiredWordWithAllModel;

  List<WordEntityModel> get wordWordEntityList;

  WordPathModel get wordPathModel;
}
