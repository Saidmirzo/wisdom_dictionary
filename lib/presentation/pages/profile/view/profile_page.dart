import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../core/di/app_locator.dart';
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
        backgroundColor: AppColors.lightBackground,
        appBar: CustomAppBar(
          title: 'Shaxsiy kabinet',
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
                      Stack(
                        children: [
                          Container(
                            height: 144.h,
                            margin: EdgeInsets.only(top: 80.h),
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            decoration: AppDecoration.bannerDecor,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(18.r),
                                onTap: () {},
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Text(
                                    viewModel.sharedPreferenceHelper.getString(Constants.KEY_PHONE, ""),
                                    style: AppTextStyle.font18W500Normal.copyWith(color: AppColors.blue, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: SvgPicture.asset(Assets.images.profile),
                          )
                        ],
                      ),
                      CustomBanner(
                        title: 'Holat',
                        contentPadding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                        child: RichText(
                          text: TextSpan(
                              text: 'Mening hozirgi holatim: \n',
                              style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.paleGray),
                              children: [
                                TextSpan(
                                  text: (viewModel.localViewModel.profileState == 1)
                                      ? (viewModel.tariffsModel.name!.en ??
                                              "Connect with developers")
                                          .toUpperCase()
                                      : "Not purchased yet",
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
                        visible: viewModel.localViewModel.profileState!= 1,
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
                                  'To\'lovni amalga oshirish',
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
        sharedPreferenceHelper: locator.get());
  }
}
