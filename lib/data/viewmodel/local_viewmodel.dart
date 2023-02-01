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

  bool isFromMain = false;

  bool isTitle = false;
  bool isSubSub = false;
  bool isFinal = false;

  FocusNode focusNode = FocusNode();

  CatalogModel speakingCatalogModel = CatalogModel();

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  int subId = -1;

  changePageIndex(int index) {
    if (index < 5) {
      currentIndex.value = index;
    }
    if (index == 2) {
      focusNode.requestFocus();
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
    cartKey.currentState!.runCartAnimation(
      (badgeCount.value).toString(),
    );
    // notifyListeners();
  }
}
