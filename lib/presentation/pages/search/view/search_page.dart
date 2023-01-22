import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/components/search_clean_button.dart';
import 'package:wisdom/presentation/components/search_history_item.dart';
import 'package:wisdom/presentation/components/search_word_item.dart';
import 'package:wisdom/presentation/pages/search/viewmodel/search_page_viewmodel.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/assets.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/loading_widget.dart';

// ignore: must_be_immutable
class SearchPage extends ViewModelBuilderWidget<SearchPageViewModel> {
  SearchPage({super.key});

  @override
  void onViewModelReady(SearchPageViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, SearchPageViewModel viewModel, Widget? child) {
    // viewModel.init();
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        leadingIcon: Assets.icons.menu,
        onTap: () => ZoomDrawer.of(context)!.toggle(),
        isSearch: true,
        title: 'Search',
        onChange: (text) => viewModel.searchByWord(text),
      ),
      // body: const EmptyJar(),
      body: Column(
        children: [
          Visibility(
            visible: viewModel.recentList.isNotEmpty && viewModel.searchText.isEmpty,
            child: SearchCleanButton(
              onTap: () => viewModel.cleanHistory(),
            ),
          ),
          Visibility(
            visible: viewModel.recentList.isNotEmpty && viewModel.searchText.isEmpty,
            child: Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 130),
                physics: const BouncingScrollPhysics(),
                itemCount: viewModel.recentList.length,
                itemBuilder: (BuildContext context, int index) {
                  var itemRecent = viewModel.recentList[index];
                  return SearchHistoryItem(
                    firstText: itemRecent.word ?? "unknown",
                    secondText: itemRecent.wordClass ?? "",
                    onTap: () => viewModel.goOnDetail(itemRecent),
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: (viewModel.searchRepository.searchResultList.isNotEmpty || viewModel.searchText.isNotEmpty),
            child: (viewModel.isSuccess(tag: viewModel.searchTag) &&
                    viewModel.searchText.isNotEmpty &&
                    viewModel.searchRepository.searchResultList.isNotEmpty)
                ? Expanded(
              child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(bottom: 130),
                      physics: const BouncingScrollPhysics(),
                      itemCount: viewModel.searchRepository.searchResultList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var item = viewModel.searchRepository.searchResultList[index];
                        return SearchWordItem(
                          firstText: item.word ?? "unknown",
                          secondText: item.wordClasswordClass ?? "",
                          onTap: () => viewModel.goOnDetail(item),
                        );
                      },
                    ),
                )
                : SizedBox(height: 120.h, child: LoadingWidget()),
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
    return SearchPageViewModel(
        context: context,
        preferenceHelper: locator.get(),
        dbHelper: locator.get(),
        searchRepository: locator.get(),
        localViewModel: locator.get());
  }
}
