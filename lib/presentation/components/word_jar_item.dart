import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/config/constants/constants.dart';

class WordJarItem extends StatelessWidget {
  const WordJarItem({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onDelete,
    required this.onView,
  });

  final String firstText;
  final String secondText;
  final Function() onDelete;
  final Function() onView;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onView,
      child: SizedBox(
        height: 52.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyle.font14W500Normal.copyWith(
                        color: isDarkTheme ? AppColors.white : AppColors.darkGray,
                      ),
                      text: firstText,
                      children: [
                        TextSpan(
                          text: ' - $secondText',
                          style: AppTextStyle.font14W400Normal.copyWith(
                            color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: SizedBox(
                    height: 48.h,
                    width: 48.h,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onDelete,
                        borderRadius: BorderRadius.circular(24.r),
                        child: SvgPicture.asset(
                          Assets.icons.trash,
                          height: 24.h,
                          width: 24.h,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Divider(
                color: isDarkTheme ? AppColors.darkDivider : AppColors.borderWhite,
                height: 1,
                thickness: 0.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
