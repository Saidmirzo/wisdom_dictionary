import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:jbaza/jbaza.dart';
import 'package:swipe_refresh/swipe_refresh.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../data/model/timeline_model.dart';
import '../../../../domain/repositories/word_entity_repository.dart';
import '../../../widgets/loading_widget.dart';

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

  Future<void> getRandomDailyWords() async {
    safeBlock(() async {
      await homeRepository.getRandomWords();
      controller.add(SwipeRefreshState.hidden);
      setSuccess(tag: getDailyWordsTag);
      getAd();
    }, callFuncName: 'getRandomDailyWords', tag: getDailyWordsTag, inProgress: false);
  }

  Future<void> getAd() async {
    safeBlock(() async {
      Ad response = await homeRepository.getAd();
      if (response.image != null) {
        homeRepository.timelineModel.ad = response;
      }
      setSuccess(tag: getAdTag);
    }, callFuncName: 'getAd', tag: getAdTag, inProgress: false);
  }

  onAdWebClicked() {
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

  Future<void> getGrammar() async {
    safeBlock(
      () async {
        await dbHelper.getGrammar();
      },
      callFuncName: 'getGrammar',
    );
  }

  Future<void> getWord() async {
    safeBlock(
      () async {
        //searching word
        await dbHelper.getWord1(200);
      },
      callFuncName: 'getGrammar',
    );
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
  callBackBusy(bool value, String? tag) {
    if (dialog == null && isBusy(tag: tag)) {
      Future.delayed(Duration.zero, () {
        dialog = showLoadingDialog(context!);
      });
    }
  }

  @override
  callBackSuccess(value, String? tag) {
    if (dialog != null) {
      pop();
      dialog = null;
    }
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
    }, callFuncName: 'getWordBank');
  }
}
