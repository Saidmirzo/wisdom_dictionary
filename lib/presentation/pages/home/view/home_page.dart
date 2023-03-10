import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/presentation/pages/home/viewmodel/home_viewmodel.dart';

import '../../../../config/constants/constants.dart';
import 'drawer_screen.dart';
import 'home_screen.dart';

// ignore: must_be_immutable
class HomePage extends ViewModelBuilderWidget<HomeViewModel> {
  HomePage({super.key});

  final drawerController = ZoomDrawerController();

  @override
  void onViewModelReady(HomeViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.getRandomDailyWords();
    viewModel.getWordBank();
    viewModel.checkStatus();
  }

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return ZoomDrawer(
      menuScreen: const DrawerScreen(),
      mainScreen: HomeScreen(),
      borderRadius: 30.r,
      showShadow: false,
      mainScreenTapClose: true,
      mainScreenScale: 0.2,
      angle: 0,
      menuBackgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
      slideWidth: MediaQuery.of(context).size.width * 0.75,
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) {
    return HomeViewModel(context: context);
  }
}
