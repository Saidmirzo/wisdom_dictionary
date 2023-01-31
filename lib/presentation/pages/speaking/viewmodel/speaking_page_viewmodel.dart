import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../data/model/catalog_model.dart';
import '../../../../data/model/timeline_model.dart';
import '../../../../domain/repositories/category_repository.dart';

class SpeakingPageViewModel extends BaseViewModel {
  SpeakingPageViewModel(
      {required super.context,
      required this.homeRepository,
      required this.categoryRepository,
      required this.localViewModel});

  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
  final LocalViewModel localViewModel;

  final String getSpeakingTag = 'getSpeaking';

  Future getSpeakingWordsList() async {
    safeBlock(() async {
      await categoryRepository.getSpeakingWordsList(null, null);
      if (categoryRepository.speakingWordsList.isNotEmpty) {
        setSuccess(tag: getSpeakingTag);
      } else {
        callBackError("text");
      }
    }, callFuncName: 'getSpeakingWordsList', tag: getSpeakingTag);
  }

  goMain() {
    localViewModel.changePageIndex(3);
    // if (localViewModel.isTitle) {
    //   localViewModel.isTitle = false;
    //   localViewModel.changePageIndex(3);
    // }
    // if (localViewModel.isSubSub) {
    //   localViewModel.isSubSub = false;
    // }
  }

  goToNext(CatalogModel catalogModel) {
    if (!localViewModel.isTitle) {
      homeRepository.timelineModel.speaking = Speaking(id: catalogModel.id, word: catalogModel.title);
      localViewModel.isTitle = true;
    }
    if (!localViewModel.isSubSub) {
      localViewModel.isSubSub = true;
    }
    localViewModel.changePageIndex(16);
    // localViewModel.isFromMain = false;
  }
}
