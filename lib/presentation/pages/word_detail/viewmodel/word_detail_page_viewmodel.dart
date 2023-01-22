import 'dart:ffi';

import 'package:expandable/expandable.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/data/model/phrases_with_all.dart';
import 'package:wisdom/data/model/word_and_words_uz_model.dart';
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
    required this.wordMapper,
  });

  final LocalViewModel localViewModel;
  final WordEntityRepository wordEntityRepository;
  final WordMapper wordMapper;
  final String initTag = 'initTag';


  Future? dialog;
  List<ParentsWithAll> parentsWithAllList = [];
  bool synonymsIsExpanded = false;

  // taking searched word model from local viewmodel and collect all details of it from db
  init() {
    safeBlock(
      () async {
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


  Future<void> splitingToParentWithAllModel() async {
    parentsWithAllList.add(wordMapper.wordWithAllToParentsWithAll(wordEntityRepository.requiredWordWithAllModel));
    if (wordEntityRepository.requiredWordWithAllModel.parentsWithAll != null &&
        wordEntityRepository.requiredWordWithAllModel.parentsWithAll!.isNotEmpty) {
      parentsWithAllList.addAll(wordEntityRepository.requiredWordWithAllModel.parentsWithAll!);
    }
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

  void goBackToSearch() {
    localViewModel.changePageIndex(2);
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
}
