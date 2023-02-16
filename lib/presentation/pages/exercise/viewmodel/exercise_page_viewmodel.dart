import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wisdom/data/model/exercise_model.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';

import '../../../../data/model/word_bank_model.dart';
import '../../../../domain/repositories/word_entity_repository.dart';

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
  List<ExerciseFinalModel> finalList = [];
  List<WordBankModel> wordBankList = [];
  int minLength = 0;

  int engSelectedIndex = -1;
  int uzSelectedIndex = -1;

  int listEngIndex = -1;
  int listUzIndex = -1;

  init() {
    safeBlock(() async {
      await getMinLength();
      await splitting();
      setSuccess(tag: gettingReadyTag);
    }, callFuncName: 'init', tag: gettingReadyTag);
  }

  splitting() async {
    if (minLength > 10) minLength = 10;
    for (int i = 0; i < minLength; i++) {
      wordBankList.add(wordEntityRepository.wordBankList[i]);
    }
    while (minLength > englishList.length) {
      var randomIndexEng = Random.secure().nextInt(wordBankList.length);
      var randomIndexUz = Random.secure().nextInt(wordBankList.length);
      var elementEng = wordBankList[randomIndexEng];
      var elementUz = wordBankList[randomIndexUz];
      if (await checkToSameEng(elementEng.word ?? "_") &&
          await checkToSameUz(elementUz.translation ?? "_") &&
          englishList.length <= minLength &&
          (randomIndexUz != randomIndexEng)) {
        englishList.add(ExerciseModel(id: elementEng.id!, word: elementEng.word ?? ""));
        uzbList.add(ExerciseModel(id: elementUz.id!, word: elementUz.translation ?? ""));
      }
    }
  }

  void checkTheResult() async {
    if ((uzSelectedIndex == engSelectedIndex) && (engSelectedIndex != -1)) {
      notifyListeners();
      showTopSnackBar(
        Overlay.of(context!)!,
        const CustomSnackBar.success(
          message: "Correct!",
        ),
      );
      Future.delayed(
        Duration(milliseconds: 800),
        () {

          englishList.removeAt(listEngIndex);
          uzbList.removeAt(listUzIndex);
          refreshClean();
        },
      );
    } else if (engSelectedIndex != -1 && uzSelectedIndex != -1) {
      notifyListeners();
      showTopSnackBar(
        Overlay.of(context!)!,
        const CustomSnackBar.error(
          message: "Incorrect!",
        ),
      );
      Future.delayed(
        Duration(milliseconds: 800),
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

  getMinLength() async {
    for (var element in wordEntityRepository.wordBankList) {
      if (await checkToSameEng(element.word ?? "!")) {
        englishList.add(ExerciseModel(id: element.id!, word: element.word!));
      }
    }
    minLength = englishList.length;
    englishList.clear();
  }

  goBack() {
    localViewModel.changePageIndex(1);
  }

  goToFinish() {
    // Go to finish
    localViewModel.changePageIndex(1);
  }
}
