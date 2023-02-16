import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../domain/repositories/category_repository.dart';

class CultureDetailPageViewModel extends BaseViewModel {
  CultureDetailPageViewModel({
    required super.context,
    required this.homeRepository,
    required this.categoryRepository,
    required this.localViewModel,
  });

  final HomeRepository homeRepository;
  final CategoryRepository categoryRepository;
  final LocalViewModel localViewModel;
  final String getCultureDetailsTag = 'getCultureDetails';

  String? getCulture() {
    return categoryRepository.cultureModel.body!;
  }

  void getCultureDetails() {
    safeBlock(() async {
      if (categoryRepository.cultureModel.wordId != null) {
        await categoryRepository.getCultureDetail(categoryRepository.cultureModel.id!);
        if (categoryRepository.cultureDetailModel.cBody != null) {
          setSuccess(tag: getCultureDetailsTag);
        } else {
          callBackError("text");
        }
      }
    }, callFuncName: 'getCultureDetails', tag: getCultureDetailsTag);
  }

  goBack() {
    if (localViewModel.isFromMain) {
      localViewModel.changePageIndex(0);
    } else {
      localViewModel.changePageIndex(15);
    }
  }
}
