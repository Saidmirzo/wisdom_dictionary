import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';

class SearchCleanButton extends StatelessWidget {
  const SearchCleanButton({
    super.key,
    required this.onTap,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: Text(
                  "recent_searches".tr(),
                  style: AppTextStyle.font18W500Normal
                      .copyWith(color: AppColors.blue),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: Container(
                  height: 32.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(21.r),
                      color: AppColors.blue),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () => onTap,
                        borderRadius: BorderRadius.circular(21.r),
                        child: Center(
                          child: Text(
                            "clear".tr(),
                            style: AppTextStyle.font14W500Normal,
                          ),
                        )),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
