import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/config/constants/constants.dart';

class CatalogItem extends StatelessWidget {
  const CatalogItem({
    super.key,
    required this.firstText,
    this.translateText,
    required this.onTap,
  });

  final String firstText;
  final String? translateText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        constraints: BoxConstraints(minHeight: 60.h),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              constraints: BoxConstraints(minHeight: 58.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 34.w, bottom: 10.h, top: 10.h, right: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        firstText,
                        style: AppTextStyle.font14W500Normal.copyWith(
                          color: isDarkTheme ? AppColors.white : AppColors.darkGray,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Visibility(
                        visible: (translateText ?? "").isNotEmpty,
                        child: Flexible(
                          child: Text(
                            translateText ?? "",
                            style: AppTextStyle.font12W400ItalicHtml.copyWith(color: AppColors.lightGray),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Divider(
                color: isDarkTheme ? AppColors.darkForm : AppColors.borderWhite,
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
