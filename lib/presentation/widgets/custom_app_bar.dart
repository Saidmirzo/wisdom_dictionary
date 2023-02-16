import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import '../../config/constants/app_colors.dart';
import '../../config/constants/app_text_style.dart';
import '../../config/constants/assets.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar(
      {super.key,
      required this.title,
      required this.onTap,
      this.isSearch = false,
      this.isLeading = true,
      this.isTitle = true,
      required this.leadingIcon,
      this.onChange,
      this.focus = false,
      this.focusNode});

  final String title;
  final Function() onTap;
  final Function(String text)? onChange;
  final String leadingIcon;
  bool isSearch;
  bool isLeading;
  bool isTitle;
  bool focus;
  FocusNode? focusNode;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(isTitle
      ? isSearch
          ? 134.h
          : 75.h
      : 75.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  TextEditingController controller = TextEditingController();
  bool hasText = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var localViewModel = locator<LocalViewModel>();
    if (localViewModel.searchingText.isNotEmpty) {
      controller.text = localViewModel.searchingText;
      onChanged(localViewModel.searchingText);
      localViewModel.searchingText = "";
    }
    if (localViewModel.lastSearchedText.isNotEmpty) {
      controller.text = localViewModel.lastSearchedText;
      onChanged(localViewModel.lastSearchedText);
      localViewModel.lastSearchedText = "";
    }
    return AppBar(
      backgroundColor: (isDarkTheme ? AppColors.darkForm : AppColors.blue).withOpacity(0.95),
      shadowColor: isDarkTheme ? null : const Color(0xFF6D8DAD).withOpacity(0.15),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      leading: widget.isLeading
          ? Padding(
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
            )
          : null,
      centerTitle: true,
      title: widget.isTitle
          ? Padding(
              padding: EdgeInsets.only(top: 15.h),
              child: Text(widget.title, style: AppTextStyle.font14W500Normal),
            )
          : null,
      bottom: widget.isSearch
          ? PreferredSize(
              preferredSize: Size.fromHeight(50.h),
              child: Container(
                height: 47.h,
                margin: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                    color: (isDarkTheme ? AppColors.darkBackground : AppColors.white).withOpacity(0.95),
                    borderRadius: BorderRadius.circular(23.5.r)),
                child: TextField(
                  autofocus: widget.focus,
                  focusNode: widget.focusNode,
                  style: AppTextStyle.font14W400Normal.copyWith(color: AppColors.blue),
                  cursorHeight: 19.h,
                  controller: controller,
                  onChanged: (value) {
                    onChanged(value);
                  },
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
                            controller.clear();
                            onChanged("");
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
                    hintText: 'search_hint'.tr(),
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

  onChanged(String text) {
    if (controller.text.isEmpty) {
      hasText = false;
    } else {
      hasText = true;
    }
    setState(() {});
    if (widget.onChange != null) {
      widget.onChange!(text);
    }
  }
}
