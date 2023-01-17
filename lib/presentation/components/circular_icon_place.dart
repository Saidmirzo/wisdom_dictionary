import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircularIconPlace extends StatelessWidget {
  const CircularIconPlace({
    Key? key,
    required this.height,
    required this.icon,
    required this.iconColor,
    required this.background,
    this.iconHeight,
    this.onTap,
  }) : super(key: key);

  final double height;
  final String icon;
  final double? iconHeight;
  final Color iconColor;
  final Color background;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(height / 2),
      onTap: onTap ?? () {},
      child: CircleAvatar(
        radius: height / 2,
        backgroundColor: background,
        child: SvgPicture.asset(
          icon,
          color: iconColor,
          height: iconHeight ?? 32,
        ),
      ),
    );
  }
}
