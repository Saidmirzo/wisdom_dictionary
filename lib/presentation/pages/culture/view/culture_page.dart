import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/components/catalog_item.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../config/constants/assets.dart';
import '../../../widgets/loading_widget.dart';
import '../viewmodel/culture_page_viewmodel.dart';

class CulturePage extends ViewModelBuilderWidget<CulturePageViewModel> {
  CulturePage({super.key});

  @override
  void onViewModelReady(CulturePageViewModel viewModel) {
    viewModel.getCultureWordsList();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, CulturePageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goMain(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: const Color(0XFFF6F9FF),
        appBar: CustomAppBar(
          title: 'Culture',
          onTap: () => viewModel.goMain(),
          leadingIcon: Assets.icons.arrowLeft,
        ),
        resizeToAvoidBottomInset: true,
        body: viewModel.isSuccess(tag: viewModel.getCultureTag)
            ? ListView.builder(
                itemCount: viewModel.categoryRepository.cultureWordsList.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 75.h),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var element = viewModel.categoryRepository.cultureWordsList[index];
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
  CulturePageViewModel viewModelBuilder(BuildContext context) {
    return CulturePageViewModel(
        context: context,
        categoryRepository: locator.get(),
        localViewModel: locator.get(),
        homeRepository: locator.get());
  }
}