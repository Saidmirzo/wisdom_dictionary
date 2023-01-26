import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/data/model/word_bank_model.dart';
import 'package:wisdom/presentation/pages/word_bank/viewmodel/wordbank_viewmodel.dart';

class WordBankItem extends ViewModelWidget<WordBankViewModel> {
  const WordBankItem({
    required this.model,
  });

  final WordBankModel model;

  @override
  Widget build(BuildContext context, WordBankViewModel viewModel) {
    return InkResponse(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          ExpandablePanel(
            theme: const ExpandableThemeData(hasIcon: false),
            header: Padding(
              padding: EdgeInsets.only(left: 30.w, right: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.darkGray),
                        text: model.word ?? "",
                        children: [
                          TextSpan(
                            text: '   ${model.number ?? "0"}',
                            style: AppTextStyle.font14W400Normal.copyWith(color: AppColors.paleGray),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 48.h,
                    width: 48.h,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => viewModel.deleteWordBank(model),
                        borderRadius: BorderRadius.circular(24.r),
                        child: SvgPicture.asset(
                          Assets.icons.trash,
                          height: 24.h,
                          width: 24.h,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            expanded: Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 30.w, right: 25.w, bottom: 10),
                child: Text(
                  model.translation ?? "",
                  style: AppTextStyle.font14W400Normal.copyWith(color: AppColors.paleGray),
                ),
              ),
            ),
            collapsed: const SizedBox.shrink(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50.w,
            ),
            child: const Divider(
              color: AppColors.borderWhite,
              height: 1,
              thickness: 0.5,
            ),
          )
        ],
      ),
    );
  }
}
