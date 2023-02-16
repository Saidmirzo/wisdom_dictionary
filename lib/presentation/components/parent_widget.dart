import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/data/model/phrases_with_all.dart';
import 'package:wisdom/presentation/components/custom_expandable_widget.dart';
import 'package:wisdom/presentation/components/phrases_widget.dart';

import '../../config/constants/assets.dart';
import '../../config/constants/constants.dart';
import '../pages/word_detail/viewmodel/word_detail_page_viewmodel.dart';

class ParentWidget extends ViewModelWidget<WordDetailPageViewModel> {
  const ParentWidget({
    required this.model,
    required this.orderNum,
  });

  final ParentsWithAll model;
  final String orderNum;

  @override
  Widget build(BuildContext context, viewModel) {
    GlobalKey widgetKey = GlobalKey();
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  key: widgetKey,
                  child: GestureDetector(
                    onTap: () => viewModel.addToWordBankFromParent(model, orderNum, widgetKey),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: SvgPicture.asset(Assets.icons.saveWord, color: AppColors.blue,),
                    ),
                  ),
                ),
                model.parents!.star != "0"
                    ? Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: SvgPicture.asset(viewModel.findRank(model.parents!.star!)))
                    : const SizedBox.shrink(),
                Flexible(
                  child: Text.rich(TextSpan(
                    text: (viewModel.parentsWithAllList.length != 1) ? "$orderNum. " : "",
                    style: AppTextStyle.font14W700Normal.copyWith(
                        color: isDarkTheme ? AppColors.white : AppColors.darkGray, fontSize: viewModel.fontSize! - 2),
                    children: [
                      TextSpan(
                        text: orderNum == "1"
                            ? "${model.parents!.wordClassBodyMeaning ?? ""} "
                            : "${model.parents!.wordClassBody ?? ""} ",
                        style: AppTextStyle.font14W400Normal
                            .copyWith(color: AppColors.paleGray, fontSize: viewModel.fontSize! - 2),
                      ),
                      viewModel.conductAndHighlightUzWords(model.wordsUz, null, null),
                    ],
                  )),
                )
              ],
            ),
          ),
          // Example
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: HtmlWidget(
                (model.parents!.example ?? "")
                    .replaceAll("<br>", "")
                    .replaceAll("<p>", "")
                    .replaceAll("</p>", "<br>"),
                textStyle: AppTextStyle.font14W400ItalicHtml
                    .copyWith(fontSize: viewModel.fontSize! - 2, color: isDarkTheme ? AppColors.lightGray : null),
              ),
            ),
          ),
          // examples
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: HtmlWidget(
                (model.parents!.examples ?? "")
                    .replaceAll("<br>", "")
                    .replaceAll("<p>", "")
                    .replaceAll("</p>", "<br>"),
                textStyle: AppTextStyle.font14W400ItalicHtml
                    .copyWith(fontSize: viewModel.fontSize! - 2, color: isDarkTheme ? AppColors.lightGray : null),
              ),
            ),
          ),
          // Synonyms
          CustomExpandableWidget(
            title: "Synonyms",
            body: HtmlWidget(
              (model.parents!.synonyms ?? "").replaceAll("<br>", "").replaceAll("<p>", "").replaceAll("</p>", "<br>"),
              textStyle: AppTextStyle.font12W400ItalicHtml
                  .copyWith(color: isDarkTheme ? AppColors.lightGray : null, fontSize: viewModel.fontSize! - 4),
            ),
            visible: model.parents!.synonyms != null,
            viewModel: viewModel,
          ),
          // Antonym
          CustomExpandableWidget(
            title: "Antonyms",
            body: HtmlWidget(
              (model.parents!.anthonims ?? "").replaceAll("<br>", "").replaceAll("<p>", "").replaceAll("</p>", "<br>"),
              textStyle: AppTextStyle.font12W400ItalicHtml
                  .copyWith(color: isDarkTheme ? AppColors.lightGray : null, fontSize: viewModel.fontSize! - 4),
            ),
            visible: model.parents!.anthonims != null,
            viewModel: viewModel,
          ),
          // Grammar
          CustomExpandableWidget(
            title: "Grammar",
            body: HtmlWidget(
              (model.grammar != null ? model.grammar!.first.body ?? "" : "")
                  .replaceAll("<br>", "")
                  .replaceAll("<p>", "")
                  .replaceAll("</p>", "<br>"),
              textStyle: AppTextStyle.font12W400ItalicHtml
                  .copyWith(color: isDarkTheme ? AppColors.lightGray : null, fontSize: viewModel.fontSize! - 4),
            ),
            visible: model.grammar != null && model.grammar!.isNotEmpty,
            viewModel: viewModel,
          ),
          //Difference
          CustomExpandableWidget(
            title: "Difference",
            body: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  (model.difference != null ? model.difference!.first.word ?? "" : ""),
                  style: AppTextStyle.font14W400Normal.copyWith(
                      color: isDarkTheme ? AppColors.white : AppColors.darkGray, fontSize: viewModel.fontSize! - 2),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: HtmlWidget(
                    (model.difference != null ? model.difference!.first.body ?? "" : "")
                        .replaceAll("<br>", "")
                        .replaceAll("<p>", "")
                        .replaceAll("</p>", "<br>"),
                    textStyle: AppTextStyle.font12W400ItalicHtml.copyWith(
                        color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray,
                        fontSize: viewModel.fontSize! - 4),
                  ),
                )
              ],
            ),
            visible: model.difference != null && model.difference!.isNotEmpty,
            viewModel: viewModel,
          ),
          // Collocations
          CustomExpandableWidget(
            title: "Collocations",
            body: HtmlWidget(
              (model.collocation != null ? model.collocation!.first.body ?? "" : "")
                  .replaceAll("<br>", "")
                  .replaceAll("<p>", "")
                  .replaceAll("</p>", "<br>"),
              textStyle: AppTextStyle.font12W400ItalicHtml
                  .copyWith(color: isDarkTheme ? AppColors.lightGray : null, fontSize: viewModel.fontSize! - 4),
            ),
            visible: model.collocation != null && model.collocation!.isNotEmpty,
            viewModel: viewModel,
          ),
          // Thesaurus
          CustomExpandableWidget(
            title: "Thesaurus",
            body: HtmlWidget(
              (model.thesaurus != null ? model.thesaurus!.first.body ?? "" : "")
                  .replaceAll("<br>", "")
                  .replaceAll("<p>", "")
                  .replaceAll("</p>", "<br>"),
              textStyle: AppTextStyle.font12W400ItalicHtml
                  .copyWith(color: isDarkTheme ? AppColors.lightGray : null, fontSize: viewModel.fontSize! - 4),
            ),
            visible: model.thesaurus != null && model.thesaurus!.isNotEmpty,
            viewModel: viewModel,
          ),
          // Metaphors
          CustomExpandableWidget(
            title: "Metaphor",
            body: HtmlWidget(
              (model.metaphor != null ? model.metaphor!.first.body ?? "" : "")
                  .replaceAll("<br>", "")
                  .replaceAll("<p>", "")
                  .replaceAll("</p>", "<br>"),
              textStyle: AppTextStyle.font12W400ItalicHtml
                  .copyWith(color: isDarkTheme ? AppColors.lightGray : null, fontSize: viewModel.fontSize! - 4),
            ),
            visible: model.metaphor != null && model.metaphor!.isNotEmpty,
            viewModel: viewModel,
          ),
          // Culture
          CustomExpandableWidget(
            title: "Culture",
            body: HtmlWidget(
              (model.culture != null ? model.culture!.first.body ?? "" : "")
                  .replaceAll("<br>", "")
                  .replaceAll("<p>", "")
                  .replaceAll("</p>", "<br>"),
              textStyle: AppTextStyle.font12W400ItalicHtml
                  .copyWith(color: isDarkTheme ? AppColors.lightGray : null, fontSize: viewModel.fontSize! - 4),
            ),
            visible: model.culture != null && model.culture!.isNotEmpty,
            viewModel: viewModel,
          ),
          // More examples
          CustomExpandableWidget(
            title: "More Examples",
            body: HtmlWidget(
              (model.parents!.moreExamples != null ? model.parents!.moreExamples ?? "" : "")
                  .replaceAll("<br>", "")
                  .replaceAll("<p>", "")
                  .replaceAll("</p>", "<br>"),
              textStyle: AppTextStyle.font12W400ItalicHtml
                  .copyWith(color: isDarkTheme ? AppColors.lightGray : null, fontSize: viewModel.fontSize! - 4),
            ),
            visible: model.parents!.moreExamples != null && model.parents!.moreExamples!.isNotEmpty,
            viewModel: viewModel,
          ),
          // Phrases and Idioms
          CustomExpandableWidget(
            title: "Phrases and Idioms",
            viewModel: viewModel,
            isExpanded: viewModel.hasToBeExpanded(model.phrasesWithAll),
            body: (model.phrasesWithAll != null && model.phrasesWithAll!.isNotEmpty)
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model.phrasesWithAll!.length,
                    itemBuilder: (context, index) {
                      var phraseModel = model.phrasesWithAll![index];
                      bool isSelected =
                          viewModel.isWordEqual(phraseModel.phrases!.pWord ?? "") && viewModel.getFirstPhrase;
                      if (viewModel.localViewModel.isSearchByUz) {
                        isSelected = viewModel.isWordContained(
                                viewModel.conductToStringPhrasesTranslate(phraseModel.phrasesTranslate ?? [])) &&
                            viewModel.getFirstPhrase;
                      }
                      if (isSelected) {
                        viewModel.firstAutoScroll();
                      }
                      return Container(
                        key: isSelected ? viewModel.scrollKey : null,
                        child: PhrasesWidget(model: phraseModel, orderNum: '1', index: index),
                      );
                    },
                  )
                : const SizedBox.shrink(),
            visible: model.phrasesWithAll != null && model.phrasesWithAll!.isNotEmpty,
          ),
        ],
      ),
    );
  }
}
