import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/presentation/pages/home/viewmodel/home_viewmodel.dart';

import '../../config/constants/assets.dart';
import '../components/navigation_button.dart';

class HomeBottomNavBar extends ViewModelWidget<HomeViewModel> {
  HomeBottomNavBar({Key? key, required this.onTap}) : super(key: key);

  final Function(int index) onTap;

  @override
  Widget build(BuildContext context, HomeViewModel viewModel) {
    return ValueListenableBuilder(
      valueListenable: viewModel.localViewModel.currentIndex,
      builder: (context, value, child) {
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
                    isTabSelected: value == 0,
                    defIcon: Assets.icons.homeOutline,
                    filledIcon: Assets.icons.homeFilled,
                    callBack: () {
                      onTap(0);
                      viewModel.localViewModel.changePageIndex(0);
                    }),
                Material(
                  color: AppColors.blue,
                  child: AddToCartIcon(
                    badgeOptions: const BadgeOptions(
                      active: true,
                      fontSize: 12,
                      backgroundColor: AppColors.accentLight,
                      foregroundColor: AppColors.white
                    ),
                    key: viewModel.localViewModel.cartKey,
                    icon: BottomNavButton(
                        isTabSelected: value == 1,
                        defIcon: Assets.icons.bookOutline,
                        filledIcon: Assets.icons.bookFilled,
                        callBack: () {
                          onTap(1);
                          viewModel.localViewModel.changePageIndex(1);
                        }),
                  ),
                ),
                // ValueListenableBuilder(
                //   valueListenable: viewModel.localViewModel.badgeCount,
                //   builder: (BuildContext context, value, Widget? child) {
                //     return badge.Badge(
                //       badgeContent: Text(
                //         viewModel.localViewModel.badgeCount.value.toString(),
                //         style: AppTextStyle.font12W400Normal.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w600),
                //       ),
                //       ignorePointer: true,
                //       position: badge.BadgePosition.topEnd(top: 1, end: 1),
                //       child: ,
                //     );
                //   },
                // ),
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
                      viewModel.localViewModel.isFinal = false;
                      viewModel.localViewModel.isTitle = false;
                      viewModel.localViewModel.isSubSub = false;
                      viewModel.localViewModel.subId = -1;
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
