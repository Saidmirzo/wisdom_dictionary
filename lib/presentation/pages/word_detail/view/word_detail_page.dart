import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/components/parent_widget.dart';
import 'package:wisdom/presentation/pages/word_detail/viewmodel/word_detail_page_viewmodel.dart';
import 'package:selectable/selectable.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_decoration.dart';
import '../../../../config/constants/assets.dart';
import '../../../../config/constants/urls.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/loading_widget.dart';

class WordDetailPage extends ViewModelBuilderWidget<WordDetailPageViewModel> {
  WordDetailPage({super.key});

  SelectableController textSelectionControls = SelectableController();

  @override
  void onViewModelReady(WordDetailPageViewModel viewModel) {
    viewModel.init();
    FocusScopeNode currentfocus = FocusScope.of(viewModel.context!);
    if (!currentfocus.hasPrimaryFocus) {
      currentfocus.unfocus();
    }
    super.onViewModelReady(viewModel);
  }

  @override
  void onDestroy(WordDetailPageViewModel model) {
    model.getFirstPhrase = true;
    super.onDestroy(model);
  }

  @override
  Widget builder(BuildContext context, WordDetailPageViewModel viewModel, Widget? child) {
    GlobalKey globalKey = GlobalKey();
    return Selectable(
      selectionController: textSelectionControls,
      popupMenuItems: [
        SelectableMenuItem(
            title: "Search",
            isEnabled: (controller) => controller!.isTextSelected,
            icon: Icons.search_rounded,
            handler: (controller) {
              if (controller != null && (controller.getSelection()!.text ?? "").isNotEmpty) {
                viewModel.localViewModel.goByLink(controller.getSelection()!.text ?? "");
              }
              return true;
            }),
        SelectableMenuItem(type: SelectableMenuItemType.copy, icon: Icons.copy_outlined),
        SelectableMenuItem(
            title: "Share",
            isEnabled: (controller) => controller!.isTextSelected,
            icon: Icons.share_rounded,
            handler: (controller) {
              if (controller != null && (controller.getSelection()!.text ?? "").isNotEmpty) {
                viewModel.localViewModel.shareWord(controller.getSelection()!.text!);
              }
              return true;
            }),
      ],
      child: WillPopScope(
        onWillPop: () async {
          if(textSelectionControls.isTextSelected){
            textSelectionControls.deselect();
          } else {
            viewModel.goBackToSearch();
          }
          return false;
        },
        child: Scaffold(
          backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
          resizeToAvoidBottomInset: true,
          appBar: CustomAppBar(
            title: viewModel.localViewModel.wordDetailModel.word ?? "unknown",
            onTap: () => viewModel.goBackToSearch(),
            leadingIcon: Assets.icons.arrowLeft,
          ),
          body: viewModel.isSuccess(tag: viewModel.initTag)
              ? (viewModel.wordEntityRepository.requiredWordWithAllModel.word!.linkWord != null &&
                      viewModel.wordEntityRepository.requiredWordWithAllModel.word!.linkWord!.isNotEmpty)
                  // Link words
                  ? ListView(
                      padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w, bottom: 70.h),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Container(
                          decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 28.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 25.w),
                                    child: Text(
                                      viewModel.wordEntityRepository.requiredWordWithAllModel.word!.word ?? "unknown",
                                      style: AppTextStyle.font16W700Normal.copyWith(
                                          color: isDarkTheme ? AppColors.white : AppColors.darkGray,
                                          fontSize: viewModel.fontSize),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () => viewModel.textToSpeech(),
                                      child: SvgPicture.asset(Assets.icons.sound, color: AppColors.blue)),
                                  viewModel.wordEntityRepository.requiredWordWithAllModel.word!.star != "0"
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                                          child: SvgPicture.asset(viewModel.findRank(
                                              viewModel.wordEntityRepository.requiredWordWithAllModel.word!.star!)),
                                        )
                                      : SizedBox(width: 10.w),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 75.w),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              viewModel.wordEntityRepository.requiredWordWithAllModel.word!
                                                      .wordClasswordClass ??
                                                  "",
                                              style: AppTextStyle.font14W500Normal.copyWith(
                                                  color: isDarkTheme ? AppColors.white : AppColors.darkGray,
                                                  fontSize: (viewModel.fontSize! - 2.0)),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 5.w),
                                                child: HtmlWidget(
                                                  "  ${viewModel.wordEntityRepository.requiredWordWithAllModel.word!.wordClassBody ?? ""}",
                                                  textStyle: TextStyle(
                                                      color: AppColors.paleGray, fontSize: viewModel.fontSize! - 2),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              MaterialButton(
                                onPressed: () => viewModel.localViewModel.goByLink(
                                    viewModel.wordEntityRepository.requiredWordWithAllModel.word!.linkWord ?? ""),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      viewModel.wordEntityRepository.requiredWordWithAllModel.word!
                                              .wordClassBodyMeaning ??
                                          "",
                                      style: AppTextStyle.font12W500Normal.copyWith(
                                        color: isDarkTheme ? AppColors.gray : AppColors.gray,
                                        fontSize: (viewModel.fontSize! - 4),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 18,
                                      color: AppColors.blue,
                                    ),
                                    Text(
                                      viewModel.wordEntityRepository.requiredWordWithAllModel.word!.linkWord ?? "",
                                      style: AppTextStyle.font12W500Normal.copyWith(
                                        color: isDarkTheme ? AppColors.white : AppColors.darkGray,
                                        fontSize: (viewModel.fontSize! - 4),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: viewModel.localViewModel.isNetworkAvailable,
                          builder: (BuildContext context, value, Widget? child) {
                            return viewModel.localViewModel.banner != null && value as bool
                                ? Container(
                                    margin: EdgeInsets.only(top: 16.h),
                                    decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                                    height: viewModel.localViewModel.banner!.size.height * 1.0,
                                    child: AdWidget(
                                      ad: viewModel.localViewModel.banner!..load(),
                                    ))
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    )
                  // for regular words
                  : ListView(
                      padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w, bottom: 70.h),
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Container(
                          decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 28.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 25.w),
                                    child: Text(
                                      viewModel.wordEntityRepository.requiredWordWithAllModel.word!.word ?? "unknown",
                                      style: AppTextStyle.font16W700Normal.copyWith(
                                          color: isDarkTheme ? AppColors.white : AppColors.darkGray,
                                          fontSize: viewModel.fontSize),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () => viewModel.textToSpeech(),
                                      child: SvgPicture.asset(Assets.icons.sound, color: AppColors.blue)),
                                  viewModel.wordEntityRepository.requiredWordWithAllModel.word!.star != "0"
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                                          child: SvgPicture.asset(viewModel.findRank(
                                              viewModel.wordEntityRepository.requiredWordWithAllModel.word!.star!)),
                                        )
                                      : SizedBox(width: 10.w),
                                  Container(
                                    key: globalKey,
                                    child: GestureDetector(
                                        onTap: () => viewModel.addAllWords(globalKey),
                                        child: SvgPicture.asset(Assets.icons.saveWord, color: AppColors.blue)),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 15.h),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(right: 75.w),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              viewModel.wordEntityRepository.requiredWordWithAllModel.word!
                                                      .wordClasswordClass ??
                                                  "",
                                              style: AppTextStyle.font14W500Normal.copyWith(
                                                  color: isDarkTheme ? AppColors.white : AppColors.darkGray,
                                                  fontSize: viewModel.fontSize),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                padding: EdgeInsets.only(left: 5.w),
                                                child: HtmlWidget(
                                                  "  ${viewModel.wordEntityRepository.requiredWordWithAllModel.word!.wordClassBody ?? ""}",
                                                  textStyle: TextStyle(
                                                      color: AppColors.paleGray, fontSize: viewModel.fontSize! - 2),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible:
                                          viewModel.wordEntityRepository.requiredWordWithAllModel.word!.image != null,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: GestureDetector(
                                          onTap: () => viewModel.showPhotoView(),
                                          child: Container(
                                            height: 66.h,
                                            padding: EdgeInsets.all(2.r),
                                            width: 66.h,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(9.r),
                                              color: AppColors.lightBlue,
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(9.r),
                                              child:
                                                  viewModel.wordEntityRepository.requiredWordWithAllModel.word!.image !=
                                                          null
                                                      ? Image.network(
                                                          Urls.baseUrl +
                                                              viewModel.wordEntityRepository.requiredWordWithAllModel
                                                                  .word!.image!,
                                                          fit: BoxFit.scaleDown,
                                                        )
                                                      : const SizedBox.shrink(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: viewModel.parentsWithAllList.length,
                                itemBuilder: (context, index) {
                                  var item = viewModel.parentsWithAllList[index];
                                  bool isSelected =
                                      viewModel.isWordContained(viewModel.conductToString(item.wordsUz!)) &&
                                          viewModel.getFirstPhrase;
                                  if (isSelected) {
                                    viewModel.firstAutoScroll();
                                  }
                                  return Container(
                                    key: isSelected ? viewModel.scrollKey : null,
                                    child: ParentWidget(
                                      model: item,
                                      orderNum: "${index + 1}",
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: viewModel.localViewModel.isNetworkAvailable,
                          builder: (BuildContext context, value, Widget? child) {
                            return viewModel.localViewModel.banner != null && value as bool
                                ? Container(
                                    margin: EdgeInsets.only(top: 16.h),
                                    decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                                    height: viewModel.localViewModel.banner!.size.height * 1.0,
                                    child: AdWidget(
                                      ad: viewModel.localViewModel.banner!..load(),
                                    ))
                                : const SizedBox.shrink();
                          },
                        ),
                      ],
                    )
              : const Center(
                  child: LoadingWidget(),
                ),
        ),
      ),
    );
  }

  @override
  WordDetailPageViewModel viewModelBuilder(BuildContext context) {
    return WordDetailPageViewModel(
        context: context,
        localViewModel: locator.get(),
        wordEntityRepository: locator.get(),
        wordMapper: locator.get(),
        preferenceHelper: locator.get());
  }
}
