import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/components/pro_info.dart';
import 'package:wisdom/presentation/pages/profile/viewmodel/getting_pro_page.dart';
import 'package:wisdom/presentation/routes/routes.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../config/constants/constants.dart';

class GettingProPage extends ViewModelBuilderWidget<GettingProPageViewModel> {
  GettingProPage({super.key});

  @override
  void onViewModelReady(GettingProPageViewModel viewModel) {
    viewModel.getTariffs();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, GettingProPageViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: "app_name".tr(),
        onTap: () => viewModel.pop(),
        leadingIcon: Assets.icons.arrowLeft,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 57.h, left: 18.w, right: 18.w),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  isDarkTheme ? Assets.icons.logoWhiteText : Assets.icons.logoBlueText,
                  height: 52.h,
                  fit: BoxFit.scaleDown,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.h, bottom: 36.h),
                  child: Text(
                    'get_pro1'.tr(),
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
                      Text(
                        'get_pro2'.tr(),
                        style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.blue),
                        textAlign: TextAlign.center,
                      ),
                      ProInfo(label: "get_pro3".tr()),
                      ProInfo(label: "get_pro4".tr()),
                      ProInfo(label: "get_pro5".tr()),
                      ProInfo(label: "get_pro6".tr()),
                      ProInfo(label: "get_pro7".tr()),
                      ProInfo(label: "get_pro8".tr()),
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Text(
                          'one_time_purchase'.tr(),
                          style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.blue),
                        ),
                      ),
                      viewModel.isSuccess(tag: viewModel.getTariffsTag)
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: viewModel.profileRepository.tariffsModel.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var item = viewModel.profileRepository.tariffsModel[index];
                                return RadioListTile(
                                  title: Text(
                                    ((context.locale.toString() == "en_US" ? item.name!.en : item.name!.uz) ??
                                            "Contact with developers")
                                        .toUpperCase(),
                                    style: AppTextStyle.font14W500Normal
                                        .copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  value: item.id.toString(),
                                  groupValue: viewModel.tariffsValue,
                                  onChanged: (value) {
                                    viewModel.tariffsValue = value.toString();
                                    viewModel.notifyListeners();
                                  },
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: AppColors.blue),
                        height: 45.h,
                        margin: EdgeInsets.only(top: 15.h, bottom: 12.h),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => viewModel.onBuyPremiumPressed(),
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
                      Visibility(
                        visible: viewModel.haveAccount(),
                        child: GestureDetector(
                          onTap: () => viewModel.navigateTo(Routes.registrationPage),
                          child: RichText(
                            text: TextSpan(
                              style: AppTextStyle.font12W500Normal
                                  .copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
                              text: 'haveAccount'.tr(),
                              children: [
                                TextSpan(
                                  text: 'getAccount'.tr(),
                                  style: AppTextStyle.font12W500Normal
                                      .copyWith(color: AppColors.blue, decoration: TextDecoration.underline),
                                ),
                              ],
                            ),
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
      ),
    );
  }

  @override
  GettingProPageViewModel viewModelBuilder(BuildContext context) {
    return GettingProPageViewModel(
        context: context,
        localViewModel: locator.get(),
        profileRepository: locator.get(),
        sharedPreferenceHelper: locator.get());
  }
}
