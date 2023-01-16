import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../domain/repositories/category_repository.dart';

class CollocationDetailPageViewModel extends BaseViewModel {
  CollocationDetailPageViewModel({
    required super.context,
    required this.homeRepository,
    required this.categoryRepository,
  });

  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
  final String getCollocationDetailsTag = 'getThesaurusDetails';

  String? getCollocation() {
    return homeRepository.timelineModel.collocation!.worden!.word;
  }

  Future getCollocationDetails() async {
    safeBlock(() async {
      if (homeRepository.timelineModel.collocation != null) {
        await categoryRepository.getCollocationDetail(homeRepository.timelineModel.collocation!.id!);
        if (categoryRepository.collocationDetailModel.cBody != null) {
          setSuccess(tag: getCollocationDetailsTag);
        } else {
          callBackError("text");
        }
      }
    }, callFuncName: 'getGrammarDetails', tag: getCollocationDetailsTag);
  }

  goBack() {
    locator<LocalViewModel>().changePageIndex(0);
  }
}
