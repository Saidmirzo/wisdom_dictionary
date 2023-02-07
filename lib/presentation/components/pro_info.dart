import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constants/app_colors.dart';
import '../../config/constants/app_text_style.dart';

class ProInfo extends StatelessWidget {
  const ProInfo({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.accentLight,
            ),
          ),
          Expanded(
            child: Text(
              label,
              style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.paleBlue),
            ),
          ),
        ],
      ),
    );
  }
}
