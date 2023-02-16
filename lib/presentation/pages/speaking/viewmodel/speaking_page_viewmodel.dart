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

  Future getSpeakingWordsList(String? searchText) async {
    safeBlock(() async {
      if (localViewModel.isSubSub) {
        if (searchText != null && searchText.trim().isNotEmpty) {
          await categoryRepository.getSpeakingWordsList(
              localViewModel.speakingCatalogModel.id.toString(), null, searchText.trim(),true);
        } else {
          await categoryRepository.getSpeakingWordsList(localViewModel.speakingCatalogModel.id.toString(), null, null, true);
        }
      } else if (localViewModel.isTitle) {
        localViewModel.subId = localViewModel.speakingCatalogModel.id ?? 0;
        if (searchText != null && searchText.trim().isNotEmpty) {
          await categoryRepository.getSpeakingWordsList(
              localViewModel.speakingCatalogModel.id.toString(), searchText.trim(), null, false);
        } else {
          await categoryRepository.getSpeakingWordsList(localViewModel.speakingCatalogModel.id.toString(), null, null, false);
        }
      } else {
        if (searchText != null && searchText.trim().isNotEmpty) {
          await categoryRepository.getSpeakingWordsList(null, searchText.trim(), null, false);
        } else {
          await categoryRepository.getSpeakingWordsList(null, null, null, false);
        }
      }
      if (categoryRepository.speakingWordsList.isNotEmpty) {
        setSuccess(tag: getSpeakingTag);
      } else {
        callBackError("text");
      }
    }, callFuncName: 'getSpeakingWordsList', tag: getSpeakingTag);
  }

  goMain() {
    if (localViewModel.isSubSub) {
      localViewModel.speakingCatalogModel.id = localViewModel.subId;
      localViewModel.isSubSub = false;
      getSpeakingWordsList(null); // opening this page again but with another value
      localViewModel.notifyListeners();
    } else if (localViewModel.isTitle) {
      localViewModel.isTitle = false;
      getSpeakingWordsList(null); // opening this page again but with another value
      localViewModel.notifyListeners();
    } else {
      localViewModel.changePageIndex(3);
    }
  }

  goToNext(CatalogModel catalogModel) {
    localViewModel.speakingCatalogModel = catalogModel;
    if (!localViewModel.isTitle) {
      var title = catalogModel.title;
      if (catalogModel.title!.length > 28) title = catalogModel.title!.substring(0, 27).replaceRange(24, 27, '...');
      homeRepository.timelineModel.speaking = Speaking(id: catalogModel.id, word: title);
      localViewModel.isTitle = true;
      getSpeakingWordsList(null); // opening this page again but with another value
      localViewModel.notifyListeners();
    } else if (!localViewModel.isSubSub) {
      var title = catalogModel.title;
      if (catalogModel.title!.length > 28) title = catalogModel.title!.substring(0, 27).replaceRange(24, 27, '...');
      homeRepository.timelineModel.speaking = Speaking(id: catalogModel.id, word: title);
      localViewModel.isSubSub = true;
      getSpeakingWordsList(null); // opening this page again but with another value
      localViewModel.notifyListeners();
    }
    // else
    //   if (!localViewModel.isFinal) {
    //   localViewModel.isFromMain = false;
    //   homeRepository.timelineModel.speaking = Speaking(id: catalogModel.id, word: catalogModel.word);
    //   localViewModel.changePageIndex(10);
    // }
    // localViewModel.isFromMain = false;
  }
}
