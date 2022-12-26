import 'package:flutter/material.dart';
import 'package:morningmagic/config/constants/app_colors.dart';

abstract class AppTextStyle {
  const AppTextStyle._();

  static const String fontFamily = "Roboto";

  static TextStyle h1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 28,
    color: AppColors.metalColor.shade100
  );

}