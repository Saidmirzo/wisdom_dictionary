import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/widgets/loading_widget.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_decoration.dart';
import '../../../../config/constants/assets.dart';
import '../../../../data/viewmodel/local_viewmodel.dart';
import '../../../../config/constants/constants.dart';
import '../../../widgets/custom_app_bar.dart';
import '../viewmodel/speaking_detail_page_viewmodel.dart';

class SpeakingDetailPage extends ViewModelBuilderWidget<SpeakingDetailPageViewModel> {
  SpeakingDetailPage({super.key});

  @override
  void onViewModelReady(SpeakingDetailPageViewModel viewModel) {
    viewModel.getSpeakingDetails();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, SpeakingDetailPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goBack(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: CustomAppBar(
          leadingIcon: Assets.icons.arrowLeft,
          onTap: () => viewModel.goBack(),
          isSearch: false,
          title: "speaking".tr(),
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 16.h, bottom: 75.h),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        viewModel.getSpeaking() ?? "Unknown",
                        style: AppTextStyle.font16W600Normal
                            .copyWith(color:  isDarkTheme ? AppColors.white : AppColors.darkGray,, fontSize: locator<LocalViewModel>().fontSize - 2),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: SelectionArea(
                        child: viewModel.isSuccess(tag: viewModel.getSpeakingDetailsTag)
                            ? HtmlWidget(
                                viewModel.categoryRepository.speakingDetailModel.body!
                                    .replaceAll("\n", "")
                                    .replaceAll("\n\n", ""),
                                textStyle: AppTextStyle.font14W400NormalHtml
                                    .copyWith(fontSize: locator<LocalViewModel>().fontSize - 2,  color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray,),
                              )
                            : const LoadingWidget(color: AppColors.paleBlue, width: 2),
                      ),
                    ),
                  ],
                ),
              )
            ])
          ],
        ),
      ),
    );
  }

  @override
  SpeakingDetailPageViewModel viewModelBuilder(BuildContext context) {
    return SpeakingDetailPageViewModel(
        context: context,
        homeRepository: locator.get(),
        categoryRepository: locator.get(),
        localViewModel: locator.get());
  }
}
