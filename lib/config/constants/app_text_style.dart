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

  static TextStyle font16W500Normal = const TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
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
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
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
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    fontSize: 12,
    color: AppColors.white,
  );
}
