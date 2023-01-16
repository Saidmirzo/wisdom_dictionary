import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';

class CustomBanner extends StatelessWidget {
  CustomBanner({
    super.key,
    required this.title,
    required this.child,
    this.height,
    this.isInkWellEnable = false,
    this.onTap,
    this.contentPadding = const EdgeInsets.all(12),
  });

  final Widget child;
  final String title;
  final double? height;
  final bool isInkWellEnable;
  final Function()? onTap;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: double.maxFinite,
                decoration: AppDecoration.bannerDecor,
                child: isInkWellEnable
                    ? Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18.r),
                          onTap: () => onTap!() ?? () {},
                          child: Padding(
                            padding: contentPadding,
                            child: child,
                          ),
                        ),
                      )
                    : Padding(
                        padding: contentPadding,
                        child: child,
                      ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 23.h,
              width: 181.w,
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(11.5.r),
              ),
              child: Center(
                child: Text(
                  title,
                  style: AppTextStyle.font12W500Normal,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
