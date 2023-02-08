import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/components/catalog_item.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../config/constants/assets.dart';
import '../../../widgets/loading_widget.dart';
import '../viewmodel/grammar_page_viewmodel.dart';

// ignore: must_be_immutable
class GrammarPage extends ViewModelBuilderWidget<GrammarPageViewModel> {
  GrammarPage({super.key});

  @override
  void onViewModelReady(GrammarPageViewModel viewModel) {
    viewModel.getGrammarWordsList(null);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, GrammarPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goMain(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: CustomAppBar(
          title: 'grammar'.tr(),
          onTap: () => viewModel.goMain(),
          leadingIcon: Assets.icons.arrowLeft,
          isSearch: true,
          onChange: (value) => viewModel.getGrammarWordsList(value),
        ),
        resizeToAvoidBottomInset: true,
        body: viewModel.isSuccess(tag: viewModel.getGrammarTag)
            ? ListView.builder(
                itemCount: viewModel.categoryRepository.grammarWordsList.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 75.h),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var element = viewModel.categoryRepository.grammarWordsList[index];
                  return CatalogItem(
                    firstText: element.wordenword ?? "unknown",
                    onTap: () => viewModel.goToDetails(element),
                  );
                },
              )
            : const Center(child: LoadingWidget()),
      ),
    );
  }

  @override
  GrammarPageViewModel viewModelBuilder(BuildContext context) {
    return GrammarPageViewModel(
        context: context,
        categoryRepository: locator.get(),
        localViewModel: locator.get(),
        homeRepository: locator.get());
  }
}
