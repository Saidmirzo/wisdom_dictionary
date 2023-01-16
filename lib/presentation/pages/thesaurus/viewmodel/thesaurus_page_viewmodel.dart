import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../data/model/catalog_model.dart';
import '../../../../data/model/timeline_model.dart';
import '../../../../domain/repositories/category_repository.dart';

class ThesaurusPageViewModel extends BaseViewModel {
  ThesaurusPageViewModel(
      {required super.context,
      required this.homeRepository,
      required this.categoryRepository,
      required this.localViewModel});

  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
  final LocalViewModel localViewModel;
  final String getThesaurusTag = 'getThesaurus';

  Future getThesaurusWordsList() async {
    safeBlock(() async {
      await categoryRepository.getThesaurusWordsList();
      if (categoryRepository.thesaurusWordsList.isNotEmpty) {
        setSuccess(tag: getThesaurusTag);
      } else {
        callBackError("text");
      }
    }, callFuncName: 'getThesaurusWordsList', tag: getThesaurusTag);
  }

  goMain() {
    localViewModel.changePageIndex(3);
  }

  goToDetails(CatalogModel catalogModel) {
    homeRepository.timelineModel.thesaurus =
        Collocation(id: catalogModel.id, worden: Worden(id: catalogModel.wordenid, word: catalogModel.wordenword));
    localViewModel.isFromMain = false;
    localViewModel.changePageIndex(7);
  }
}
