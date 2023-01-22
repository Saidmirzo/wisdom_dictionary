import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

abstract class AppTextStyle {
  const AppTextStyle._();

  static const String fontFamily = "Montserrat";

  static TextStyle font14W500Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 14.sp,
    color: AppColors.white,
  );

  static TextStyle font14W700Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 14.sp,
    color: AppColors.white,
  );

  static TextStyle font16W400Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 16.sp,
    color: AppColors.white,
  );

  static TextStyle font16W500Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 16.sp,
    color: AppColors.white,
  );

  static TextStyle font16W700Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 16.sp,
    color: AppColors.white,
  );

  static TextStyle font16W600Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 16.sp,
    color: AppColors.white,
  );

  static TextStyle font16W500Italic = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    fontSize: 16.sp,
    color: AppColors.white,
  );

  static TextStyle font14W400Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 14.sp,
    color: AppColors.white,
  );

  static TextStyle font14W400Italic = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    fontSize: 14.sp,
    color: AppColors.white,
  );

  static TextStyle font12W400Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12.sp,
    color: AppColors.white,
  );

  static TextStyle font12W500Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 12.sp,
    color: AppColors.white,
  );

  static TextStyle font28W600Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 28.sp,
    color: AppColors.white,
  );

  static TextStyle font18W500Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 18.sp,
    color: AppColors.white,
  );

  static TextStyle font17W400Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 17.sp,
    color: AppColors.white,
  );

  static TextStyle font17W500Normal = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 17.sp,
    color: AppColors.white,
  );

  // =========================== For Html texts ===================//

  static TextStyle font14W400ItalicHtml = TextStyle(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    fontSize: 14.sp,
    color: AppColors.paleGray,
  );

  static TextStyle font14W400NormalHtml = TextStyle(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 14.sp,
    color: AppColors.paleGray,
  );

  static TextStyle font12W400ItalicHtml = TextStyle(
    // fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    // fontSize: 12.sp,
    color: AppColors.paleGray,
  );

  static TextStyle font12W400NormalHtml = TextStyle(
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12.sp,
    color: AppColors.paleGray,
  );
}
