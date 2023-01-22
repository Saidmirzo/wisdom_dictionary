import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/data/model/phrases_with_all.dart';
import 'package:wisdom/presentation/components/custom_expandable_widget.dart';

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
                Padding(padding: EdgeInsets.only(right: 10.w), child: SvgPicture.asset(Assets.icons.saveWord)),
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
                            style: AppTextStyle.font14W700Normal.copyWith(color: AppColors.darkGray),
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
            isExpanded: viewModel.synonymsIsExpanded,
            title: "Synonyms",
            body: HtmlWidget(
              (model.parents!.synonyms ?? "").replaceFirst("\n", "").replaceAll("\n\n", "\n"),
              // textStyle: AppTextStyle.font12W400ItalicHtml,
            ),
            visible: model.parents!.synonyms != null,
          ),
          // Antonym
          CustomExpandableWidget(
            isExpanded: viewModel.synonymsIsExpanded,
            title: "Antonyms",
            body: HtmlWidget(
              (model.parents!.anthonims ?? "").replaceFirst("\n", "").replaceAll("\n\n", "\n"),
              // textStyle: AppTextStyle.font12W400ItalicHtml,
            ),
            visible: model.parents!.anthonims != null,
          ),
          // Grammar
          CustomExpandableWidget(
            isExpanded: viewModel.synonymsIsExpanded,
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
            isExpanded: viewModel.synonymsIsExpanded,
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
            isExpanded: viewModel.synonymsIsExpanded,
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
            isExpanded: viewModel.synonymsIsExpanded,
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
            isExpanded: viewModel.synonymsIsExpanded,
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
            isExpanded: viewModel.synonymsIsExpanded,
            title: "Metaphor",
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
            isExpanded: viewModel.synonymsIsExpanded,
            title: "More Examples",
            body: HtmlWidget(
              (model.parents!.moreExamples != null ? model.parents!.moreExamples ?? "" : "")
                  .replaceFirst("\n", "")
                  .replaceAll("\n\n", "\n"),
              // textStyle: AppTextStyle.font12W400ItalicHtml,
            ),
            visible: model.parents!.moreExamples != null && model.parents!.moreExamples!.isNotEmpty,
          ),
        ],
      ),
    );
  }
}
