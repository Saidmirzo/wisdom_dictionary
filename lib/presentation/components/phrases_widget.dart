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
import 'package:wisdom/presentation/components/parent_phrases_widget.dart';

import '../../config/constants/assets.dart';
import '../pages/word_detail/viewmodel/word_detail_page_viewmodel.dart';

class PhrasesWidget extends ViewModelWidget<WordDetailPageViewModel> {
  const PhrasesWidget({
    super.key,
    required this.model,
    required this.orderNum,
    required this.index,
  });

  final PhrasesWithAll model;
  final String orderNum;
  final int index;

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
            "${model.phrases!.pWord ?? ""} ",
            style: AppTextStyle.font14W700Normal.copyWith(
                color: AppColors.blue,
                fontSize: viewModel.fontSize! - 2,
                backgroundColor:
                    viewModel.isWordContained(model.phrases!.pWord ?? "") ? AppColors.success : Colors.transparent),
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
                      onTap: () => viewModel.addToWordBankFromPhrase(model, orderNum, widgetKey),
                      child: Padding(
                          padding: EdgeInsets.only(right: 10.w), child: SvgPicture.asset(Assets.icons.saveWord))),
                ),
                (model.phrases!.pStar ?? 0).toString() != "0"
                    ? Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: SvgPicture.asset(viewModel.findRank(model.phrases!.pStar!.toString())))
                    : const SizedBox.shrink(),
                Flexible(
                  child: SelectionArea(
                    child: Text.rich(
                      TextSpan(
                        text: (model.parentPhrasesWithAll != null && model.parentPhrasesWithAll!.isNotEmpty)
                            ? "$orderNum. "
                            : "",
                        style: AppTextStyle.font14W700Normal.copyWith(
                          color: AppColors.darkGray,
                          fontSize: viewModel.fontSize! - 2,
                        ),
                        children: [
                          TextSpan(
                            text: "${model.phrases!.pWordClassComment ?? ""} ",
                            style: AppTextStyle.font14W400Normal.copyWith(
                              color: AppColors.paleGray,
                              fontSize: viewModel.fontSize! - 2,
                            ),
                          ),
                          TextSpan(
                            text: viewModel.conductToStringPhrasesTranslate(model.phrasesTranslate),
                            style: AppTextStyle.font14W600Normal.copyWith(
                              color: AppColors.darkGray,
                              fontSize: viewModel.fontSize! - 2,
                            ),
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
                  (viewModel.conductToStringPhrasesExamples(model.phrasesExample)),
                  style: AppTextStyle.font14W400ItalicHtml.copyWith(fontSize: viewModel.fontSize!-2),
                ),
              ),
            ),
          ),
          // Synonyms
          CustomExpandableWidget(
            title: "Synonyms",
            viewModel: viewModel,
            containerColor: AppColors.lightBlue,
            body: HtmlWidget(
              (model.phrases!.pSynonyms ?? "").replaceFirst("\n", "").replaceAll("\n\n", "\n"),
              textStyle: AppTextStyle.font12W400ItalicHtml.copyWith(fontSize: viewModel.fontSize! - 4),
            ),
            visible: model.phrases!.pSynonyms != null,
          ),
          // List for parent phrases
          (model.parentPhrasesWithAll != null && model.parentPhrasesWithAll!.isNotEmpty)
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.parentPhrasesWithAll!.length,
                  itemBuilder: (context, index) {
                    var phraseModel = model.parentPhrasesWithAll![index];
                    return ParentPhrasesWidget(model: phraseModel, orderNum: "${index + 2}");
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
