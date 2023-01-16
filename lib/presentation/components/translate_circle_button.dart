import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/constants/app_colors.dart';
import '../../config/constants/assets.dart';

class TranslateCircleButton extends StatelessWidget {
  const TranslateCircleButton(
      {super.key, required this.onTap, required this.iconAssets});

  final Function() onTap;
  final String iconAssets;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(18.5.r),
        onTap: () => onTap,
        child: Container(
          height: 37.h,
          width: 37.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.5.r),
            color: AppColors.blue.withOpacity(0.1),
          ),
          child: SvgPicture.asset(
            iconAssets,
            height: 19.h,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
