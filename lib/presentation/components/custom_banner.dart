import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({super.key, required this.title, required this.child, this.height});

  final Widget child;
  final String title;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Stack(
        children: [
          Container(
            height: height ?? 81.h,
            margin: const EdgeInsets.only(top: 12),
            decoration: AppDecoration.bannerDecor,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(18.r),
                onTap: () {},
                child: Center(child: child),
              ),
            ),
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
