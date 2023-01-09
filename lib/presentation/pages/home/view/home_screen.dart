import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/presentation/pages/exercise/view/exercise_page.dart';
import 'package:wisdom/presentation/pages/google_translator/view/google_translator_page.dart';
import 'package:wisdom/presentation/pages/home/viewmodel/home_viewmodel.dart';
import 'package:wisdom/presentation/pages/search/view/search_page.dart';
import 'package:wisdom/presentation/pages/catalogs/view/catalogs_page.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_decoration.dart';
import '../../../../config/constants/app_text_style.dart';
import '../../../../config/constants/assets.dart';
import '../../../components/custom_banner.dart';
import '../../../widgets/bottom_nav_bar.dart';
import '../../../widgets/custom_app_bar.dart';

class HomeScreen extends ViewModelWidget<HomeViewModel> {
  HomeScreen({super.key});

  PageController pageController = PageController();
  late final List<Widget> pages = [
    const Home(),
    ExercisePage(),
    SearchPage(),
    CatalogsPage(),
    GoogleTranslatorPage(),
  ];

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Stack(
      children: [
        PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          children: pages,
          onPageChanged: (index) {},
        ),
        HomeBottomNavBar(
          onTap: ((index) {
            pageController.jumpToPage(index);
          }),
        ),
      ],
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        leadingIcon: Assets.icons.menu,
        onTap: () => ZoomDrawer.of(context)!.toggle(),
        isSearch: true,
        title: 'Wisdom Dictionary',
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 16.h, bottom: 70.h),
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
            isInkWellEnable: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 25),
            onTap: () {},
            child: Center(
              child: Text(
                'Library',
                style: AppTextStyle.font16W500Normal.copyWith(color: AppColors.darkGray),
              ),
            ),
          ),
          CustomBanner(
            title: 'Farqlar',
            isInkWellEnable: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 25),
            onTap: () {},
            child: Center(
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
          ),
          CustomBanner(
            contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            title: 'Buni bilasizmi? ',
            onTap: () {},
            isInkWellEnable: true,
            child: Center(
              child: Image(
                image: AssetImage(Assets.images.diamond),
              ),
            ),
          ),
        ],
      ),
      // extendBody: true,
      // bottomNavigationBar: const HomeBottomNavBar(),
    );
  }
}
