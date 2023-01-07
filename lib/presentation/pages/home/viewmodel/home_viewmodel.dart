import 'package:jbaza/jbaza.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel({required super.context});

  int current_index = 0;

  changeIndex(int index) {
    current_index = index;
    notifyListeners();
  }
}
