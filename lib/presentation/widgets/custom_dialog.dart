import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/presentation/components/custom_oval_button.dart';
import '../../config/constants/app_colors.dart';
import '../../config/constants/app_text_style.dart';
import '../../config/constants/assets.dart';
import '../components/circular_icon_place.dart';

showCustomDialog({
  required BuildContext context,
  required String title,
  required Widget contentText,
  String? icon,
  Color? iconColor,
  Color? iconBackgroundColor,
  String? positive,
  String? negative,
  double? buttonHeight,
  bool dismissible = true,
  Function()? onPositiveTap,
  Function()? onNegativeTap,
}) {
  showDialog(
    context: context,
    barrierDismissible: dismissible,
    builder: (BuildContext context) => AlertDialog(
      titlePadding: EdgeInsets.only(top: 32.h, bottom: 8.h),
      contentPadding: EdgeInsets.only(bottom: 48.h, left: 24.w, right: 24.w),
      actionsPadding: EdgeInsets.only(bottom: 32.h, left: 24.w, right: 24.w),
      backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      alignment: Alignment.center,
      title: Column(
        children: [
          Visibility(
            visible: icon != null,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: CircularIconPlace(
                height: 58.h,
                iconColor: iconColor ?? AppColors.blue,
                icon: icon ?? Assets.icons.download,
                background: iconBackgroundColor ?? AppColors.borderWhite,
              ),
            ),
          ),
          Text(
            title,
            style: AppTextStyle.font16W600Normal.copyWith(color: isDarkTheme ? AppColors.white : AppColors.gray),
            textAlign: TextAlign.center,
          )
        ],
      ),
      content: contentText,
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Visibility(
              visible: negative != null,
              child: Expanded(
                child: CustomOvalButton(
                  onTap: onNegativeTap ??
                      () {
                        Navigator.pop(context);
                      },
                  height: 38.h,
                  label: negative ?? "Cancel",
                  textStyle: AppTextStyle.font14W500Normal,
                  isActive: false,
                ),
              ),
            ),
            Visibility(
              visible: !(negative == null || positive == null),
              child: SizedBox(
                width: 16.w,
              ),
            ),
            Visibility(
              visible: positive != null,
              child: Expanded(
                child: CustomOvalButton(
                  onTap: onPositiveTap ?? () {},
                  height: 38.h,
                  label: positive ?? "OK",
                  textStyle: AppTextStyle.font14W500Normal,
                  isActive: true,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
