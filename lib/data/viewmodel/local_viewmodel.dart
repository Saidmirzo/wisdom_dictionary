import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/model/catalog_model.dart';

class LocalViewModel extends BaseViewModel {
  LocalViewModel({required super.context});

  PageController pageController = PageController();

  ValueNotifier<int> current_index = ValueNotifier<int>(0);

  bool isFromMain = true;

  bool isTitle = false;
  bool isSubSub = false;
  bool isFinal = false;

  String titleSearch = '';
  String subTitleSearch = '';
  String subSubTitleSearch = '';
  String currentSearch = '';

  CatalogModel speakingCatalogModel = CatalogModel();
  int subId = -1;

  changePageIndex(int index) {
    if (index < 5) {
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
