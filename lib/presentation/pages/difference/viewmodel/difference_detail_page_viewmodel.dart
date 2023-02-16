import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../domain/repositories/category_repository.dart';

class DifferenceDetailPageViewModel extends BaseViewModel {
  DifferenceDetailPageViewModel({
    required super.context,
    required this.homeRepository,
    required this.categoryRepository,
    required this.localViewModel,
  });

  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
  final LocalViewModel localViewModel;
  final String getDifferenceDetailsTag = 'getDifferenceDetails';

  String? getDifference() {
    return homeRepository.timelineModel.difference!.word;
  }

  Future getDifferenceDetails() async {
    safeBlock(() async {
      if (homeRepository.timelineModel.difference!.word != null) {
        await categoryRepository.getDifferenceDetail(homeRepository.timelineModel.difference!.id!);
        if (categoryRepository.differenceDetailModel.dBody != null) {
          setSuccess(tag: getDifferenceDetailsTag);
        } else {
          callBackError("text");
        }
      }
    }, callFuncName: 'getDifferenceDetails', tag: getDifferenceDetailsTag);
  }

  goBack() {
    if(localViewModel.isFromMain) {
      localViewModel.changePageIndex(0);
    } else {
      localViewModel.changePageIndex(13);
    }
  }
}
