import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/model/catalog_model.dart';
import 'package:wisdom/data/model/culture_model.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../domain/repositories/category_repository.dart';

class CulturePageViewModel extends BaseViewModel {
  CulturePageViewModel(
      {required super.context,
      required this.localViewModel,
      required this.categoryRepository,
      required this.homeRepository});

  final LocalViewModel localViewModel;
  final CategoryRepository categoryRepository;
  final HomeRepository homeRepository;

  final String getCultureTag = 'getCultureTag';

  void getCultureWordsList(String? searchText) {
    safeBlock(() async {
      if (searchText != null && searchText.trim().isNotEmpty) {
        await categoryRepository.getCultureWordsList(searchText.trim());
      } else {
        await categoryRepository.getCultureWordsList(null);
      }
      if (categoryRepository.cultureWordsList.isNotEmpty) {
        setSuccess(tag: getCultureTag);
      } else {
        callBackError("text");
      }
    }, callFuncName: 'getCulture', tag: getCultureTag);
  }

  goMain() {
    localViewModel.changePageIndex(3);
  }

  void goToDetails(CatalogModel catalogModel) {
    categoryRepository.cultureModel =
        CultureModel(id: catalogModel.id, wordId: catalogModel.wordenid, body: catalogModel.wordenword);
    localViewModel.isFromMain = false;
    localViewModel.changePageIndex(16);
  }
}
