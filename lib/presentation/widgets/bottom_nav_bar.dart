import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/presentation/pages/home/viewmodel/home_viewmodel.dart';

import '../../config/constants/assets.dart';
import '../components/navigation_button.dart';

class HomeBottomNavBar extends ViewModelWidget<HomeViewModel> {
  HomeBottomNavBar({Key? key, required this.onTap}) : super(key: key);

  final Function(int index) onTap;

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: AppColors.blue,
        ),
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        margin: const EdgeInsets.all(8),
        height: 60.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BottomNavButton(
                isTabSelected: viewModel.current_index == 0,
                defIcon: Assets.icons.homeOutline,
                filledIcon: Assets.icons.homeFilled,
                callBack: () {
                  onTap(0);
                  viewModel.changeIndex(0);
                }),
            BottomNavButton(
                isTabSelected: viewModel.current_index == 1,
                defIcon: Assets.icons.bookOutline,
                filledIcon: Assets.icons.bookFilled,
                callBack: () {
                  onTap(1);
                  viewModel.changeIndex(1);
                }),
            BottomNavButton(
                isTabSelected: viewModel.current_index == 2,
                defIcon: Assets.icons.searchOutline,
                filledIcon: Assets.icons.searchFilled,
                callBack: () {
                  onTap(2);
                  viewModel.changeIndex(2);
                }),
            BottomNavButton(
                isTabSelected: viewModel.current_index == 3,
                defIcon: Assets.icons.unitsOutline,
                filledIcon: Assets.icons.unitsFilled,
                callBack: () {
                  onTap(3);
                  viewModel.changeIndex(3);
                }),
            BottomNavButton(
                isTabSelected: viewModel.current_index == 4,
                defIcon: Assets.icons.translateOutline,
                filledIcon: Assets.icons.translateFilled,
                callBack: () {
                  onTap(4);
                  viewModel.changeIndex(4);
                }),
          ],
        ),
      ),
    );
  }
}
