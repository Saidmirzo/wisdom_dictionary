import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/model/exercise_model.dart';
import 'package:wisdom/data/model/word_bank_model.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/word_entity_repository.dart';

class ExerciseFinalPageViewModel extends BaseViewModel {
  ExerciseFinalPageViewModel({
    required super.context,
    required this.localViewModel,
    required this.wordEntityRepository,
  });

  final LocalViewModel localViewModel;
  final WordEntityRepository wordEntityRepository;

  List<ExerciseFinalModel> correctList = [];
  List<ExerciseFinalModel> incorrect = [];

  init() async {
    for (var element in localViewModel.finalList) {
      element.result ? correctList.add(element) : incorrect.add(element);
    }
    notifyListeners();
  }

  goBack() {
    localViewModel.changePageIndex(1);
  }

  deleteWordBank(ExerciseFinalModel model) {
    safeBlock(
      () async {
        var wordBank = WordBankModel(id: model.id, word: model.word, translation: model.translation);
        await wordEntityRepository.deleteWorkBank(wordBank);
        localViewModel.finalList.remove(model);
        correctList.remove(model);
        localViewModel.changeBadgeCount(-1);
        notifyListeners();
      },
      callFuncName: 'deleteWordBankModel',
      inProgress: false,
    );
  }
}
