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
import '../viewmodel/speaking_page_viewmodel.dart';

// ignore: must_be_immutable
class SpeakingPage extends ViewModelBuilderWidget<SpeakingPageViewModel> {
  SpeakingPage({super.key});

  @override
  void onViewModelReady(SpeakingPageViewModel viewModel) {
    viewModel.getSpeakingWordsList();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, SpeakingPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goMain(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
        appBar: CustomAppBar(
          leadingIcon: Assets.icons.arrowLeft,
          onTap: () => viewModel.goMain(),
          isSearch: false,
          title: "speaking".tr(),
        ),
        body: viewModel.isSuccess(tag: viewModel.getSpeakingTag)
            ? ListView.builder(
                itemCount: viewModel.categoryRepository.speakingWordsList.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 75.h),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var element = viewModel.categoryRepository.speakingWordsList[index];
                  return CatalogItem(
                    firstText: element.title ?? "unknown",
                    onTap: (){}//() => viewModel.goToNext(element),
                  );
                },
              )
            : const Center(child: LoadingWidget()),
      ),
    );
  }

  @override
  SpeakingPageViewModel viewModelBuilder(BuildContext context) {
    return SpeakingPageViewModel(
        context: context,
        homeRepository: locator.get(),
        categoryRepository: locator.get(),
        localViewModel: locator.get());
  }
}
