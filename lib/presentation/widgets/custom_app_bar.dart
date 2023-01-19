import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../config/constants/app_colors.dart';
import '../../config/constants/app_text_style.dart';
import '../../config/constants/assets.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.title,
    required this.onTap,
    this.isSearch = false,
    required this.leadingIcon,
    this.onChange,
  });

  final String title;
  final Function() onTap;
  final Function(String text)? onChange;
  final String leadingIcon;
  bool isSearch;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(isSearch ? 134.h : 86.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  TextEditingController controller = TextEditingController();
  bool hasText = false;

  @override
  void initState() {
    controller.addListener(() {
      if (widget.onChange != null) {
        if (controller.text.isNotEmpty) {
          hasText = true;
        } else {
          hasText = false;
        }
        setState(() {});
        widget.onChange!(controller.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blue,
      shadowColor: const Color(0xFF6D8DAD).withOpacity(0.15),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      leading: Padding(
        padding: EdgeInsets.only(
          left: 5.w,
          right: 5.w,
          top: 15.h,
        ),
        child: InkResponse(
          onTap: () => widget.onTap(),
          child: SvgPicture.asset(
            widget.leadingIcon,
            height: 24.h,
            width: 24.h,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(top: 15.h),
        child: Text(widget.title, style: AppTextStyle.font14W500Normal),
      ),
      bottom: widget.isSearch
          ? PreferredSize(
              preferredSize: Size.fromHeight(70.h),
              child: Container(
                height: 47.h,
                margin: EdgeInsets.all(14.r),
                decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(23.5.r)),
                child: TextField(
                  style: AppTextStyle.font14W400Normal.copyWith(color: AppColors.blue),
                  cursorHeight: 19.h,
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 8.0.w),
                      child: SvgPicture.asset(
                        Assets.icons.searchText,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    suffixIcon: Visibility(
                      visible: hasText,
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0.w),
                        child: InkResponse(
                          onTap: () {
                            controller.text = '';
                            setState(() {});
                          },
                          child: SvgPicture.asset(
                            Assets.icons.crossClose,
                            height: 10.h,
                            width: 10.h,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                    ),
                    hintText: 'Search',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14.h),
                    hintStyle: AppTextStyle.font14W400Normal.copyWith(
                      color: AppColors.paleBlue.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
