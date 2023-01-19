import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../data/model/catalog_model.dart';
import '../../../../data/model/timeline_model.dart';
import '../../../../domain/repositories/category_repository.dart';

class MetaphorPageViewModel extends BaseViewModel {
  MetaphorPageViewModel(
      {required super.context,
      required this.homeRepository,
      required this.categoryRepository,
      required this.localViewModel});

  final LocalViewModel localViewModel;
  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
  final String getMetaphorTag = 'getMetaphorTag';

  getMetaphorWordsList(String? searchText) {
    safeBlock(() async {
      if (searchText != null && searchText.trim().isNotEmpty) {
        await categoryRepository.getMetaphorWordsList(searchText.trim());
      } else {
        await categoryRepository.getMetaphorWordsList(null);
      }
      if (categoryRepository.metaphorWordsList.isNotEmpty) {
        setSuccess(tag: getMetaphorTag);
      } else {
        callBackError("text");
      }
    }, callFuncName: 'getMetaphorWordsList', tag: getMetaphorTag);
  }

  goMain() {
    localViewModel.changePageIndex(3);
  }

  goToDetails(CatalogModel catalogModel) {
    homeRepository.timelineModel.metaphor =
        Collocation(id: catalogModel.id, worden: Worden(id: catalogModel.wordenid, word: catalogModel.wordenword));
    localViewModel.isFromMain = false;
    localViewModel.changePageIndex(9);
  }
}
