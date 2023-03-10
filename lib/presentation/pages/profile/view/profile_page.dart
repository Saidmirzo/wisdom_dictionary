import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../components/custom_banner.dart';
import '../viewmodel/profile_page_viewmodel.dart';

class ProfilePage extends ViewModelBuilderWidget<ProfilePageViewModel> {
  ProfilePage({super.key});

  @override
  void onViewModelReady(ProfilePageViewModel viewModel) {
    viewModel.getTariffs();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, ProfilePageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goBackToMenu(),
      child: Scaffold(
        backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: CustomAppBar(
          title: "personal_cabinet".tr(),
          onTap: () => viewModel.goBackToMenu(),
          leadingIcon: Assets.icons.arrowLeft,
        ),
        body: viewModel.isSuccess(tag: viewModel.getTariffsTag)
            ? Padding(
                padding: EdgeInsets.only(top: 30.h, left: 18.w, right: 18.w),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomBanner(
                        title: 'subscription_number'.tr(),
                        contentPadding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                        child: Center(
                          child: Text(
                            viewModel.sharedPreferenceHelper.getString(Constants.KEY_PHONE, ""),
                            style: AppTextStyle.font18W500Normal
                                .copyWith(color: isDarkTheme ? AppColors.white : AppColors.blue, fontSize: 20),
                          ),
                        ),
                      ),
                      CustomBanner(
                        title: 'current_plan'.tr(),
                        contentPadding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                        child: RichText(
                          text: TextSpan(
                              text: 'current_plan'.tr() + '\n',
                              style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.paleGray),
                              children: [
                                TextSpan(
                                  text: (viewModel.localViewModel.profileState == 1)
                                      ? ((context.locale.toString() == "en_US"
                                                  ? viewModel.tariffsModel.name!.en
                                                  : viewModel.tariffsModel.name!.uz) ??
                                              "Connect with developers")
                                          .toUpperCase()
                                      : "not_purchased".tr(),
                                  style: TextStyle(
                                      color: viewModel.localViewModel.profileState == 1
                                          ? AppColors.blue
                                          : AppColors.accentLight),
                                ),
                              ]),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Visibility(
                        visible: viewModel.localViewModel.profileState != 1,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: AppColors.blue),
                          height: 45.h,
                          margin: EdgeInsets.only(top: 40.h, bottom: 12.h),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => viewModel.onPaymentPressed(),
                              borderRadius: BorderRadius.circular(40.r),
                              child: Center(
                                child: Text(
                                  'do_payment'.tr(),
                                  style: AppTextStyle.font14W500Normal,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  ProfilePageViewModel viewModelBuilder(BuildContext context) {
    return ProfilePageViewModel(
      context: context,
      profileRepository: locator.get(),
      localViewModel: locator.get(),
      sharedPreferenceHelper: locator.get(),
    );
  }
}
