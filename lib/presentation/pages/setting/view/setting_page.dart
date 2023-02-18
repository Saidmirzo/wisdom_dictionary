import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/core/domain/entities/def_enum.dart';
import 'package:wisdom/presentation/components/custom_number_picker.dart';
import 'package:wisdom/presentation/components/custom_oval_button.dart';
import 'package:wisdom/presentation/components/locked.dart';
import 'package:wisdom/presentation/pages/setting/viewmodel/setting_page_viewmodel.dart';

import '../../../../app.dart';
import '../../../../config/constants/constants.dart';
import '../../../../main.dart';
import '../../../widgets/custom_app_bar.dart';

// ignore: must_be_immutable
class SettingPage extends ViewModelBuilderWidget<SettingPageViewModel> {
  SettingPage({super.key});

  TimeOfDay? timeOfDay = const TimeOfDay(hour: 0, minute: 0);

  @override
  void onViewModelReady(SettingPageViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, SettingPageViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: CustomAppBar(
        title: 'settings'.tr(),
        onTap: () => Navigator.of(context).pop(),
        leadingIcon: Assets.icons.arrowLeft,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 36.h, horizontal: 28.w),
        physics: const BouncingScrollPhysics(),
        children: [
          // Changing language
          Container(
            decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "change_language".tr(),
                  style: AppTextStyle.font16W600Normal.copyWith(
                    color: isDarkTheme ? AppColors.white : AppColors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomOvalButton(
                          isActive: context.locale.toString() == "uz_UZ",
                          textStyle: AppTextStyle.font14W500Normal,
                          label: "uzbek".tr(),
                          onTap: () {
                            context.setLocale(const Locale('uz', 'UZ'));
                          },
                          height: 38.h,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: CustomOvalButton(
                          isActive: context.locale.toString() == "en_US",
                          textStyle: AppTextStyle.font14W500Normal,
                          label: "english".tr(),
                          onTap: () {
                            context.setLocale(const Locale('en', 'US'));
                          },
                          height: 38.h,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // Select theme
          Stack(
            children: [
              Container(
                decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                margin: EdgeInsets.only(top: 16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'theme'.tr(),
                      style: AppTextStyle.font16W600Normal.copyWith(
                        color: isDarkTheme ? AppColors.white : AppColors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomOvalButton(
                              isActive: !isDarkTheme,
                              textStyle: AppTextStyle.font14W500Normal,
                              label: "light".tr(),
                              onTap: () {
                                // viewModel.currentTheme = ThemeOption.day;
                                Provider.of<MainProvider>(context, listen: false).changeToLightTheme();
                                viewModel.notifyListeners();
                              },
                              height: 38.h,
                              prefixIcon: true,
                              imgAssets: Assets.icons.sun,
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Expanded(
                            child: CustomOvalButton(
                              isActive: isDarkTheme,
                              textStyle: AppTextStyle.font14W500Normal,
                              label: "dark".tr(),
                              prefixIcon: true,
                              imgAssets: Assets.icons.moon,
                              onTap: () {
                                // viewModel.currentTheme = ThemeOption.night;
                                Provider.of<MainProvider>(context, listen: false).changeToDarkTheme();
                                viewModel.notifyListeners();
                              },
                              height: 38.h,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Visibility(
              //   visible: viewModel.localViewModel.profileState != 1,
              //   child: const Locked(),
              // ),
            ],
          ),
          // Change word size
          Stack(
            children: [
              Container(
                decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                margin: EdgeInsets.only(top: 16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "change_font_size".tr(),
                        style: AppTextStyle.font16W600Normal.copyWith(
                          color: isDarkTheme ? AppColors.white : AppColors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w, bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            Assets.icons.fontReduce,
                            color: isDarkTheme ? AppColors.white : null,
                          ),
                          SvgPicture.asset(
                            Assets.icons.fontIncrease,
                            color: isDarkTheme ? AppColors.white : null,
                          ),
                        ],
                      ),
                    ),
                    Slider(
                      min: 10.sp,
                      max: 24.sp,
                      value: viewModel.fontSizeValue,
                      onChanged: (value) => viewModel.changeFontSize(value),
                      activeColor: AppColors.blue,
                      inactiveColor: AppColors.seekerBack.withOpacity(0.2),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 16.w, top: 10.h),
                      child: Text(
                        "lorem_text".tr(),
                        style: AppTextStyle.font14W500Normal.copyWith(
                            fontSize: viewModel.fontSizeValue,
                            color: isDarkTheme ? AppColors.white : AppColors.darkGray),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: viewModel.localViewModel.profileState != 1,
                child: const Locked(),
              ),
            ],
          ),
          // Word Reminder
          Stack(
            children: [
              Container(
                decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                margin: EdgeInsets.only(top: 16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "word_reminder".tr(),
                        style: AppTextStyle.font16W600Normal.copyWith(
                          color: isDarkTheme ? AppColors.white : AppColors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                      child: Text(
                        "remind_new_words".tr(),
                        style: AppTextStyle.font14W500Normal.copyWith(
                          color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 14.w, left: 3.w),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                "selected_time".tr(),
                                style: AppTextStyle.font12W500Normal.copyWith(
                                  color: isDarkTheme ? AppColors.white : AppColors.black,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(0),
                              groupValue: viewModel.currentRemind,
                              onChanged: (value) {
                                viewModel.currentRemind = RemindOption.manual;
                                viewModel.notifyListeners();
                              },
                              value: RemindOption.manual,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile(
                              title: Text(
                                "automatic_time".tr(),
                                style: AppTextStyle.font12W500Normal.copyWith(
                                  color: isDarkTheme ? AppColors.white : AppColors.black,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(0),
                              value: RemindOption.auto,
                              groupValue: viewModel.currentRemind,
                              onChanged: (value) {
                                viewModel.currentRemind = RemindOption.auto;
                                viewModel.notifyListeners();
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: viewModel.currentRemind == RemindOption.manual,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h, bottom: 30.h, left: 16.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomNumberPicker(
                              currentValue: viewModel.currentHourValue,
                              onChange: ((value) {
                                viewModel.currentHourValue = value;
                                viewModel.notifyListeners();
                              }),
                              minValue: 0,
                              maxValue: 23,
                              zeroPad: true,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                ":".tr(),
                                style: AppTextStyle.font16W500Normal.copyWith(
                                  color: isDarkTheme ? AppColors.white : AppColors.black,
                                ),
                              ),
                            ),
                            CustomNumberPicker(
                              currentValue: viewModel.currentMinuteValue,
                              onChange: ((value) {
                                viewModel.currentMinuteValue = value;
                                timeOfDay = TimeOfDay(
                                  hour: viewModel.currentHourValue,
                                  minute: viewModel.currentMinuteValue,
                                );
                                viewModel.notifyListeners();
                              }),
                              minValue: 0,
                              maxValue: 59,
                              zeroPad: true,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Text(
                                'da'.tr(),
                                style: AppTextStyle.font16W500Normal.copyWith(
                                  color: isDarkTheme ? AppColors.white : AppColors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: viewModel.currentRemind == RemindOption.auto,
                      child: Padding(
                        padding: EdgeInsets.only(top: 20.h, bottom: 30.h, left: 16.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "every".tr(),
                              style: AppTextStyle.font16W500Normal.copyWith(
                                color: isDarkTheme ? AppColors.white : AppColors.black,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: CustomNumberPicker(
                                currentValue: viewModel.currentRepeatHourValue,
                                onChange: ((value) {
                                  viewModel.currentRepeatHourValue = value;
                                  viewModel.notifyListeners();
                                }),
                                minValue: 0,
                                maxValue: 24,
                                zeroPad: true,
                              ),
                            ),
                            Text(
                              'hour'.tr(),
                              style: AppTextStyle.font16W500Normal.copyWith(
                                color: isDarkTheme ? AppColors.white : AppColors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomOvalButton(
                        label: "save".tr(),
                        onTap: () {
                          if (viewModel.currentRemind == RemindOption.manual) {
                            viewModel.scheduleNotification(timeOfDay!);
                          } else {
                            viewModel.scheduleAutomaticNotification();
                          }
                        },
                        textStyle: AppTextStyle.font16W500Normal,
                        isActive: true,
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: viewModel.localViewModel.profileState != 1,
                child: const Locked(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  SettingPageViewModel viewModelBuilder(BuildContext context) {
    return SettingPageViewModel(
        context: context,
        preferenceHelper: locator.get(),
        localViewModel: locator.get(),
        sharedPreferenceHelper: locator.get());
  }
}
