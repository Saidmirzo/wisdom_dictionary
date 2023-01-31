import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import '../../config/constants/assets.dart';
import '../../config/constants/constants.dart';
import '../widgets/custom_app_bar.dart';

class AboutUnitItemPage extends StatelessWidget {
  const AboutUnitItemPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: const Color(0XFFF6F9FF),
      appBar: CustomAppBar(
        title: title,
        onTap: () => Navigator.pop(context),
        leadingIcon: Assets.icons.arrowLeft,
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 33.h, horizontal: 22.w),
                decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                child: Column(
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.font16W600Normal.copyWith(color: AppColors.darkGray),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: Text(
                        'Guruh tuzmoq deyish uchun make a bandemas from a band deyiladi',
                        style: AppTextStyle.font14W400Normal.copyWith(color: AppColors.paleGray),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
              height: 165.h,
              child: Center(
                child: Text(
                  'Reklama uchun joy',
                  style: AppTextStyle.font14W500Normal.copyWith(
                    color: AppColors.paleGray,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
