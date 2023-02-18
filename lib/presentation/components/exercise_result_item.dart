import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/data/model/exercise_model.dart';
import 'package:wisdom/presentation/pages/exercise/viewmodel/exercise_final_page_viewmodel.dart';

import '../../config/constants/app_colors.dart';
import '../../config/constants/app_text_style.dart';
import '../../config/constants/assets.dart';
import '../../config/constants/constants.dart';

class ExerciseResultItem extends ViewModelWidget<ExerciseFinalPageViewModel> {
  const ExerciseResultItem({super.key, required this.model});

  final ExerciseFinalModel model;

  @override
  Widget build(BuildContext context, ExerciseFinalPageViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 48.h,
                width: 48.h,
                child: SvgPicture.asset(
                  model.result ? Assets.icons.tick : Assets.icons.cross,
                  height: 24.h,
                  width: 24.h,
                  fit: BoxFit.scaleDown,
                  color: model.result ? Colors.green : Colors.red,
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text.rich(
                    TextSpan(
                      style: AppTextStyle.font14W500Normal
                          .copyWith(color: isDarkTheme ? AppColors.borderWhite : AppColors.darkGray),
                      text: model.word ?? "",
                      children: [
                        // TextSpan(
                        //   text: '   ${model.number ?? "0"}',
                        //   style: AppTextStyle.font14W400Normal
                        //       .copyWith(color: isDarkTheme ? AppColors.white : AppColors.paleGray),
                        // ),
                        TextSpan(
                          text: "\n${model.translation}" ?? "",
                          style: AppTextStyle.font14W400Normal.copyWith(color: AppColors.paleGray),
                        ),
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              model.result
                  ? SizedBox(
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
                  : const SizedBox.shrink()
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 50.w,
            ),
            child: Divider(
              color: isDarkTheme ? AppColors.darkForm : AppColors.borderWhite,
              height: 1,
              thickness: 0.5,
            ),
          )
        ],
      ),
    );
  }
}
