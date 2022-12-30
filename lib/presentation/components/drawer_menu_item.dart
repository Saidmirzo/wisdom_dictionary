import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({super.key, required this.title, required this.imgAssets, required this.onTap});

  final String imgAssets;
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: SizedBox(
            height: 48.h,
            width: 246.w,
            child: Padding(
              padding: const EdgeInsets.only(left: 36),
              child: Row(
                children: [
                  SvgPicture.asset(
                    imgAssets,
                    height: 24.h,
                    width: 24.w,
                    fit: BoxFit.scaleDown,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 12.w),
                    child: Text(
                      title,
                      style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.blue),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
