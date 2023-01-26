import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jbaza/jbaza.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/data/model/phrases_with_all.dart';
import 'package:wisdom/presentation/components/custom_expandable_widget.dart';
import 'package:wisdom/presentation/components/phrases_widget.dart';

import '../../config/constants/assets.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  key: widgetKey,
                  child: GestureDetector(
                    onTap: () => viewModel.addToWordBankFromParent(model, orderNum, widgetKey),
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: SvgPicture.asset(Assets.icons.saveWord),
                    ),
                  ),
                ),
                model.parents!.star != "0"
                    ? Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: SvgPicture.asset(viewModel.findRank(model.parents!.star!)))
                    : const SizedBox.shrink(),
                Flexible(
                  child: SelectionArea(
                    child: RichText(
                      text: TextSpan(
                        text: "$orderNum. ",
                        style: AppTextStyle.font14W700Normal.copyWith(color: AppColors.darkGray),
                        children: [
                          TextSpan(
                            text: orderNum == "1"
                                ? "${model.parents!.wordClassBodyMeaning ?? ""} "
                                : "${model.parents!.wordClassBody ?? ""} ",
                            style: AppTextStyle.font14W400Normal.copyWith(color: AppColors.paleGray),
                          ),
                          TextSpan(
                            text: viewModel.conductToString(model.wordsUz),
                            style: AppTextStyle.font14W600Normal.copyWith(color: AppColors.darkGray),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          // Example
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(bottom: 10.h, left: 10.w),
              child: SelectionArea(
                child: HtmlWidget(
                  (model.parents!.example ?? "").replaceAll("\n", ""),
                  textStyle: AppTextStyle.font14W400ItalicHtml,
                ),
              ),
            ),
          ),
          // examples
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: SelectionArea(
                child: HtmlWidget(
                  (model.parents!.examples ?? "").replaceFirst("\n", "").replaceAll("\n\n", "\n"),
                  textStyle: AppTextStyle.font14W400ItalicHtml,
                ),
              ),
            ),
          ),
          // Synonyms
          CustomExpandableWidget(
            title: "Synonyms",
            body: HtmlWidget(
              (model.parents!.synonyms ?? "").replaceFirst("\n", "").replaceAll("\n\n", "\n"),
              // textStyle: AppTextStyle.font12W400ItalicHtml,
            ),
            visible: model.parents!.synonyms != null,
          ),
          // Antonym
          CustomExpandableWidget(
            title: "Antonyms",
            body: HtmlWidget(
              (model.parents!.anthonims ?? "").replaceFirst("\n", "").replaceAll("\n\n", "\n"),
              // textStyle: AppTextStyle.font12W400ItalicHtml,
            ),
            visible: model.parents!.anthonims != null,
          ),
          // Grammar
          CustomExpandableWidget(
            title: "Grammar",
            body: HtmlWidget(
              (model.grammar != null ? model.grammar!.first.body ?? "" : "")
                  .replaceFirst("\n", "")
                  .replaceAll("\n\n", "\n"),
              // textStyle: AppTextStyle.font12W400ItalicHtml,
            ),
            visible: model.grammar != null && model.grammar!.isNotEmpty,
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
                  style: AppTextStyle.font14W400Normal.copyWith(color: AppColors.darkGray),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: HtmlWidget(
                    (model.difference != null ? model.difference!.first.body ?? "" : "")
                        .replaceFirst("\n", "")
                        .replaceAll("\n\n", ""),
                    // textStyle: AppTextStyle.font12W400ItalicHtml,
                  ),
                )
              ],
            ),
            visible: model.difference != null && model.difference!.isNotEmpty,
          ),
          // Collocations
          CustomExpandableWidget(
            title: "Collocations",
            body: HtmlWidget(
              (model.collocation != null ? model.collocation!.first.body ?? "" : "")
                  .replaceFirst("\n", "")
                  .replaceAll("\n\n", "\n"),
              textStyle: AppTextStyle.font12W400ItalicHtml,
            ),
            visible: model.collocation != null && model.collocation!.isNotEmpty,
          ),
          // Thesaurus
          CustomExpandableWidget(
            title: "Thesaurus",
            body: HtmlWidget(
              (model.thesaurus != null ? model.thesaurus!.first.body ?? "" : "")
                  .replaceFirst("\n", "")
                  .replaceAll("\n\n", "\n"),
              // textStyle: AppTextStyle.font12W400ItalicHtml,
            ),
            visible: model.thesaurus != null && model.thesaurus!.isNotEmpty,
          ),
          // Metaphors
          CustomExpandableWidget(
            title: "Metaphor",
            body: HtmlWidget(
              (model.metaphor != null ? model.metaphor!.first.body ?? "" : "")
                  .replaceFirst("\n", "")
                  .replaceAll("\n\n", "\n"),
              // textStyle: AppTextStyle.font12W400ItalicHtml,
            ),
            visible: model.metaphor != null && model.metaphor!.isNotEmpty,
          ),
          // Culture
          CustomExpandableWidget(
            title: "Culture",
            body: HtmlWidget(
              (model.culture != null ? model.culture!.first.body ?? "" : "")
                  .replaceFirst("\n", "")
                  .replaceAll("\n\n", "\n"),
              // textStyle: AppTextStyle.font12W400ItalicHtml,
            ),
            visible: model.culture != null && model.culture!.isNotEmpty,
          ),
          // More examples
          CustomExpandableWidget(
            title: "More Examples",
            body: HtmlWidget(
              (model.parents!.moreExamples != null ? model.parents!.moreExamples ?? "" : "")
                  .replaceFirst("\n", "")
                  .replaceAll("\n\n", "\n"),
              // textStyle: AppTextStyle.font12W400ItalicHtml,
            ),
            visible: model.parents!.moreExamples != null && model.parents!.moreExamples!.isNotEmpty,
          ),
          // Phrases and Idioms
          CustomExpandableWidget(
            title: "Phrases and Idioms",
            isExpanded: viewModel.hasToBeExpanded(model.phrasesWithAll),
            body: (model.phrasesWithAll != null && model.phrasesWithAll!.isNotEmpty)
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model.phrasesWithAll!.length,
                    itemBuilder: (context, index) {
                      var phraseModel = model.phrasesWithAll![index];
                      viewModel.checkIfPhrase(phraseModel, index);
                      return AutoScrollTag(
                          key: ValueKey(phraseModel.phrases!.pId),
                          controller: viewModel.autoScrollController,
                          index: index,
                          child: PhrasesWidget(model: phraseModel, orderNum: '1', index: index));
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
