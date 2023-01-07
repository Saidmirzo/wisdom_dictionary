import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';

class CatalogButton extends StatelessWidget {
  const CatalogButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: AppDecoration.bannerDecor.copyWith(borderRadius: BorderRadius.circular(30.r), color: AppColors.blue),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => onTap(),
          child: Container(
            height: 52.h,
            padding: const EdgeInsets.only(left: 44),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: AppTextStyle.font17W500Normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
