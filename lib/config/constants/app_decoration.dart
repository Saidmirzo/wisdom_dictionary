import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class AppDecoration {
  static BoxDecoration bannerDecor =
      BoxDecoration(borderRadius: BorderRadius.circular(18.r), color: AppColors.white, boxShadow: [
    BoxShadow(
      offset: const Offset(4, 14),
      blurRadius: 30,
      color: const Color(0xFF6D8DAD).withOpacity(0.15),
    ),
  ]);
}
