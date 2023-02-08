import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/pages/metaphor/viewmodel/metaphor_page_viewmodel.dart';
import 'package:wisdom/presentation/widgets/loading_widget.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/assets.dart';
import '../../../../config/constants/constants.dart';
import '../../../components/catalog_item.dart';
import '../../../widgets/custom_app_bar.dart';

class MetaphorPage extends ViewModelBuilderWidget<MetaphorPageViewModel> {
  MetaphorPage({super.key});

  @override
  void onViewModelReady(MetaphorPageViewModel viewModel) {
    viewModel.getMetaphorWordsList(null);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, MetaphorPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goMain(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: CustomAppBar(
          leadingIcon: Assets.icons.arrowLeft,
          onTap: () => viewModel.goMain(),
          isSearch: true,
          onChange: (value) => viewModel.getMetaphorWordsList(value),
          title: "metaphor".tr(),
        ),
        body: viewModel.isSuccess(tag: viewModel.getMetaphorTag)
            ? ListView.builder(
                itemCount: viewModel.categoryRepository.metaphorWordsList.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 75.h),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var element = viewModel.categoryRepository.metaphorWordsList[index];
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
  MetaphorPageViewModel viewModelBuilder(BuildContext context) {
    return MetaphorPageViewModel(
        context: context,
        homeRepository: locator.get(),
        categoryRepository: locator.get(),
        localViewModel: locator.get());
  }
}
