import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:wisdom/config/constants/constants.dart';

import '../../config/constants/app_colors.dart';
import '../../config/constants/app_text_style.dart';

class CustomNumberPicker extends StatelessWidget {
  const CustomNumberPicker({
    super.key,
    required this.currentValue,
    required this.onChange,
    required this.minValue,
    required this.maxValue,
    required this.zeroPad,
    this.infiniteLoop = false,
  });

  final int currentValue;
  final Function(int value) onChange;
  final int minValue;
  final int maxValue;
  final bool zeroPad;
  final bool infiniteLoop;

// Custom Number Picker for Setting page
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 50.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(33.r),
        color: const Color(0xFFECF2FF),
        gradient: LinearGradient(
          colors: isDarkTheme
              ? [
                  const Color(0xFF0063A4).withOpacity(0.38),
                  const Color(0xFF0063A4),
                  const Color(0xFF0063A4).withOpacity(0.38),
                ]
              : [
                  const Color(0xFFECF2FF).withOpacity(0.38),
                  const Color(0xFFECF2FF),
                  const Color(0xFFECF2FF).withOpacity(0.38),
                ],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: NumberPicker(
              value: currentValue,
              itemHeight: 50.h,
              minValue: minValue,
              maxValue: maxValue,
              infiniteLoop: infiniteLoop,
              textStyle: AppTextStyle.font14W500Normal
                  .copyWith(color: isDarkTheme ? AppColors.darkGray : AppColors.lightGray),
              selectedTextStyle: AppTextStyle.font14W500Normal.copyWith(
                  color: isDarkTheme ? AppColors.white : AppColors.darkGray, fontWeight: FontWeight.w600),
              zeroPad: zeroPad,
              onChanged: (value) => onChange(value),
            ),
          NumberPicker(
            value: currentValue,
            minValue: minValue,
            maxValue: maxValue,
            infiniteLoop: infiniteLoop,
            textStyle:
                AppTextStyle.font14W500Normal.copyWith(color: isDarkTheme ? AppColors.darkGray : AppColors.lightGray),
            selectedTextStyle: AppTextStyle.font14W500Normal
                .copyWith(color: isDarkTheme ? AppColors.white : AppColors.darkGray, fontWeight: FontWeight.w600),
            zeroPad: zeroPad,
            onChanged: (value) => onChange(value),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Divider(
                color: isDarkTheme ? AppColors.white.withOpacity(.3) : AppColors.blue,
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              Divider(
                color: isDarkTheme ? AppColors.white.withOpacity(.3) : AppColors.blue,
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              )
            ],
          ),
        ],
      ),
    );
  }
}
