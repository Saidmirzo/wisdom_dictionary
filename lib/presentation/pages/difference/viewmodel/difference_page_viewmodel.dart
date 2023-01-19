import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../data/model/catalog_model.dart';
import '../../../../data/model/timeline_model.dart';
import '../../../../domain/repositories/category_repository.dart';

class DifferencePageViewModel extends BaseViewModel {
  DifferencePageViewModel(
      {required super.context,
      required this.homeRepository,
      required this.categoryRepository,
      required this.localViewModel});

  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
  final LocalViewModel localViewModel;
  final String getDifferenceTag = 'getDifference';

  Future getDifferenceWordsList(String? searchText) async {
    safeBlock(() async {
      if (searchText != null && searchText.trim().isNotEmpty) {
        await categoryRepository.getDifferenceWordsList(searchText.trim().toString());
      } else {
        await categoryRepository.getDifferenceWordsList(null);
      }
      if (categoryRepository.differenceWordsList.isNotEmpty) {
        setSuccess(tag: getDifferenceTag);
      } else {
        callBackError("text");
      }
    }, callFuncName: 'getDifferenceWordsList', tag: getDifferenceTag);
  }

  goMain() {
    localViewModel.changePageIndex(3);
  }

  goToDetails(CatalogModel catalogModel) {
    homeRepository.timelineModel.difference = Difference(id: catalogModel.id, word: catalogModel.word);
    localViewModel.isFromMain = false;
    localViewModel.changePageIndex(6);
  }
}
