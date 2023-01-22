import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/model/catalog_model.dart';
import 'package:wisdom/data/model/recent_model.dart';

class LocalViewModel extends BaseViewModel {
  LocalViewModel({required super.context});

  PageController pageController = PageController();

  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  RecentModel wordDetailModel = RecentModel();

  bool isFromMain = true;

  bool isTitle = false;
  bool isSubSub = false;
  bool isFinal = false;

  CatalogModel speakingCatalogModel = CatalogModel();
  int subId = -1;

  changePageIndex(int index) {
    if (index < 5) {
      currentIndex.value = index;
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
