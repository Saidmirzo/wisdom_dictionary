import 'dart:developer';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:jbaza/jbaza.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/data/model/parent_phrases_example_model.dart';
import 'package:wisdom/data/model/parent_phrases_translate_model.dart';
import 'package:wisdom/data/model/phrases_example_model.dart';
import 'package:wisdom/data/model/phrases_translate_model.dart';
import 'package:wisdom/data/model/phrases_with_all.dart';
import 'package:wisdom/data/model/word_bank_model.dart';
import 'package:wisdom/data/model/words_uz_model.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/word_entity_repository.dart';

import '../../../../core/utils/word_mapper.dart';
import '../../../widgets/loading_widget.dart';

class WordDetailPageViewModel extends BaseViewModel {
  WordDetailPageViewModel({
    required super.context,
    required this.localViewModel,
    required this.wordEntityRepository,
    required this.preferenceHelper,
    required this.wordMapper,
  });

  final LocalViewModel localViewModel;
  final WordEntityRepository wordEntityRepository;
  final SharedPreferenceHelper preferenceHelper;
  final WordMapper wordMapper;
  final String initTag = 'initTag';

  Future? dialog;
  List<ParentsWithAll> parentsWithAllList = [];
  bool synonymsIsExpanded = false;
  bool phrasesIsExpanded = false;
  double? fontSize;

  late AutoScrollController autoScrollController;

