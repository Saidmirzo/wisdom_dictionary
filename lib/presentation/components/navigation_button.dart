import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavButton extends StatelessWidget {
  const BottomNavButton({
    Key? key,
    required this.isTabSelected,
    required this.defIcon,
    this.filledIcon,
    required this.callBack,
  }) : super(key: key);

  final bool isTabSelected;
  final String defIcon;
  final String? filledIcon;
  final Function() callBack;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: callBack,
        child: Container(
          height: 50.h,
          width: 50.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: SvgPicture.asset(
            filledIcon != null
                ? isTabSelected
                    ? filledIcon!
                    : defIcon
                : defIcon,
            height: 24,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
