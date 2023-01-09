import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/presentation/pages/profile/viewmodel/profile_page_viewmodel.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../components/custom_banner.dart';

class ProfilePage extends ViewModelBuilderWidget<ProfilePageViewModel> {
  ProfilePage({super.key});

  @override
  Widget builder(BuildContext context, ProfilePageViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        title: 'Shahsiy kabinet',
        onTap: () => viewModel.pop(),
        leadingIcon: Assets.icons.arrowLeft,
      ),
      body: Padding(
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
                            '+998(99) 005 16 73',
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
                      text: 'Mening hozirgi holatim: ',
                      style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.paleGray),
                      children: const [
                        TextSpan(
                          text: '2036 yilgacha 29 000 so\'m',
                          style: TextStyle(color: AppColors.blue),
                        ),
                      ]),
                  textAlign: TextAlign.center,
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
