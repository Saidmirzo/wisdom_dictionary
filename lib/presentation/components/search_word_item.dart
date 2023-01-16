import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';

class SearchWordItem extends StatelessWidget {
  const SearchWordItem({
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 50.h,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 34.w),
                  child: RichText(
                    text: TextSpan(
                      style: AppTextStyle.font14W500Normal
                          .copyWith(color: AppColors.darkGray),
                      text: firstText,
                      children: [
                        TextSpan(
                            text: ' $secondText',
                            style: AppTextStyle.font14W500Normal
                                .copyWith(color: AppColors.blue)),
                      ],
                    ),
                  ),
                ),
              ),
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
