import 'package:easy_localization/easy_localization.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/components/exercise_result_item.dart';
import 'package:wisdom/presentation/pages/exercise/viewmodel/exercise_final_page_viewmodel.dart';
import 'package:wisdom/presentation/widgets/loading_widget.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/constants.dart';
import '../../../widgets/custom_app_bar.dart';

class ExerciseFinalPage extends ViewModelBuilderWidget<ExerciseFinalPageViewModel> {
  @override
  void onViewModelReady(ExerciseFinalPageViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, ExerciseFinalPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goBack(),
      child: Scaffold(
        backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: CustomAppBar(
          title: 'navigation_result'.tr(),
          onTap: () => viewModel.goBack(),
          leadingIcon: Assets.icons.arrowLeft,
        ),
        body: (viewModel.correctList.isNotEmpty || viewModel.incorrect.isNotEmpty)
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.h, bottom: 60.h),
                // padding: EdgeInsets.only(bottom: 60.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.h, top: 15.h),
                      child: Text(
                        "knew_word".tr() +
                            viewModel.correctList.length.toString() +
                            "out_of".tr() +
                            viewModel.localViewModel.finalList.length.toString() +
                            "attempts".tr(),
                        style: AppTextStyle.font18W500Normal
                            .copyWith(color: isDarkTheme ? AppColors.white : AppColors.darkGray),
                      ),
                    ),
                    Container(
                      decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(
                            tapHeaderToExpand: true,
                            tapBodyToCollapse: false,
                            tapBodyToExpand: false,
                            headerAlignment: ExpandablePanelHeaderAlignment.center,
                            iconColor: isDarkTheme ? AppColors.borderWhite : AppColors.darkGray),
                        collapsed: const SizedBox.shrink(),
                        header: Center(
                          child: Text(
                            "correct_anwers".tr(),
                            style: AppTextStyle.font16W600Normal
                                .copyWith(color: isDarkTheme ? AppColors.borderWhite : AppColors.darkGray),
                          ),
                        ),
                        expanded: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: viewModel.correctList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var model = viewModel.correctList[index];
                            return ExerciseResultItem(model: model);
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.h, top: 20.h),
                      child: Text(
                        "didnt_know_word".tr() +
                            viewModel.incorrect.length.toString() +
                            "out_of".tr() +
                            viewModel.localViewModel.finalList.length.toString() +
                            "attempts".tr(),
                        style: AppTextStyle.font18W500Normal
                            .copyWith(color: isDarkTheme ? AppColors.white : AppColors.darkGray),
                      ),
                    ),
                    Container(
                      decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: ExpandablePanel(
                        theme: ExpandableThemeData(
                            tapHeaderToExpand: true,
                            tapBodyToCollapse: false,
                            tapBodyToExpand: false,
                            headerAlignment: ExpandablePanelHeaderAlignment.center,
                            iconColor: isDarkTheme ? AppColors.borderWhite : AppColors.darkGray),
                        collapsed: const SizedBox.shrink(),
                        header: Center(
                          child: Text(
                            "wrong_anwers".tr(),
                            style: AppTextStyle.font16W600Normal
                                .copyWith(color: isDarkTheme ? AppColors.borderWhite : AppColors.darkGray),
                          ),
                        ),
                        expanded: ListView.builder(
                          itemCount: viewModel.incorrect.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var model = viewModel.incorrect[index];
                            return ExerciseResultItem(model: model);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const LoadingWidget(),
      ),
    );
  }

  @override
  ExerciseFinalPageViewModel viewModelBuilder(BuildContext context) {
    return ExerciseFinalPageViewModel(
        context: context, localViewModel: locator.get(), wordEntityRepository: locator.get());
  }
}
