import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/presentation/pages/home/viewmodel/home_viewmodel.dart';

import 'drawer_screen.dart';
import 'home_screen.dart';

class HomePage extends ViewModelBuilderWidget<HomeViewModel> {
  HomePage({super.key});

  final _drawerController = ZoomDrawerController();

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return ZoomDrawer(
      menuScreen: const DrawerScreen(),
      mainScreen: const HomeScreen(),
      borderRadius: 30,
      showShadow: true,
      angle: 0,
      mainScreenScale: 0.2,
      slideWidth: 210.w,
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) {
    return HomeViewModel(context: context);
  }
}
