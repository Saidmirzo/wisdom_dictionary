import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_decoration.dart';
import '../../../../config/constants/app_text_style.dart';
import '../../../../config/constants/assets.dart';
import '../../../components/custom_banner.dart';
import '../../../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: InkWell(
            onTap: () => ZoomDrawer.of(context)!.toggle(),
            child: SvgPicture.asset(
              Assets.icons.menu,
              height: 24.h,
              width: 24.h,
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        centerTitle: true,
        title: Text('Wisdom Dictionary', style: AppTextStyle.font14W500Normal),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Container(
            height: 47.h,
            margin: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(23.5.r)),
            child: TextFormField(
              style: AppTextStyle.font14W400Normal.copyWith(color: AppColors.blue),
              cursorHeight: 18.h,
              decoration: InputDecoration(
                prefixIcon: SvgPicture.asset(
                  Assets.icons.searchText,
                  height: 18.h,
                  width: 18.h,
                  fit: BoxFit.scaleDown,
                ),
                hintText: 'Qidirish',
                border: InputBorder.none,
                hintStyle: AppTextStyle.font12W400Normal.copyWith(
                  color: AppColors.paleBlue.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 16.h, bottom: 60.h),
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            decoration: AppDecoration.bannerDecor,
            height: 165.h,
            child: Center(
              child: Text(
                'Reklama uchun yoki \n taklif uchun joy',
                style: AppTextStyle.font14W500Normal.copyWith(
                  color: AppColors.paleGray,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          CustomBanner(
              title: 'Grammar',
              child: Text(
                'Library',
                style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.darkGray),
              )),
          CustomBanner(
            title: 'Farqlar',
            child: RichText(
              text: TextSpan(
                style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.darkGray),
                text: 'lack (in) ',
                children: [
                  TextSpan(text: 'or', style: AppTextStyle.font16W500Italic.copyWith(color: AppColors.paleGray)),
                  const TextSpan(text: ' lack of'),
                ],
              ),
            ),
          ),
          CustomBanner(
            height: 197.h,
            title: 'Buni bilasizmi? ',
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Image(
                image: AssetImage(Assets.images.diamond),
              ),
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: const HomeBottomNavBar(),
    );
  }
}
