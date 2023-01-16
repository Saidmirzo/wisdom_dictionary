import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../domain/repositories/category_repository.dart';

class MetaphorDetailPageViewModel extends BaseViewModel {
  MetaphorDetailPageViewModel({
    required super.context,
    required this.homeRepository,
    required this.categoryRepository,
  });

  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
  final String getMetaphorDetailsTag = 'getMetaphorDetailsTag';

  String? getMetaphor() {
    return homeRepository.timelineModel.metaphor!.worden!.word;
  }

  Future getMetaphorDetails() async {
    safeBlock(() async {
      if (homeRepository.timelineModel.metaphor != null) {
        await categoryRepository.getMetaphorDetail(homeRepository.timelineModel.metaphor!.id!);
        if (categoryRepository.metaphorDetailModel.mBody != null) {
          setSuccess(tag: getMetaphorDetailsTag);
        } else {
          callBackError("text");
        }
      }
    }, callFuncName: 'getMetaphorDetails', tag: getMetaphorDetailsTag);
  }

  goBack() {
    if(locator<LocalViewModel>().isFromMain) {
      locator<LocalViewModel>().changePageIndex(0);
    } else {
      locator<LocalViewModel>().changePageIndex(14);
    }
  }
}
