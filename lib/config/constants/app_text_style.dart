import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppTextStyle {
  const AppTextStyle._();

  static const String fontFamily = "Montserrat";

  static TextStyle font14W500Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    color: AppColors.white,
  );

  static TextStyle font16W400Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    color: AppColors.white,
  );

  static TextStyle font16W500Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    color: AppColors.white,
  );

  static TextStyle font16W600Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 16,
    color: AppColors.white,
  );

  static TextStyle font16W500Italic = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.italic,
    fontSize: 16,
    color: AppColors.white,
  );

  static TextStyle font14W400Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    color: AppColors.white,
  );

  static TextStyle font14W400Italic = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
    fontSize: 14,
    color: AppColors.white,
  );

  static TextStyle font12W400Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    color: AppColors.white,
  );

  static TextStyle font12W500Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    color: AppColors.white,
  );

  static TextStyle font28W600Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    fontSize: 28,
    color: AppColors.white,
  );

  static TextStyle font18W500Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    color: AppColors.white,
  );

  static TextStyle font17W400Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 17,
    color: AppColors.white,
  );

  static TextStyle font17W500Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 17,
    color: AppColors.white,
  );
}
