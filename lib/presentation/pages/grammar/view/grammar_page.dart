import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/components/catalog_item.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../config/constants/assets.dart';
import '../../../widgets/loading_widget.dart';
import '../viewmodel/grammar_page_viewmodel.dart';

class GrammarPage extends ViewModelBuilderWidget<GrammarPageViewModel> {
  GrammarPage({super.key});

  @override
  void onViewModelReady(GrammarPageViewModel viewModel) {
    viewModel.getGrammarWordsList();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, GrammarPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goMain(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: const Color(0XFFF6F9FF),
        appBar: CustomAppBar(
          title: 'Grammar',
          onTap: () => viewModel.goMain(),
          leadingIcon: Assets.icons.arrowLeft,
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
