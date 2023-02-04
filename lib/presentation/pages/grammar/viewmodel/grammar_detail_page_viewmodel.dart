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
  });

  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
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
    if(locator<LocalViewModel>().isFromMain) {
      locator<LocalViewModel>().isFromMain = false;
      locator<LocalViewModel>().changePageIndex(0);
    } else {
      locator<LocalViewModel>().changePageIndex(11);
    }
  }
}
