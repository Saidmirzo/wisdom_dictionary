import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';

class CatalogsPageViewModel extends BaseViewModel {
  CatalogsPageViewModel({required super.context, required this.localViewModel});

  final LocalViewModel localViewModel;

  goMain() {
    localViewModel.changePageIndex(0);
  }
}
