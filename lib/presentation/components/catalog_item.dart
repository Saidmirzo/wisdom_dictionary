import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';

class CatalogItem extends StatelessWidget {
  const CatalogItem({
    super.key,
    required this.firstText,
    required this.onTap,
  });

  final String firstText;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: SizedBox(
        height: 60.h,
        width: double.infinity,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 34.w, right: 78.w),
                child: Text(
                  firstText,
                  style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.darkGray, overflow: TextOverflow.fade),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: SizedBox(
                  height: 48.h,
                  width: 48.h,
                  child: SvgPicture.asset(
                    Assets.icons.arrowCircleRight,
                    height: 24.h,
                    width: 24.h,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: const Divider(
                  color: AppColors.borderWhite,
                  height: 1,
                  thickness: 0.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
