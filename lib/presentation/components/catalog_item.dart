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
        height: 70.h,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 34),
                    child: Text(
                      firstText,
                      style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.darkGray),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
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
                  )
                ],
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
