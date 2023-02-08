import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/constants.dart';

class SearchWordItem extends StatelessWidget {
  const SearchWordItem({
    super.key,
    required this.firstText,
    required this.secondText,
    this.thirdText,
    required this.onTap,
  });

  final String firstText;
  final String secondText;
  final String? thirdText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: AppTextStyle.font14W500Normal.copyWith(color:  isDarkTheme ? AppColors.white : AppColors.darkGray),
                          text: firstText,
                          children: [
                            TextSpan(
                                text: '   $secondText',
                                style: AppTextStyle.font14W500Normal.copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.blue)),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: (thirdText??"").isNotEmpty,
                        child: Text(
                          thirdText ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.font12W500Normal.copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.blue),
                        ),
                      ),
                    ],
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
