import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../domain/repositories/category_repository.dart';

class SpeakingDetailPageViewModel extends BaseViewModel {
  SpeakingDetailPageViewModel(
      {required super.context,
      required this.homeRepository,
      required this.categoryRepository,
      required this.localViewModel});

  final HomeRepository homeRepository;
  final LocalViewModel localViewModel;
  final CategoryRepository categoryRepository;
  final String getSpeakingDetailsTag = 'getSpeakingDetails';

  String? getSpeaking() {
    return homeRepository.timelineModel.speaking!.word;
  }

  Future getSpeakingDetails() async {
    safeBlock(() async {
      if (homeRepository.timelineModel.speaking != null) {
        await categoryRepository.getSpeakingDetail(homeRepository.timelineModel.speaking!.id!);
        if (categoryRepository.speakingDetailModel.body != null) {
          setSuccess(tag: getSpeakingDetailsTag);
        } else {
          callBackError("text");
        }
      }
    }, callFuncName: 'getSpeakingDetails', tag: getSpeakingDetailsTag);
  }

  goBack() {
    if (localViewModel.isFromMain) {
      localViewModel.isFromMain = false;
      localViewModel.changePageIndex(0);
    } else {
      localViewModel.speakingCatalogModel.id = int.parse(localViewModel.speakingCatalogModel.category ?? "0");
      localViewModel.changePageIndex(17);
    }
  }
}
