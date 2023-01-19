import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/model/catalog_model.dart';
import 'package:wisdom/data/model/timeline_model.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../domain/repositories/category_repository.dart';

class GrammarPageViewModel extends BaseViewModel {
  GrammarPageViewModel(
      {required super.context,
      required this.localViewModel,
      required this.categoryRepository,
      required this.homeRepository});

  final LocalViewModel localViewModel;
  final CategoryRepository categoryRepository;
  final HomeRepository homeRepository;

  final String getGrammarTag = 'getGrammarTag';

  void getGrammarWordsList(String? searchText) {
    safeBlock(() async {
      if (searchText != null && searchText.trim().isNotEmpty) {
        await categoryRepository.getGrammarWordsList(searchText.trim().toString());
      } else {
        await categoryRepository.getGrammarWordsList(null);
      }
      if (categoryRepository.grammarWordsList.isNotEmpty) {
        setSuccess(tag: getGrammarTag);
      } else {
        callBackError("text");
      }
    }, callFuncName: 'getGrammar', tag: getGrammarTag);
  }

  goMain() {
    localViewModel.changePageIndex(3);
  }

  goToDetails(CatalogModel catalogModel) {
    homeRepository.timelineModel.grammar =
        Collocation(id: catalogModel.id, worden: Worden(id: catalogModel.wordenid, word: catalogModel.wordenword));
    localViewModel.isFromMain = false;
    localViewModel.changePageIndex(5);
  }
}
