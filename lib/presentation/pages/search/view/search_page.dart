import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/components/search_clean_button.dart';
import 'package:wisdom/presentation/components/search_history_item.dart';
import 'package:wisdom/presentation/components/search_word_item.dart';
import 'package:wisdom/presentation/pages/search/viewmodel/search_page_viewmodel.dart';
import 'package:wisdom/presentation/widgets/change_language_button.dart';

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
    return WillPopScope(
      onWillPop: () => viewModel.goBackToMain(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: AppColors.lightBackground,
        appBar: CustomAppBar(
          leadingIcon: Assets.icons.menu,
          onTap: () => ZoomDrawer.of(context)!.toggle(),
          isSearch: true,
          focus: true,
          focusNode: viewModel.localViewModel.focusNode,
          title: 'Search',
          onChange: (text) => viewModel.searchByWord(text),
        ),
        body: Column(
          children: [
            //Clean  button
            Visibility(
              visible: ((viewModel.recentList.isNotEmpty && viewModel.searchLangMode == 'en') ||
                      (viewModel.recentListUz.isNotEmpty && viewModel.searchLangMode == 'uz')) &&
                  viewModel.searchText.isEmpty,
              child: SearchCleanButton(
                onTap: () => viewModel.cleanHistory(),
              ),
            ),
            // Recent searched lists for english words
            Visibility(
              visible:
                  viewModel.recentList.isNotEmpty && viewModel.searchText.isEmpty && viewModel.searchLangMode == 'en',
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
              visible: ((viewModel.searchText.isNotEmpty) && viewModel.searchLangMode == 'en'),
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
                  : SizedBox(height: 120.h, child: const LoadingWidget()),
            ),
            // Recent searched lists for Uzbek words
            Visibility(
              visible:
                  viewModel.recentListUz.isNotEmpty && viewModel.searchText.isEmpty && viewModel.searchLangMode == 'uz',
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 130),
                  physics: const BouncingScrollPhysics(),
                  itemCount: viewModel.recentListUz.length,
                  itemBuilder: (BuildContext context, int index) {
                    var itemRecent = viewModel.recentListUz[index];
                    return SearchHistoryItem(
                      firstText: itemRecent.word ?? "unknown",
                      secondText: itemRecent.wordClass ?? "",
                      thirdText: "just same  words appear here",
                      onTap: () {},
                    );
                  },
                ),
              ),
            ),
            Visibility(
              visible: ((viewModel.searchText.isNotEmpty) && viewModel.searchLangMode == 'uz'),
              child: (viewModel.isSuccess(tag: viewModel.searchTag) &&
                      viewModel.searchText.isNotEmpty &&
                      viewModel.searchRepository.searchResultUzList.isNotEmpty)
                  ? Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 130),
                        physics: const BouncingScrollPhysics(),
                        itemCount: viewModel.searchRepository.searchResultUzList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var item = viewModel.searchRepository.searchResultUzList[index];
                          return SearchWordItem(
                            firstText: item.word ?? "unknown",
                            secondText: item.wordClass ?? "",
                            thirdText: item.same != null && item.same!.isNotEmpty ? item.same.toString() : "",
                            onTap: () {},
                          );
                        },
                      ),
                    )
                  : SizedBox(height: 120.h, child: const LoadingWidget()),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
        floatingActionButton: ChangeLanguageButton(viewModel),
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
