import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wisdom/data/model/word_bank_model.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/word_entity_repository.dart';

import '../../../../data/model/recent_model.dart';
import '../../../widgets/loading_widget.dart';

class WordBankViewModel extends BaseViewModel {
  WordBankViewModel({
    required super.context,
    required this.wordEntityRepository,
    required this.localViewModel,
  });

  final WordEntityRepository wordEntityRepository;
  final LocalViewModel localViewModel;
  final String getWordBankListTag = 'getWordBankListTag';
  Future? dialog;

  getWordBankList(String? searchText) {
    safeBlock(
      () async {
        if (searchText != null && searchText.isNotEmpty) {
          await wordEntityRepository.getWordBankList(searchText);
        } else {
          await wordEntityRepository.getWordBankList("");
        }
        setSuccess(tag: getWordBankListTag);
      },
      callFuncName: 'getWordBankList',
    );
  }

  goBackToMain() {
    localViewModel.changePageIndex(0);
  }

  goToExercisePage() {
    if (wordEntityRepository.wordBankList.isNotEmpty) {
      localViewModel.changePageIndex(19);
    } else {
      showTopSnackBar(
        Overlay.of(context!)!,
        const CustomSnackBar.info(
          message: "No words to train",
        ),
      );
    }
  }

  deleteWordBank(WordBankModel model) {
    safeBlock(
      () async {
        await wordEntityRepository.deleteWorkBank(model);
        localViewModel.changeBadgeCount(-1);
        notifyListeners();
        // setSuccess();
      },
      callFuncName: 'deleteWordBankModel',
      inProgress: false,
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

  goToDetail(WordBankModel model) {
    localViewModel.isFromMain = false;
    localViewModel.detailToFromBank = true;
    RecentModel recentModel = RecentModel();
    recentModel = RecentModel(id: model.id, word: model.word, wordClass: model.wordClass, type: model.type, same: "");
    localViewModel.wordDetailModel = recentModel;
    localViewModel.changePageIndex(18);
  }
}
