import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/presentation/components/search_clean_button.dart';
import 'package:wisdom/presentation/components/search_history_item.dart';
import 'package:wisdom/presentation/components/search_word_item.dart';
import 'package:wisdom/presentation/pages/search/viewmodel/search_page_viewmodel.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/assets.dart';
import '../../../../config/constants/constants.dart';
import '../../../widgets/custom_app_bar.dart';

// ignore: must_be_immutable
class SearchPage extends ViewModelBuilderWidget<SearchPageViewModel> {
  SearchPage({super.key});

  @override
  Widget builder(BuildContext context, SearchPageViewModel viewModel, Widget? child) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: CustomAppBar(
        leadingIcon: Assets.icons.menu,
        onTap: () => ZoomDrawer.of(context)!.toggle(),
        isSearch: true,
        title: "search_page".tr(),
        onChange: (text) => viewModel.searchByWord(text),
      ),
      // body: const EmptyJar(),
      body: Column(
        children: [
          SearchCleanButton(onTap: () {}),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 70),
              physics: const BouncingScrollPhysics(),
              children: [
                SearchWordItem(firstText: 'love', secondText: 'noun', onTap: () {}),
                SearchWordItem(firstText: 'love', secondText: 'verb', onTap: () {}),
                SearchWordItem(firstText: 'help', secondText: 'verb', onTap: () {}),
                SearchWordItem(firstText: 'cat', secondText: 'noun', onTap: () {}),
                SearchWordItem(firstText: 'dictionary', secondText: 'noun', onTap: () {}),
                SearchWordItem(firstText: 'fast', secondText: 'adj', onTap: () {}),
                SearchWordItem(firstText: 'love', secondText: 'verb', onTap: () {}),
                SearchHistoryItem(firstText: 'fast', secondText: 'adj', onTap: () {}),
                SearchHistoryItem(firstText: 'fast', secondText: 'adj', onTap: () {}),
                SearchHistoryItem(firstText: 'fast', secondText: 'adj', onTap: () {}),
                SearchHistoryItem(firstText: 'fast', secondText: 'adj', onTap: () {}),
                SearchHistoryItem(firstText: 'fast', secondText: 'adj', onTap: () {}),
              ],
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 65),
        decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(26.r)),
        height: 52.h,
        width: 52.h,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(26.r),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(
                Assets.icons.changeLang,
                height: 20.h,
                color: AppColors.white,
                fit: BoxFit.scaleDown,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  @override
  SearchPageViewModel viewModelBuilder(BuildContext context) {
    return SearchPageViewModel(context: context);
  }
}
