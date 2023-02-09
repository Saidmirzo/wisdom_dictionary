import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/widgets/loading_widget.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/assets.dart';
import '../../../../config/constants/constants.dart';
import '../../../components/catalog_item.dart';
import '../../../widgets/custom_app_bar.dart';
import '../viewmodel/difference_page_viewmodel.dart';

class DifferencePage extends ViewModelBuilderWidget<DifferencePageViewModel> {
  DifferencePage({super.key});

  @override
  void onViewModelReady(DifferencePageViewModel viewModel) {
    viewModel.getDifferenceWordsList(null);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, DifferencePageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goMain(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: CustomAppBar(
          leadingIcon: Assets.icons.arrowLeft,
          onTap: () => viewModel.goMain(),
          isSearch: true,
          onChange: (value) => viewModel.getDifferenceWordsList(value),
          title: "differences".tr(),
        ),
        body: viewModel.isSuccess(tag: viewModel.getDifferenceTag)
            ? ListView.builder(
                itemCount: viewModel.categoryRepository.differenceWordsList.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 75.h),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var element = viewModel.categoryRepository.differenceWordsList[index];
                  return CatalogItem(
                    firstText: element.word ?? "unknown",
                    onTap: () => viewModel.goToDetails(element),
                  );
                },
              )
            : const Center(child: LoadingWidget()),
      ),
    );
  }

  @override
  DifferencePageViewModel viewModelBuilder(BuildContext context) {
    return DifferencePageViewModel(
        context: context,
        homeRepository: locator.get(),
        categoryRepository: locator.get(),
        localViewModel: locator.get());
  }
}
