import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../config/constants/app_colors.dart';
import '../../config/constants/app_text_style.dart';
import '../../config/constants/assets.dart';

class CustomExpandableWidget extends StatefulWidget {
  const CustomExpandableWidget({
    Key? key,
    this.isExpanded = false,
    required this.title,
    required this.body,
    required this.visible,
  }) : super(key: key);

  final bool isExpanded;
  final String title;
  final Widget body;
  final bool visible;

  @override
  State<CustomExpandableWidget> createState() => _CustomExpandableWidgetState();
}

class _CustomExpandableWidgetState extends State<CustomExpandableWidget> {
  final ExpandableController expandableController = ExpandableController();

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;
    expandableController.addListener(() {
      setState(() {
        isExpanded = expandableController.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.visible
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: AppColors.lightBackground,
            ),
            margin: EdgeInsets.only(top: 15.h),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    isExpanded = !isExpanded;
                    expandableController.value = isExpanded;
                    setState(() {});
                  },
                  child: SvgPicture.asset(
                    expandableController.value ? Assets.icons.expanded : Assets.icons.collapsed,
                  ),
                ),
                Flexible(
                  child: ExpandablePanel(
                    header: Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 1.h),
                      child: Text(
                        widget.title,
                        style: AppTextStyle.font12W500Normal.copyWith(color: AppColors.darkGray),
                      ),
                    ),
                    collapsed: const SizedBox.shrink(),
                    controller: expandableController,
                    expanded: Padding(
                      padding: EdgeInsets.only(top: 15.h, bottom: 20.h),
                      child: widget.body,
                    ),
                    theme: const ExpandableThemeData(
                      hasIcon: false,
                      tapHeaderToExpand: true,
                      tapBodyToCollapse: true,
                      tapBodyToExpand: true,
                    ),
                  ),
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
