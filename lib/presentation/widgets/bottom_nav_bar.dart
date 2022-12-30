import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisdom/config/constants/app_colors.dart';

import '../../config/constants/assets.dart';
import '../components/navigation_button.dart';

class HomeBottomNavBar extends StatefulWidget {
  const HomeBottomNavBar({Key? key}) : super(key: key);

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  int _currentTab = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
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
              isTabSelected: _currentTab == 0,
              defIcon: Assets.icons.homeOutline,
              filledIcon: Assets.icons.homeFilled,
              callBack: () {
                setState(() {
                  _currentTab = 0;
                });
              }),
          BottomNavButton(
              isTabSelected: _currentTab == 1,
              defIcon: Assets.icons.bookOutline,
              filledIcon: Assets.icons.bookFilled,
              callBack: () {
                setState(() {
                  _currentTab = 1;
                });
              }),
          BottomNavButton(
              isTabSelected: _currentTab == 2,
              defIcon: Assets.icons.searchOutline,
              filledIcon: Assets.icons.searchFilled,
              callBack: () {
                setState(() {
                  _currentTab = 2;
                });
              }),
          BottomNavButton(
              isTabSelected: _currentTab == 3,
              defIcon: Assets.icons.unitsOutline,
              filledIcon: Assets.icons.unitsFilled,
              callBack: () {
                setState(() {
                  _currentTab = 3;
                });
              }),
          BottomNavButton(
              isTabSelected: _currentTab == 4,
              defIcon: Assets.icons.translateOutline,
              filledIcon: Assets.icons.translateFilled,
              callBack: () {
                setState(() {
                  _currentTab = 4;
                });
              }),
        ],
      ),
    );
  }
}
