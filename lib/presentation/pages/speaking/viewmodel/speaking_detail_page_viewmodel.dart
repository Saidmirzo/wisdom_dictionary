import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../domain/repositories/category_repository.dart';

class SpeakingDetailPageViewModel extends BaseViewModel {
  SpeakingDetailPageViewModel({
    required super.context,
    required this.homeRepository,
    required this.categoryRepository,
  });

  final HomeRepository homeRepository;
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
    locator<LocalViewModel>().changePageIndex(0);
  }
}
