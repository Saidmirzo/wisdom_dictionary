import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/model/word_bank_model.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/word_entity_repository.dart';

class WordBankViewModel extends BaseViewModel {
  WordBankViewModel({
    required super.context,
    required this.wordEntityRepository,
    required this.localViewModel,
  });

  final WordEntityRepository wordEntityRepository;
  final LocalViewModel localViewModel;
  final String getWordBankListTag = 'getWordBankListTag';

  getWordBankList(String? searchText) {
    safeBlock(
      () async {
        if (searchText != null && searchText.isNotEmpty) {
          await wordEntityRepository.getWordBankList(searchText);
        } else {
          await wordEntityRepository.getWordBankList("");
        }
        setSuccess(tag: getWordBankListTag);
      },
      callFuncName: 'getWordBankList',
    );
  }

  goBackToMain() {
    localViewModel.changePageIndex(0);
  }

  deleteWordBank(WordBankModel model) {
    safeBlock(
      () async {
        await wordEntityRepository.deleteWorkBank(model);
        localViewModel.changeBadgeCount(-1);
        notifyListeners();
      },
      callFuncName: 'deleteWordBankModel',
    );
  }
}
