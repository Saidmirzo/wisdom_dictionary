import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jbaza/jbaza.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/components/parent_widget.dart';
import 'package:wisdom/presentation/pages/word_detail/viewmodel/word_detail_page_viewmodel.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_decoration.dart';
import '../../../../config/constants/assets.dart';
import '../../../../config/constants/urls.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/loading_widget.dart';

class WordDetailPage extends ViewModelBuilderWidget<WordDetailPageViewModel> {
  WordDetailPage({super.key});

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
  Widget builder(BuildContext context, WordDetailPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goBackToSearch(),
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        resizeToAvoidBottomInset: true,
        appBar: CustomAppBar(
          title: viewModel.localViewModel.wordDetailModel.word ?? "unknown",
          onTap: () => viewModel.goBackToSearch(),
          leadingIcon: Assets.icons.arrowLeft,
        ),
        body: viewModel.isSuccess(tag: viewModel.initTag)
            ? ListView(
                padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w, bottom: 70.h),
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                controller: viewModel.autoScrollController,
                children: [
                  Container(
                    decoration: AppDecoration.bannerDecor,
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
                                style: AppTextStyle.font16W700Normal
                                    .copyWith(color: AppColors.blue, fontSize: viewModel.fontSize),
                              ),
                            ),
                            GestureDetector(
                                onTap: () => viewModel.textToSpeech(), child: SvgPicture.asset(Assets.icons.sound)),
                            viewModel.wordEntityRepository.requiredWordWithAllModel.word!.star != "0"
                                ? Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                                    child: SvgPicture.asset(viewModel
                                        .findRank(viewModel.wordEntityRepository.requiredWordWithAllModel.word!.star!)),
                                  )
                                : SizedBox(width: 10.w),
                            SvgPicture.asset(Assets.icons.saveWord),
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
                                        style: AppTextStyle.font14W500Normal
                                            .copyWith(color: AppColors.darkGray, fontSize: viewModel.fontSize! - 2),
                                      ),
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: HtmlWidget(
                                            "  ${viewModel.wordEntityRepository.requiredWordWithAllModel.word!.wordClassBody ?? ""}",
                                            textStyle:
                                                TextStyle(color: AppColors.paleGray, fontSize: viewModel.fontSize! - 2),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: viewModel.wordEntityRepository.requiredWordWithAllModel.word!.image != null,
                                child: Align(
                                  alignment: Alignment.centerRight,
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
                                      child: viewModel.wordEntityRepository.requiredWordWithAllModel.word!.image != null
                                          ? Image.network(
                                              Urls.baseUrl +
                                                  viewModel.wordEntityRepository.requiredWordWithAllModel.word!.image!,
                                              fit: BoxFit.scaleDown,
                                            )
                                          : const SizedBox.shrink(),
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
                            return ParentWidget(
                              model: item,
                              orderNum: "${index + 1}",
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const Center(
                child: LoadingWidget(),
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
