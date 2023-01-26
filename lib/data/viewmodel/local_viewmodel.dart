import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/model/catalog_model.dart';
import 'package:wisdom/data/model/recent_model.dart';
import 'package:wisdom/data/model/word_bank_model.dart';

class LocalViewModel extends BaseViewModel {
  LocalViewModel({required super.context});

  PageController pageController = PageController();

  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  RecentModel wordDetailModel = RecentModel();

  List<WordBankModel> wordBankList = [];

  ValueNotifier<int> badgeCount = ValueNotifier<int>(0);

  bool isFromMain = true;

  bool isTitle = false;
  bool isSubSub = false;
  bool isFinal = false;

  CatalogModel speakingCatalogModel = CatalogModel();

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;

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

  changeBadgeCount(int how) {
    if (how == -1 && badgeCount.value > 0) {
      badgeCount.value--;
    } else if (how == 1) {
      badgeCount.value++;
    } else if (how == 0) {
      badgeCount.value = 0;
    } else {
      badgeCount.value = how;
    }
    notifyListeners();
  }
}
