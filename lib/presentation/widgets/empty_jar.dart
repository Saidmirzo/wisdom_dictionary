import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';

class EmptyJar extends StatelessWidget {
  const EmptyJar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 70.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.images.dicEmpty),
            Padding(
              padding: EdgeInsets.only(top: 50.h, bottom: 16.h),
              child: Text(
                "no_entry".tr(),
                style: AppTextStyle.font28W600Normal.copyWith(color: AppColors.darkGray),
              ),
            ),
            Text(
              "no_entry_def".tr(),
              textAlign: TextAlign.center,
              style: AppTextStyle.font17W400Normal.copyWith(color: AppColors.paleGray.withOpacity(0.57)),
            )
          ],
        ),
      ),
    );
  }
}
