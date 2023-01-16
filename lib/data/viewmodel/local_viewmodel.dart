import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';

class LocalViewModel extends BaseViewModel {
  LocalViewModel({required super.context});

  PageController pageController = PageController();

  ValueNotifier<int> current_index = ValueNotifier<int>(0);

  bool isFromMain = true;

  changePageIndex(int index) {
    if (index < 4) {
      current_index.value = index;
    }
    notifyListeners();
    pageController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    pageController.jumpToPage(index);
  }
}
