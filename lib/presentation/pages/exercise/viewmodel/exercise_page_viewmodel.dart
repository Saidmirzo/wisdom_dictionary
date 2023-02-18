import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:jbaza/jbaza.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wisdom/data/model/exercise_model.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_text_style.dart';
import '../../../../config/constants/assets.dart';
import '../../../../config/constants/constants.dart';
import '../../../../data/model/word_bank_model.dart';
import '../../../../domain/repositories/word_entity_repository.dart';
import '../../../widgets/custom_dialog.dart';

class ExercisePageViewModel extends BaseViewModel {
  ExercisePageViewModel({
    required super.context,
    required this.localViewModel,
    required this.wordEntityRepository,
  });

  final LocalViewModel localViewModel;
  final WordEntityRepository wordEntityRepository;
  String gettingReadyTag = "gettingReadyTag";

  List<ExerciseModel> uzbList = [];
  List<ExerciseModel> englishList = [];
  List<WordBankModel> wordBankList = [];
  int minLength = 0;

  int engSelectedIndex = -1;
  int uzSelectedIndex = -1;

  int listEngIndex = -1;
  int listUzIndex = -1;

  int tryNumber = 3;

  init() {
    safeBlock(() async {
      localViewModel.finalList = {};
      await getMinLength();
      await splitting();
      setSuccess(tag: gettingReadyTag);
    }, callFuncName: 'init', tag: gettingReadyTag);
  }

  splitting() async {
    if (minLength > 10) minLength = 10;
    while (minLength > englishList.length) {
      var randomIndexEng = Random.secure().nextInt(wordBankList.length);
      var randomIndexUz = Random.secure().nextInt(wordBankList.length);
      var elementEng = wordBankList[randomIndexEng];
      var elementUz = wordBankList[randomIndexUz];
      if (await checkToSameEng(elementEng.word ?? "_") &&
          await checkToSameUz(elementUz.translation ?? "_") &&
          englishList.length <= minLength) {
        englishList.add(ExerciseModel(
            id: elementEng.id!,
            word: elementEng.word ?? "",
            wordClass: elementEng.wordClass!,
            wordClassBody: elementEng.wordClassBody!,
            translation: elementEng.translation!,
            example: elementEng.example!));
        uzbList.add(ExerciseModel(
            id: elementUz.id!,
            word: elementUz.translation ?? "",
            wordClass: elementUz.wordClass!,
            wordClassBody: elementUz.wordClassBody!,
            translation: elementUz.translation!,
            example: elementUz.example!));
      }
    }
  }

  void textToSpeech(String text) {
    if (text.isNotEmpty) {
      FlutterTts tts = FlutterTts();
      // await tts.setSharedInstance(true); // For IOS
      tts.setLanguage('en-US');
      tts.speak(text);
    }
  }

  void checkTheResult() async {
    if ((uzSelectedIndex == engSelectedIndex) && (engSelectedIndex != -1)) {
      notifyListeners();
      textToSpeech("Correct");
      var item = englishList[listEngIndex];
      localViewModel.finalList
          .add(ExerciseFinalModel(id: item.id, word: item.word, translation: item.translation, result: true));
      showTopSnackBar(
        Overlay.of(context!)!,
        CustomSnackBar.success(
          message: "correct".tr(),
        ),
      );
      Future.delayed(
        const Duration(milliseconds: 800),
        () {
          englishList.removeAt(listEngIndex);
          uzbList.removeAt(listUzIndex);
          if (englishList.isEmpty) localViewModel.changePageIndex(20);
          refreshClean();
        },
      );
    } else if (engSelectedIndex != -1 && uzSelectedIndex != -1) {
      notifyListeners();
      tryNumber--;
      if (tryNumber == 0) {
        finishTheExercise();
        return;
      }
      var item = englishList[listEngIndex];
      localViewModel.finalList
          .add(ExerciseFinalModel(id: item.id, word: item.word, translation: item.translation, result: false));
      textToSpeech("Incorrect \n $tryNumber ${tryNumber != 1 ? "tries" : "try"} left");

      showTopSnackBar(
        Overlay.of(context!)!,
        CustomSnackBar.error(
          message: "${"inCorrect".tr()}\n${"$tryNumber ${tryNumber != 1 ? "tries" : "try"}".tr()} ${"left".tr()}",
        ),
      );
      Future.delayed(
        const Duration(milliseconds: 800),
        () {
          refreshClean();
        },
      );
    }
    notifyListeners();
  }

  void refreshClean() {
    uzSelectedIndex = -1;
    engSelectedIndex = -1;
    listEngIndex = -1;
    listUzIndex = -1;
    notifyListeners();
  }

  Future<bool> checkToSameUz(String word) {
    for (var element in uzbList) {
      if (element.word == word) return Future.value(false);
    }
    return Future.value(true);
  }

  Future<bool> checkToSameEng(String word) {
    for (var element in englishList) {
      if (element.word == word) return Future.value(false);
    }
    return Future.value(true);
  }

  Future<bool> checkToSameBank(String word) {
    for (var element in wordBankList) {
      if (element.word == word) return Future.value(false);
    }
    return Future.value(true);
  }

  getMinLength() async {
    minLength = 0;
    for (int i = 0; i < wordEntityRepository.wordBankList.length; i++) {
      if (await checkToSameBank(wordEntityRepository.wordBankList[i].word!)) {
        wordBankList.add(wordEntityRepository.wordBankList[i]);
        minLength++;
      }
    }
    wordBankList.clear();
    if (minLength > 10) minLength = 10;
    while (minLength > wordBankList.length) {
      var randomInt = Random.secure().nextInt(minLength);
      if (await checkToSameBank(wordEntityRepository.wordBankList[randomInt].word!)) {
        wordBankList.add(wordEntityRepository.wordBankList[randomInt]);
      }
    }
  }

  goBack() {
    // Navigation bardan chiqishda dialog qo'yish kerak
    if (localViewModel.finalList.isNotEmpty) {
      showCustomDialog(
        context: context!,
        icon: Assets.icons.inform,
        iconColor: AppColors.accentLight,
        iconBackgroundColor: AppColors.error,
        title: "finish".tr(),
        contentText: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            'finish_text'.tr(),
            textAlign: TextAlign.center,
            style:
                AppTextStyle.font14W600Normal.copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
          ),
        ),
        positive: "dialogYes".tr(),
        onPositiveTap: () => finishTheExercise(),
        negative: "dialogNo".tr(),
      );
    } else {
      localViewModel.changePageIndex(1);
    }
  }

  void finishTheExercise() {
    for (var item in englishList) {
      localViewModel.finalList
          .add(ExerciseFinalModel(id: item.id, word: item.word, translation: item.translation, result: false));
    }
    localViewModel.changePageIndex(20);
  }

  goToFinish() {
    if (englishList.isNotEmpty) {
      showCustomDialog(
        context: context!,
        icon: Assets.icons.inform,
        iconColor: AppColors.accentLight,
        iconBackgroundColor: AppColors.error,
        title: "finish".tr(),
        contentText: Padding(
          padding: EdgeInsets.only(top: 20.h),
          child: Text(
            'finish_text'.tr(),
            textAlign: TextAlign.center,
            style:
                AppTextStyle.font14W600Normal.copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
          ),
        ),
        positive: "dialogYes".tr(),
        onPositiveTap: () {
          pop(ctx: context!);
          finishTheExercise();
        },
        negative: "dialogNo".tr(),
      );
    } else {
      localViewModel.changePageIndex(20);
    }
  }
}
