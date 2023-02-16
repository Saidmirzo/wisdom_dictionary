import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../domain/repositories/category_repository.dart';

class ThesaurusDetailPageViewModel extends BaseViewModel {
  ThesaurusDetailPageViewModel({
    required super.context,
    required this.homeRepository,
    required this.categoryRepository,
    required this.localViewModel,
  });

  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
  final LocalViewModel localViewModel;
  final String getThesaurusDetailsTag = 'getThesaurusDetails';

  String? getThesaurus() {
    return homeRepository.timelineModel.thesaurus!.worden!.word;
  }

  Future getThesaurusDetails() async {
    safeBlock(() async {
      if (homeRepository.timelineModel.thesaurus != null) {
        await categoryRepository.getThesaurusDetail(homeRepository.timelineModel.thesaurus!.id!);
        if (categoryRepository.thesaurusDetailModel.tBody != null) {
          setSuccess(tag: getThesaurusDetailsTag);
        } else {
          callBackError("text");
        }
      }
    }, callFuncName: 'getThesaurusDetails', tag: getThesaurusDetailsTag);
  }

  goBack() {
    if(locator<LocalViewModel>().isFromMain) {
      locator<LocalViewModel>().isFromMain = false;
      locator<LocalViewModel>().changePageIndex(0);
    } else {
      locator<LocalViewModel>().changePageIndex(12);
    }
  }
}
