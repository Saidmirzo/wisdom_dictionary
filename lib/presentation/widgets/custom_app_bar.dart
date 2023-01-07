import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/constants/app_colors.dart';
import '../../config/constants/app_text_style.dart';
import '../../config/constants/assets.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, required this.title, required this.onTap, this.isSearch = false, required this.leadingIcon});

  final String title;
  final Function() onTap;
  final String leadingIcon;
  bool isSearch;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blue,
      shadowColor: const Color(0xFF6D8DAD).withOpacity(0.15),
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 5,
          right: 5,
          top: 15,
        ),
        child: InkWell(
          onTap: () => onTap(),
          child: SvgPicture.asset(
            leadingIcon,
            height: 24.h,
            width: 24.h,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text(title, style: AppTextStyle.font14W500Normal),
      ),
      bottom: isSearch
          ? PreferredSize(
              preferredSize: Size.fromHeight(70.h),
              child: Container(
                height: 47.h,
                margin: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(23.5.r)),
                child: TextFormField(
                  style: AppTextStyle.font14W400Normal.copyWith(color: AppColors.blue),
                  cursorHeight: 18.h,
                  decoration: InputDecoration(
                    prefixIcon: SvgPicture.asset(
                      Assets.icons.searchText,
                      height: 18.h,
                      width: 18.h,
                      fit: BoxFit.scaleDown,
                    ),
                    hintText: 'Qidirish',
                    border: InputBorder.none,
                    hintStyle: AppTextStyle.font12W400Normal.copyWith(
                      color: AppColors.paleBlue.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(isSearch ? 125 : 80);
}
