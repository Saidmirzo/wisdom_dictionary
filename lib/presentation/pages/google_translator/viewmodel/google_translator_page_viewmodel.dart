import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:jbaza/jbaza.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:translator/translator.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_decoration.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_dialog.dart';
import '../../../widgets/loading_widget.dart';

class GoogleTranslatorPageViewModel extends BaseViewModel {
  GoogleTranslatorPageViewModel({
    required super.context,
    required this.localViewModel,
  });

  final translator = GoogleTranslator();
  final LocalViewModel localViewModel;
  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;
  bool isListening = false;
  bool topUzbek = true;

  Future? dialog;

  void exchangeLanguages() {
    topUzbek = !topUzbek;
    notifyListeners();
  }

  translate(String text, TextEditingController controller) async {
    if (text.isNotEmpty) {
      int count = localViewModel.preferenceHelper.getInt(Constants.KEY_TRANSLATE_COUNT, 0);
      String dateString = localViewModel.preferenceHelper.getString(Constants.KEY_DATE, "");
      DateTime dateTime = DateTime.now();
      bool isNextDay = false;
      if (dateString.isNotEmpty) {
        dateTime = DateTime.parse(dateString);
        isNextDay = (dateTime.day < DateTime.now().day) && (dateTime.month < DateTime.now().month) && (dateTime.year < DateTime.now().year)  ;
      }
      if (count != 1 || isNextDay) {
        safeBlock(
          () async {
            var translated = "";
            if (await localViewModel.netWorkChecker.isNetworkAvailable()) {
              translated = await translator
                  .translate(text, from: topUzbek ? "uz" : "en", to: topUzbek ? "en" : "uz")
                  .then((value) => value.text);
              controller.text = translated;
              localViewModel.preferenceHelper.putString(Constants.KEY_DATE, DateTime.now().toString());
              if (localViewModel.profileState != Constants.STATE_ACTIVE) {
                localViewModel.preferenceHelper.putInt(Constants.KEY_TRANSLATE_COUNT, 1);
              } else {
                localViewModel.preferenceHelper.putInt(Constants.KEY_TRANSLATE_COUNT, 0);
              }
              setSuccess();
            } else {
              callBackError("no_internet".tr());
              setSuccess();
            }
          },
          callFuncName: 'translate',
          // inProgress: true,
        );
      } else {
        showCustomDialog(
          context: context!,
          icon: Assets.icons.inform,
          iconColor: AppColors.accentLight,
          iconBackgroundColor: AppColors.error,
          title: "translator".tr(),
          contentText: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Text(
              'translate_inform'.tr(),
              textAlign: TextAlign.center,
              style:
                  AppTextStyle.font14W600Normal.copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
            ),
          ),
          positive: "buy_pro".tr(),
          onPositiveTap: () {
            navigateTo(Routes.gettingProPage);
          },
          negative: "watch_ad".tr(),
          onNegativeTap: () async {
            if (await localViewModel.netWorkChecker.isNetworkAvailable()) {
              localViewModel.showInterstitialAd();
              localViewModel.preferenceHelper.putInt(Constants.KEY_TRANSLATE_COUNT, 0);
              pop();
            } else {
              callBackError('no_internet'.tr());
            }
          },
        );
      }
    }
  }

  goMain() {
    localViewModel.changePageIndex(0);
  }

  Future<void> readText(String text) async {
    if (isSpeaking) {
      flutterTts.stop();
    } else {
      await flutterTts.setLanguage("en-US");
      await flutterTts.speak(text);
    }
  }

  Future<String> voiceToText() async {
    String resultText = "";
    Duration duration = const Duration(seconds: 5);
    SpeechToText speech = SpeechToText();
    bool available = await speech.initialize();
    if (available) {
      await speech.listen(
        listenFor: duration,
        onResult: (result) {
          resultText = result.recognizedWords;
        },
      );
    } else {
      log("The user has denied the use of speech recognition.");
    }
    await Future.delayed(duration);
    return resultText;
  }

  void startListening() {
    isListening = true;
    notifyListeners();
  }

  void stopListening() {
    isListening = false;
    notifyListeners();
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
}
