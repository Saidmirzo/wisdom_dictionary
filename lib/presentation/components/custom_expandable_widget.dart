import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisdom/presentation/pages/word_detail/viewmodel/word_detail_page_viewmodel.dart';

import '../../config/constants/app_colors.dart';
import '../../config/constants/app_text_style.dart';
import '../../config/constants/assets.dart';

class CustomExpandableWidget extends StatefulWidget {
  const CustomExpandableWidget(
      {Key? key, required this.title, required this.body, required this.visible, this.containerColor, this.isExpanded, required this.viewModel})
      : super(key: key);

  final String title;
  final Widget body;
  final bool visible;
  final Color? containerColor;
  final bool? isExpanded;
  final WordDetailPageViewModel viewModel;

  @override
  State<CustomExpandableWidget> createState() => _CustomExpandableWidgetState();
}

class _CustomExpandableWidgetState extends State<CustomExpandableWidget> {

  late bool isExpanded = false;

  final ExpandableController expandableController = ExpandableController();

  @override
  void initState() {
    expandableController.value = widget.isExpanded ?? false;
    expandableController.addListener(() {
      setState(() {
        isExpanded = expandableController.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.visible
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              color: widget.containerColor ?? AppColors.lightBackground,
            ),
            margin: EdgeInsets.only(top: 15.h),
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    expandableController.value = !isExpanded;
                  },
                  child: SvgPicture.asset(
                    expandableController.value ? Assets.icons.expanded : Assets.icons.collapsed,
                    height: 20.h + widget.viewModel.fontSize!-16,
                    width: 20.h + widget.viewModel.fontSize!-16,
                  ),
                ),
                Flexible(
                  child: ExpandablePanel(
                    header: Padding(
                      padding: EdgeInsets.only(left: 10.w, top: 3.h),
                      child: Text(
                        widget.title,
                        style: AppTextStyle.font12W500Normal.copyWith(color: AppColors.darkGray, fontSize: widget.viewModel.fontSize! - 4),
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
