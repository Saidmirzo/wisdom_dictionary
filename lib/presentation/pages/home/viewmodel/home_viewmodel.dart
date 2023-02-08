import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:jbaza/jbaza.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/core/domain/http_is_success.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../config/constants/constants.dart';
import '../../../../core/di/app_locator.dart';
import '../../../../data/model/timeline_model.dart';
import '../../../../domain/repositories/word_entity_repository.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel({required super.context});

  final homeRepository = locator<HomeRepository>();
  final dbHelper = locator<DBHelper>();
  final wordEntity = locator<WordEntityRepository>();
  final sharedPref = locator<SharedPreferenceHelper>();
  final localViewModel = locator<LocalViewModel>();

  final controller = StreamController<SwipeRefreshState>.broadcast();

  Stream<SwipeRefreshState> get stream => controller.stream;

  Future? dialog;

  final String getDailyWordsTag = "getDailyWordsTag";
  final String getAdTag = "getAdTag";
  final String checkSubscriptionTag = "checkSubscriptionTag";

  void getRandomDailyWords() {
    safeBlock(() async {
      await homeRepository.getRandomWords();
      controller.add(SwipeRefreshState.hidden);
      setSuccess(tag: getDailyWordsTag);
      getAd();
    }, callFuncName: 'getRandomDailyWords', tag: getDailyWordsTag, inProgress: false);
  }

  void getAd() {
    safeBlock(() async {
      Ad response = await homeRepository.getAd();
      if (response.image != null) {
        homeRepository.timelineModel.ad = response;
      }
      setSuccess(tag: getAdTag);
    }, callFuncName: 'getAd', tag: getAdTag, inProgress: false);
  }

  isAdHTTPWorking(String uri) async {
    var result = await get(Uri.parse(uri));
    return result.isSuccessful;
  }

  void onAdWebClicked() {
    safeBlock(() async {
      launchUrlString(
        homeRepository.timelineModel.ad!.link!,
        mode: LaunchMode.externalApplication,
      );
    }, callFuncName: 'onAdWebClicked', inProgress: false);
  }

  String? separateDifference(bool isFirst, String? str) {
    if (str != null && str.isNotEmpty) {
      int whereOr = str.indexOf(" or ");
      if (isFirst) {
        return str.substring(0, whereOr).trim();
      } else {
        return str.substring(whereOr + 3, str.length).trim();
      }
    }
    return str;
  }

  Future<void> updateWords() async {
    safeBlock(
      () async {
        await wordEntity.getWordsPaths();
        for (var path in wordEntity.wordPathModel.files!) {
          await wordEntity.getWordEntity(path.path!);
          await dbHelper.saveAllWords(wordEntity.wordWordEntityList);
        }
        sharedPref.saveDBVersion(wordEntity.wordPathModel.id!);
      },
      callFuncName: 'getWords',
    );
  }

  @override
  callBackError(String text) {
    Future.delayed(Duration.zero, () {
      if (dialog != null) pop();
    });
    showTopSnackBar(
      Overlay.of(context!)!,
      CustomSnackBar.error(
        message: text,
      ),
    );
  }

  void getWordBank() {
    safeBlock(() async {
      await wordEntity.getWordBankList('');
      localViewModel.changeBadgeCount(0);
      localViewModel.changeBadgeCount(wordEntity.wordBankList.length);
    }, callFuncName: 'getWordBank', inProgress: false);
  }

  void checkStatus() {
    safeBlock(() async {
      var token = sharedPref.getString(Constants.KEY_TOKEN, '');
      if (token.isEmpty) {
        onProfileStateChanged(Constants.STATE_NOT_REGISTERED);
      } else {
        onProfileStateChanged(sharedPref.getInt(Constants.KEY_PROFILE_STATE, Constants.STATE_NOT_REGISTERED));
        var subscribeModel = await homeRepository.checkSubscription();
        if (subscribeModel != null && subscribeModel.status!) {
          if (subscribeModel.expiryStatus!) {
            onProfileStateChanged(Constants.STATE_ACTIVE);
          } else {
            onProfileStateChanged(Constants.STATE_INACTIVE);
          }
        }
      }
    }, callFuncName: 'checkStatus');
  }

  void onProfileStateChanged(int state) {
    safeBlock(
      () async {
        localViewModel.profileState = state;
        sharedPref.putInt(Constants.KEY_PROFILE_STATE, state);
        if (state != Constants.STATE_ACTIVE) {
          // Show google ads banner due to profile state;
          setupAds();
        }
        notifyListeners();
      },
      callFuncName: 'onProfileStateChanged',
    );
  }

  void setupAds() {}
}
