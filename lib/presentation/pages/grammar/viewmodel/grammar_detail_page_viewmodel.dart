import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../domain/repositories/category_repository.dart';

class GrammarDetailPageViewModel extends BaseViewModel {
  GrammarDetailPageViewModel({
    required super.context,
    required this.homeRepository,
    required this.categoryRepository,
    required this.localViewModel,
  });

  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
  final LocalViewModel localViewModel;
  final String getGrammarDetailsTag = 'getGrammarDetails';

  String? getGrammar() {
    return homeRepository.timelineModel.grammar!.worden!.word;
  }

  Future getGrammarDetails() async {
    safeBlock(() async {
      if (homeRepository.timelineModel.grammar != null) {
        await categoryRepository.getGrammarDetail(homeRepository.timelineModel.grammar!.id!);
        if (categoryRepository.grammarDetailModel.gBody != null) {
          setSuccess(tag: getGrammarDetailsTag);
        } else {
          callBackError("text");
        }
      }
    }, callFuncName: 'getGrammarDetails', tag: getGrammarDetailsTag);
  }

  goBack() {
    if(localViewModel.isFromMain) {
      localViewModel.isFromMain = false;
      localViewModel.changePageIndex(0);
    } else {
      localViewModel.changePageIndex(11);
    }
  }
}
