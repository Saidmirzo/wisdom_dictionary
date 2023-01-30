import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';

class Locked extends StatelessWidget {
  const Locked({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      top: 0,
      right: 0,
      left: 0,
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        margin: EdgeInsets.only(top: 16.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          color: AppColors.borderWhite.withOpacity(0.8),
        ),
        child: TextButton.icon(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.r))),
          ),
          icon: const Icon(
            Icons.lock_outline_rounded,
            color: AppColors.blue,
          ),
          onPressed: () {},
          label: Text(
            "subscribe_plan".tr(),
            style: AppTextStyle.font14W500Normal.copyWith(
              color: AppColors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

//