  // taking searched word model from local viewmodel and collect all details of it from db
  init() {
    safeBlock(
      () async {
        autoScrollController = AutoScrollController(
            viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context!).padding.bottom),
            axis: Axis.vertical);
        fontSize = preferenceHelper.getDouble(preferenceHelper.fontSize, 16);
        await wordEntityRepository.getRequiredWord(localViewModel.wordDetailModel.id ?? 0);
        if (wordEntityRepository.requiredWordWithAllModel.word != null) {
          await splitingToParentWithAllModel();
          setSuccess(tag: initTag);
        }
      },
      callFuncName: 'getGrammar',
      tag: initTag,
    );
  }

  void funcScrollByCtg(int index) async {
    await autoScrollController.scrollToIndex(index,
        duration: const Duration(milliseconds: 800), preferPosition: AutoScrollPosition.begin);
    autoScrollController.highlight(index);
  }

  void textToSpeech() {
    if (wordEntityRepository.requiredWordWithAllModel.word != null &&
        wordEntityRepository.requiredWordWithAllModel.word!.word != null) {
      FlutterTts tts = FlutterTts();
      // await tts.setSharedInstance(true); // For IOS
      tts.setLanguage('en-US');
      tts.speak(wordEntityRepository.requiredWordWithAllModel.word!.word!);
    }
  }

  Future<void> splitingToParentWithAllModel() async {
    parentsWithAllList.add(wordMapper.wordWithAllToParentsWithAll(wordEntityRepository.requiredWordWithAllModel));
    if (wordEntityRepository.requiredWordWithAllModel.parentsWithAll != null &&
        wordEntityRepository.requiredWordWithAllModel.parentsWithAll!.isNotEmpty) {
      parentsWithAllList.addAll(wordEntityRepository.requiredWordWithAllModel.parentsWithAll!);
    }
  }

  addToWordBankFromParent(ParentsWithAll model, String num, GlobalKey key) {
    safeBlock(() async {
      int number = int.parse(num.isEmpty ? "0" : num);
      var wordBank = WordBankModel(
          id: model.parents!.id,
          word: model.parents!.word,
          example: model.parents!.example,
          translation: conductToString(model.wordsUz),
          createdAt: DateTime.now().toString(),
          number: number);
      funAddToWordBank(wordBank, key);
    }, callFuncName: 'addToWordBankFromParent', inProgress: false);
  }

  addToWordBankFromPhrase(PhrasesWithAll model, String num, GlobalKey key) {
    safeBlock(() async {
      int number = int.parse(num.isEmpty ? "0" : num);
      var wordBank = WordBankModel(
          id: model.phrases!.pId,
          word: model.phrases!.pWord,
          example: model.phrasesExample![0].value,
          translation: conductToStringPhrasesTranslate(model.phrasesTranslate!),
          createdAt: DateTime.now().toString(),
          number: number);
      funAddToWordBank(wordBank, key);
    }, callFuncName: 'addToWordBankFromPhrase', inProgress: false);
  }

  addToWordBankFromParentPhrase(ParentPhrasesWithAll model, String num, GlobalKey key) {
    safeBlock(() async {
      int number = int.parse(num.isEmpty ? "0" : num);
      var wordBank = WordBankModel(
          id: model.parentPhrases!.id,
          word: model.parentPhrases!.word ?? "",
          example: model.phrasesExample![0].value,
          translation: conductToStringParentPhrasesTranslate(model.parentPhrasesTranslate!),
          createdAt: DateTime.now().toString(),
          number: number);
      funAddToWordBank(wordBank, key);
    }, callFuncName: 'addToWordBankFromParentPhrase', inProgress: false);
  }

  funAddToWordBank(WordBankModel bankModel, GlobalKey key) {
    safeBlock(() async {
      int count = 0;
      for (var item in wordEntityRepository.wordBankList) {
        if (item.id == bankModel.id) {
          count++;
          break;
        }
      }
      if (count == 0) {
        localViewModel.runAddToCartAnimation(key);
        localViewModel.changeBadgeCount(1);
        await wordEntityRepository.saveWordBank(bankModel);
      }
    }, callFuncName: 'funAddToWordBank', inProgress: false);
  }

  String conductToString(List<WordsUzModel>? wordList) {
    if (wordList != null && wordList.isNotEmpty) {
      var concatenate = StringBuffer();
      for (var item in wordList) {
        if (wordList.last != item) {
          concatenate.write("${item.word}, ");
        } else {
          concatenate.write("${item.word}");
        }
      }
      return concatenate.toString();
    } else {
      return "";
    }
  }

  String conductToStringPhrasesTranslate(List<PhrasesTranslateModel>? translateList) {
    if (translateList != null && translateList.isNotEmpty) {
      var concatenate = StringBuffer();
      for (var item in translateList) {
        if (translateList.last != item) {
          concatenate.write("${item.word}, ");
        } else {
          concatenate.write("${item.word}");
        }
      }
      return concatenate.toString();
    } else {
      return "";
    }
  }

  String conductToStringParentPhrasesTranslate(List<ParentPhrasesTranslateModel>? translateList) {
    if (translateList != null && translateList.isNotEmpty) {
      var concatenate = StringBuffer();
      for (var item in translateList) {
        if (translateList.last != item) {
          concatenate.write("${item.word}, ");
        } else {
          concatenate.write("${item.word}");
        }
      }
      return concatenate.toString();
    } else {
      return "";
    }
  }

  String conductToStringPhrasesExamples(List<PhrasesExampleModel>? examplesList) {
    if (examplesList != null && examplesList.isNotEmpty) {
      var concatenate = StringBuffer();
      for (var item in examplesList) {
        if (item == examplesList.last) {
          concatenate.write("${item.value}");
        } else {
          concatenate.write("${item.value}\n");
        }
      }
      return concatenate.toString();
    } else {
      return "";
    }
  }

  String conductToStringParentPhrasesExamples(List<ParentPhrasesExampleModel>? examplesList) {
    if (examplesList != null && examplesList.isNotEmpty) {
      var concatenate = StringBuffer();
      for (var item in examplesList) {
        if (item == examplesList.last) {
          concatenate.write("${item.value}");
        } else {
          concatenate.write("${item.value}\n");
        }
      }
      return concatenate.toString();
    } else {
      return "";
    }
  }

  String findRank(String star) {
    switch (star) {
      case "3":
        return Assets.icons.starFull;
      case "2":
        return Assets.icons.starHalf;
      case "1":
        return Assets.icons.starLow;
      default:
        return "";
    }
  }

  goBackToSearch() {
    if (localViewModel.isFromMain) {
      localViewModel.isFromMain = false;
      localViewModel.changePageIndex(0);
    } else {
      localViewModel.changePageIndex(2);
    }
  }

  @override
  callBackBusy(bool value, String? tag) {
    if (isBusy()) {
      dialog = showLoadingDialog(context!);
    } else {
      if (dialog != null) {
        pop();
        dialog = null;
      }
    }
  }

  void checkIfPhrase(PhrasesWithAll phraseModel, int index) async {
    if (localViewModel.wordDetailModel.type == "phrase" || localViewModel.wordDetailModel.type == "phrases") {
      if (isWordContained(phraseModel.phrases!.pWord ?? "")) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (phrasesIsExpanded == false) {
            phrasesIsExpanded = true;
            funcScrollByCtg(index);
          }
        });
      }
    }
  }

  bool isWordContained(String word) {
    if (word == (localViewModel.wordDetailModel.word ?? "")) {
      return true;
    }
    return false;
  }

  bool hasToBeExpanded(List<PhrasesWithAll>? phrasesWithAll) {
    if (localViewModel.wordDetailModel.type == "phrase" || localViewModel.wordDetailModel.type == "phrases") {
      if (phrasesWithAll != null && phrasesWithAll.isNotEmpty) {
        for (var model in phrasesWithAll) {
          if (isWordContained(model.phrases!.pWord ?? "")) {
            return true;
          }
        }
      }
      return false;
    }
    return false;
  }
}
