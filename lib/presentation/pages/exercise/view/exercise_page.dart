import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/presentation/components/exercise_item.dart';
import 'package:wisdom/presentation/pages/exercise/viewmodel/exercise_page_viewmodel.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_text_style.dart';
import '../../../../config/constants/assets.dart';
import '../../../../config/constants/constants.dart';
import '../../../../core/di/app_locator.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/loading_widget.dart';

// ignore: must_be_immutable
class ExercisePage extends ViewModelBuilderWidget<ExercisePageViewModel> {
  ExercisePage({super.key});

  @override
  void onViewModelReady(ExercisePageViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.init();
  }

  @override
  Widget builder(BuildContext context, ExercisePageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goBack(),
      child: Scaffold(
        backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: CustomAppBar(
          title: 'navigation_exercise'.tr(),
          onTap: () => viewModel.goBack(),
          leadingIcon: Assets.icons.arrowLeft,
        ),
        body: viewModel.isSuccess(tag: viewModel.gettingReadyTag)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
                    child: Align(
                      child: Flexible(
                        child: Text.rich(
                          TextSpan(
                            text: "exercise_title".tr(),
                            style: AppTextStyle.font16W700Normal
                                .copyWith(color: isDarkTheme ? AppColors.white : AppColors.darkGray),
                            children: [
                              TextSpan(
                                text:
                                    ("\n${"${viewModel.tryNumber} ${"inCorrect".tr().toLowerCase()} ${viewModel.tryNumber != 1 ? "tries" : "try"}".tr()} ${"left".tr()}"),
                                style: AppTextStyle.font16W700Normal
                                    .copyWith(color: viewModel.tryNumber < 3 ? AppColors.accentLight : Colors.green),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // For English words
                        Expanded(
                          flex: 20,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(left: 12.w, bottom: 25.h, right: 2),
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: viewModel.englishList.length,
                            itemBuilder: (context, index) {
                              var model = viewModel.englishList[index];
                              return ExerciseItem(
                                isSelected: model.id == viewModel.engSelectedIndex,
                                isEven: index.isEven,
                                model: model,
                                onTap: (id) {
                                  viewModel.listEngIndex = index;
                                  viewModel.engSelectedIndex = id;
                                  viewModel.textToSpeech(model.word);
                                  viewModel.checkTheResult();
                                },
                              );
                            },
                          ),
                        ),
                        // For uzbek words
                        Expanded(
                          flex: 20,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.only(right: 12.w, bottom: 25.h, left: 2),
                            itemCount: viewModel.uzbList.length,
                            itemBuilder: (context, index) {
                              var model = viewModel.uzbList[index];
                              return ExerciseItem(
                                isSelected: model.id == viewModel.uzSelectedIndex,
                                isEven: index.isEven,
                                model: model,
                                onTap: (id) {
                                  viewModel.listUzIndex = index;
                                  viewModel.uzSelectedIndex = id;
                                  viewModel.checkTheResult();
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  (viewModel.engSelectedIndex != -1)
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: viewModel.englishList[viewModel.listEngIndex].word,
                                  children: [
                                    (viewModel.uzSelectedIndex == viewModel.engSelectedIndex)
                                        ? TextSpan(
                                            text: " - ${viewModel.englishList[viewModel.listEngIndex].translation}",
                                          )
                                        : const TextSpan(),
                                  ],
                                ),
                                style: AppTextStyle.font16W500Normal
                                    .copyWith(color: isDarkTheme ? AppColors.white : AppColors.darkGray),
                                textAlign: TextAlign.center,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "[${viewModel.englishList[viewModel.listEngIndex].wordClassBody}]" ?? "",
                                        style: AppTextStyle.font14W400NormalHtml.copyWith(color: AppColors.gray),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    GestureDetector(
                                        onTap: () => viewModel
                                            .textToSpeech(viewModel.englishList[viewModel.listEngIndex].word ?? ""),
                                        child: SvgPicture.asset(Assets.icons.sound, color: AppColors.blue)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: Text(
                                  viewModel.wordBankList[viewModel.listEngIndex].wordClass ?? "",
                                  style: AppTextStyle.font14W500Normal.copyWith(color: Colors.green),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5.h),
                                child: Text(
                                  viewModel.wordBankList[viewModel.listEngIndex].example ?? "",
                                  style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.paleGray),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              )
            : const LoadingWidget(),
        floatingActionButton: Container(
          margin: const EdgeInsets.only(bottom: 65),
          decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(25.r)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => viewModel.goToFinish(),
              borderRadius: BorderRadius.circular(25.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.exercise, height: 20.h, fit: BoxFit.scaleDown),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'end_exercise'.tr(),
                        style: AppTextStyle.font14W500Normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  ExercisePageViewModel viewModelBuilder(BuildContext context) {
    return ExercisePageViewModel(context: context, localViewModel: locator.get(), wordEntityRepository: locator.get());
  }
}
