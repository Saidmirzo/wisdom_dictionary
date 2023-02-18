import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jbaza/jbaza.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/core/services/custom_client.dart';
import 'package:wisdom/data/model/catalog_model.dart';
import 'package:wisdom/data/model/recent_model.dart';
import 'package:wisdom/data/model/word_bank_model.dart';

import '../model/exercise_model.dart';

class LocalViewModel extends BaseViewModel {
  LocalViewModel({required super.context, required this.preferenceHelper, required this.netWorkChecker});

  final SharedPreferenceHelper preferenceHelper;

  final NetWorkChecker netWorkChecker;

  int profileState = -1;

  BannerAd? banner;

  PageController pageController = PageController();

  ValueNotifier<int> currentIndex = ValueNotifier<int>(0);

  ValueNotifier<bool> isNetworkAvailable = ValueNotifier<bool>(false);

  RecentModel wordDetailModel = RecentModel();
  bool isSearchByUz = false;

  List<WordBankModel> wordBankList = [];

  ValueNotifier<int> badgeCount = ValueNotifier<int>(0);

  Set<ExerciseFinalModel> finalList = {};

  bool isFromMain = false;
  bool detailToFromBank = false;



  bool isTitle = false;
  bool isSubSub = false;
  bool isFinal = false;

  String searchingText = '';

  String lastSearchedText = '';

  FocusNode focusNode = FocusNode();

  CatalogModel speakingCatalogModel = CatalogModel();

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  double get fontSize => preferenceHelper.getDouble(preferenceHelper.fontSize, 16);

  int subId = -1;

  InterstitialAd? interstitialAd;

  void createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-6651367008928070/9544986489',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          interstitialAd!.setImmersiveMode(true);
        },
        onAdFailedToLoad: (LoadAdError error) {
          interstitialAd = null;
          createInterstitialAd();
          // }
        },
      ),
    );
  }

  void showInterstitialAd() {
    if (interstitialAd == null) {
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

  void checkNetworkConnection() async {
    isNetworkAvailable.value = await netWorkChecker.isNetworkAvailable();
  }

  void changePageIndex(int index) async {
    if (banner != null) {
      banner!.dispose();
    }
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
    checkNetworkConnection();
  }

  void changeBadgeCount(int how) {
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

  void shareWord(String word) async {
    await Share.share(word, subject: "Wisdom Dictionary : https://t.me/@wisdom_uz.\n Looking word: ");
  }

  void goByLink(String linkWord) async {
    searchingText = linkWord;
    changePageIndex(2);
  }

}
