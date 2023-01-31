import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class AppDecoration {
  static BoxDecoration bannerDecor =
      BoxDecoration(borderRadius: BorderRadius.circular(18.r), color: AppColors.white, boxShadow: [
    BoxShadow(
      offset: const Offset(4, 14),
      blurRadius: 30,
      color: const Color(0xFF6D8DAD).withOpacity(0.15),
    ),
  ]);

  static BoxDecoration bannerDarkDecor = BoxDecoration(
    borderRadius: BorderRadius.circular(18.r),
    color: AppColors.darkForm,
  );

  static BoxDecoration activeButtonDecor = BoxDecoration(
    borderRadius: BorderRadius.circular(40.r),
    color: AppColors.blue,
  );

  static BoxDecoration inactiveButtonDecor = BoxDecoration(
    border: Border.fromBorderSide(BorderSide(color: AppColors.borderWhite, width: 1.6.w)),
    borderRadius: BorderRadius.circular(40.r),
    color: AppColors.white,
  );
}
