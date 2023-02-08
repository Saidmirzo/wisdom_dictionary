import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/pages/grammar/viewmodel/grammar_detail_page_viewmodel.dart';
import 'package:wisdom/presentation/widgets/loading_widget.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_decoration.dart';
import '../../../../config/constants/assets.dart';
import '../../../../data/viewmodel/local_viewmodel.dart';
import '../../../../config/constants/constants.dart';
import '../../../widgets/custom_app_bar.dart';

// ignore: must_be_immutable
class GrammarDetailPage extends ViewModelBuilderWidget<GrammarDetailPageViewModel> {
  GrammarDetailPage({super.key});

  @override
  void onViewModelReady(GrammarDetailPageViewModel viewModel) {
    viewModel.getGrammarDetails();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, GrammarDetailPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goBack(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: CustomAppBar(
          leadingIcon: Assets.icons.arrowLeft,
          onTap: () => viewModel.goBack(),
          isSearch: false,
          title: "grammar".tr(),
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
                  children: [
                    Center(
                      child: Text(
                        viewModel.getGrammar() ?? "Unknown",
                        style: AppTextStyle.font16W600Normal
                            .copyWith(color: isDarkTheme ? AppColors.white : AppColors.darkGray),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: SelectionArea(
                        child: viewModel.isSuccess(tag: viewModel.getGrammarDetailsTag)
                            ? HtmlWidget(
                                viewModel.categoryRepository.grammarDetailModel.gBody!
                                    .replaceAll("<br>", "").replaceAll("<p>", "").replaceAll("</p>", "<br>"),
                                textStyle: AppTextStyle.font14W400NormalHtml
                                    .copyWith(fontSize: locator<LocalViewModel>().fontSize-2,                                   color: isDarkTheme ? AppColors.lightGray : null,
                                ),
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
  GrammarDetailPageViewModel viewModelBuilder(BuildContext context) {
    return GrammarDetailPageViewModel(
        context: context, homeRepository: locator.get(), categoryRepository: locator.get());
  }
}
