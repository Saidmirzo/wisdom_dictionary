import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/presentation/pages/home/viewmodel/home_viewmodel.dart';

import '../../config/constants/assets.dart';
import '../components/navigation_button.dart';

class HomeBottomNavBar extends ViewModelWidget<HomeViewModel> {
  const HomeBottomNavBar({Key? key, required this.onTap}) : super(key: key);

  final Function(int index) onTap;

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return ValueListenableBuilder(
      valueListenable: viewModel.localViewModel.current_index,
      builder: (context, value, child) {
        return Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.r),
              color: isDarkTheme ? AppColors.darkBottomBar : AppColors.blue,
            ),
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            margin: const EdgeInsets.all(8),
            height: 60.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavButton(
                    isTabSelected: value == 0,
                    defIcon: Assets.icons.homeOutline,
                    filledIcon: Assets.icons.homeFilled,
                    callBack: () {
                      onTap(0);
                      viewModel.localViewModel.changePageIndex(0);
                    }),
                BottomNavButton(
                    isTabSelected: value == 1,
                    defIcon: Assets.icons.bookOutline,
                    filledIcon: Assets.icons.bookFilled,
                    callBack: () {
                      onTap(1);
                      viewModel.localViewModel.changePageIndex(1);
                    }),
                BottomNavButton(
                    isTabSelected: value == 2,
                    defIcon: Assets.icons.searchOutline,
                    filledIcon: Assets.icons.searchFilled,
                    callBack: () {
                      onTap(2);
                      viewModel.localViewModel.changePageIndex(2);
                    }),
                BottomNavButton(
                    isTabSelected: value == 3,
                    defIcon: Assets.icons.unitsOutline,
                    filledIcon: Assets.icons.unitsFilled,
                    callBack: () {
                      onTap(3);
                      viewModel.localViewModel.changePageIndex(3);
                    }),
                BottomNavButton(
                    isTabSelected: value == 4,
                    defIcon: Assets.icons.translateOutline,
                    filledIcon: Assets.icons.translateFilled,
                    callBack: () {
                      onTap(4);
                      viewModel.localViewModel.changePageIndex(4);
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
