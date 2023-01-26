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

class ParentPhrasesWidget extends ViewModelWidget<WordDetailPageViewModel> {
  const ParentPhrasesWidget({
    super.key,
    required this.model,
    required this.orderNum,
  });

  final ParentPhrasesWithAll model;
  final String orderNum;

  @override
  Widget build(BuildContext context, viewModel) {
    GlobalKey widgetKey = GlobalKey();
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${model.parentPhrases!.word ?? ""} ",
            style: AppTextStyle.font14W700Normal.copyWith(color: AppColors.blue),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  key: widgetKey,
                  child: GestureDetector(
                      onTap: () => viewModel.addToWordBankFromParentPhrase(model, orderNum, widgetKey),
                      child: Padding(
                          padding: EdgeInsets.only(right: 10.w), child: SvgPicture.asset(Assets.icons.saveWord))),
                ),
                (model.parentPhrases!.star ?? 0).toString() != "0"
                    ? Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: SvgPicture.asset(viewModel.findRank(model.parentPhrases!.star!.toString())))
                    : const SizedBox.shrink(),
                Flexible(
                  child: SelectionArea(
                    child: RichText(
                      text: TextSpan(
                        text: "$orderNum. ",
                        style: AppTextStyle.font14W700Normal.copyWith(color: AppColors.darkGray),
                        children: [
                          TextSpan(
                            text: "${model.parentPhrases!.wordClassComment ?? ""} ",
                            style: AppTextStyle.font14W400Normal.copyWith(color: AppColors.paleGray),
                          ),
                          TextSpan(
                            text: viewModel.conductToStringParentPhrasesTranslate(model.parentPhrasesTranslate),
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
              padding: EdgeInsets.only(left: 10.w),
              child: SelectionArea(
                child: Text(
                  (viewModel.conductToStringParentPhrasesExamples(model.phrasesExample)),
                  style: AppTextStyle.font14W400ItalicHtml,
                ),
              ),
            ),
          ),
          // Synonyms
          CustomExpandableWidget(
            title: "Synonyms",
            containerColor: AppColors.lightBlue,
            body: HtmlWidget(
              (model.parentPhrases!.symonyms ?? "").replaceFirst("\n", "").replaceAll("\n\n", "\n"),
            ),
            visible: model.parentPhrases!.symonyms != null,
          ),
        ],
      ),
    );
  }
}
