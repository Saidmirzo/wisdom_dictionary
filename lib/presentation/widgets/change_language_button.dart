import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wisdom/presentation/pages/search/viewmodel/search_page_viewmodel.dart';

import '../../config/constants/app_colors.dart';
import '../../config/constants/assets.dart';

class ChangeLanguageButton extends StatefulWidget {
  ChangeLanguageButton(this.viewModel, {super.key});

  SearchPageViewModel viewModel;

  @override
  State<ChangeLanguageButton> createState() => _ChangeLanguageButtonState();
}

class _ChangeLanguageButtonState extends State<ChangeLanguageButton> with SingleTickerProviderStateMixin {
  double turn = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.h ,right: 10.w),
      child: AnimatedRotation(
        turns: turn,
        duration: const Duration(milliseconds: 500),
        onEnd: () {
          widget.viewModel.setSearchLanguageMode();
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(26.r)),
          height: 52.h,
          width: 52.h,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  if (turn == 0) {
                    turn += 1;
                  } else {
                    turn -= 1;
                  }
                });
              },
              borderRadius: BorderRadius.circular(26.r),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset(
                  widget.viewModel.searchLangMode == 'en' ? Assets.icons.enToUz : Assets.icons.uzToEn,
                  height: 20.h,
                  color: AppColors.white,
                  fit: BoxFit.scaleDown,
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
