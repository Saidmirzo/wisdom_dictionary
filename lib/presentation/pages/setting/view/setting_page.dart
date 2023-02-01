import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/core/domain/entities/def_enum.dart';
import 'package:wisdom/core/services/local_notification_service.dart';
import 'package:wisdom/presentation/components/custom_number_picker.dart';
import 'package:wisdom/presentation/components/custom_oval_button.dart';
import 'package:wisdom/presentation/components/locked.dart';
import 'package:wisdom/presentation/pages/setting/viewmodel/setting_page_viewmodel.dart';

import '../../../widgets/custom_app_bar.dart';

class SettingPage extends ViewModelBuilderWidget<SettingPageViewModel> {
  SettingPage({super.key});

  TimeOfDay? timeOfDay = const TimeOfDay(hour: 0, minute: 0);

  @override
  Widget builder(BuildContext context, SettingPageViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        title: 'Sozlamalar',
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
            decoration: AppDecoration.bannerDecor,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tilni o\'zgartirish',
                  style: AppTextStyle.font16W600Normal.copyWith(
                    color: AppColors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomOvalButton(
                          isActive: viewModel.currentLang == LanguageOption.uzbek,
                          textStyle: AppTextStyle.font14W500Normal,
                          label: 'Uzbek',
                          onTap: () {
                            viewModel.currentLang = LanguageOption.uzbek;
                            viewModel.notifyListeners();
                          },
                          height: 38.h,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: CustomOvalButton(
                          isActive: viewModel.currentLang == LanguageOption.english,
                          textStyle: AppTextStyle.font14W500Normal,
                          label: 'English',
                          onTap: () {
                            viewModel.currentLang = LanguageOption.english;
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
          // Select theme
          Stack(
            children: [
              Container(
                decoration: AppDecoration.bannerDecor,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                margin: const EdgeInsets.only(top: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mavzu',
                      style: AppTextStyle.font16W600Normal.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomOvalButton(
                              isActive: viewModel.currentTheme == ThemeOption.day,
                              textStyle: AppTextStyle.font14W500Normal,
                              label: 'Light mode',
                              onTap: () {
                                viewModel.currentTheme = ThemeOption.day;
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
                              isActive: viewModel.currentTheme == ThemeOption.night,
                              textStyle: AppTextStyle.font14W500Normal,
                              label: 'Night mode',
                              prefixIcon: true,
                              imgAssets: Assets.icons.moon,
                              onTap: () {
                                viewModel.currentTheme = ThemeOption.night;
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
              const Locked(),
            ],
          ),
          // Change word size
          Stack(
            children: [
              Container(
                decoration: AppDecoration.bannerDecor,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                margin: EdgeInsets.only(top: 16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'Shirftni o\'zgartirish',
                        style: AppTextStyle.font16W600Normal.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w, bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(Assets.icons.fontReduce),
                          SvgPicture.asset(Assets.icons.fontIncrease),
                        ],
                      ),
                    ),
                    Slider(
                      min: 0,
                      max: 14,
                      value: viewModel.fontSizeValue,
                      onChanged: (value) {
                        viewModel.fontSizeValue = value;
                        viewModel.notifyListeners();
                      },
                      activeColor: AppColors.blue,
                      inactiveColor: AppColors.seekerBack.withOpacity(0.2),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, right: 16.w, top: 10.h),
                      child: Text(
                        'Wisdom Dictionary',
                        style: AppTextStyle.font14W500Normal
                            .copyWith(fontSize: 10 + viewModel.fontSizeValue, color: AppColors.darkGray),
                      ),
                    )
                  ],
                ),
              ),
              // const Locked(),
            ],
          ),
          // Word Reminder
          Stack(
            children: [
              Container(
                decoration: AppDecoration.bannerDecor,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                margin: EdgeInsets.only(top: 16.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'So\'z eslatuvchi',
                        style: AppTextStyle.font16W600Normal.copyWith(
                          color: AppColors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
                      child: Text(
                        'Yangi so\'z eslish: So\'zlar yuboriladigan vaqti oralig\'ini tanlang!',
                        style: AppTextStyle.font14W500Normal.copyWith(
                          color: AppColors.darkGray,
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
                                'Berilgan vaqt',
                                style: AppTextStyle.font12W500Normal.copyWith(
                                  color: AppColors.black,
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
                                'Avtomatik vaqt',
                                style: AppTextStyle.font12W500Normal.copyWith(
                                  color: AppColors.black,
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
                                ':',
                                style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.black),
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
                                'da',
                                style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.black),
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
                              'har',
                              style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.black),
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
                              'soatda',
                              style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        timeOfDay = await showTimePicker(context: context, initialTime: timeOfDay!);
                        print(timeOfDay);
                      },
                      child: const Text("Time"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: CustomOvalButton(
                        label: 'Saqlash',
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
              // Locked(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  SettingPageViewModel viewModelBuilder(BuildContext context) {
    return SettingPageViewModel(context: context);
  }
}
