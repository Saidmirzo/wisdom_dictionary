import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/presentation/pages/spalsh/viewmodel/splash_viewmodel.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/assets.dart';

class SplashPage extends ViewModelBuilderWidget<SplashViewModel> {
  SplashPage({super.key});

  @override
  Widget builder(BuildContext context, SplashViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.blue,
      body: Align(
        heightFactor: 308.h,
        widthFactor: 82.w,
        child: SvgPicture.asset(Assets.icons.logoWhite),
      ),
    );
  }

  @override
  SplashViewModel viewModelBuilder(BuildContext context) {
    return SplashViewModel(context: context);
  }
}
