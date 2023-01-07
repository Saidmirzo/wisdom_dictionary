import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';

class SearchHistoryItem extends StatelessWidget {
  const SearchHistoryItem({
    super.key,
    required this.firstText,
    required this.secondText,
    required this.onTap,
  });

  final String firstText;
  final String secondText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap,
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
                  padding: const EdgeInsets.only(left: 34),
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.darkGray),
                      text: firstText,
                      children: [
                        TextSpan(
                            text: ' $secondText', style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.blue)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SizedBox(
                    height: 48.h,
                    width: 48.h,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onTap,
                        borderRadius: BorderRadius.circular(24),
                        child: SvgPicture.asset(
                          Assets.icons.arrowCircleRight,
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
              child: const Divider(
                color: AppColors.borderWhite,
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
