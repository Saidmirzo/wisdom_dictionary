import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/presentation/pages/profile/viewmodel/profile_page_viewmodel.dart';
import 'package:wisdom/presentation/routes/routes.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../config/constants/constants.dart';

// ignore: must_be_immutable
class GettingProPage extends ViewModelBuilderWidget<ProfilePageViewModel> {
  GettingProPage({super.key});

  @override
  Widget builder(BuildContext context, ProfilePageViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: CustomAppBar(
        title: "app_name".tr(),
        onTap: () => viewModel.pop(),
        leadingIcon: Assets.icons.arrowLeft,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 57.h, left: 18.w, right: 18.w),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.icons.logoBlueText,
                height: 52.h,
                fit: BoxFit.scaleDown,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.h, bottom: 36.h),
                child: Text(
                  'Eng yaxshi sarmoya bilimga bo\'lgan sarmoyadir!\nIshonavering siz kerakli joyga sarmoya qilmoqdasiz.',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.font12W400Normal
                      .copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
                ),
              ),
              Container(
                decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                child: Column(
                  children: [
                    RadioListTile(
                      title: Text(
                        "Bir martalik to'lov",
                        style: AppTextStyle.font14W500Normal
                            .copyWith(color: isDarkTheme ? AppColors.white : AppColors.darkGray),
                      ),
                      value: true,
                      groupValue: true,
                      onChanged: (value) {},
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: AppColors.blue),
                      height: 45.h,
                      margin: EdgeInsets.only(top: 24.h, bottom: 12.h),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => viewModel.navigateTo(Routes.registrationPage),
                          borderRadius: BorderRadius.circular(40.r),
                          child: Center(
                            child: Text(
                              'buy'.tr(),
                              style: AppTextStyle.font14W500Normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // ignore: prefer_const_literals_to_create_immutables
                    GestureDetector(
                      onTap: () => viewModel.navigateTo(Routes.registrationPage),
                      child: RichText(
                        text: TextSpan(
                          style: AppTextStyle.font12W500Normal
                              .copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
                          text: 'Ro\'yhatdan o\'tganmisiz ?',
                          children: [
                            TextSpan(
                              text: ' Ro\'yhatdan o\'tish',
                              style: AppTextStyle.font12W500Normal
                                  .copyWith(color: AppColors.blue, decoration: TextDecoration.underline),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ProfilePageViewModel viewModelBuilder(BuildContext context) {
    return ProfilePageViewModel(context: context);
  }
}
