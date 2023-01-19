import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/data/model/word_with_theasurus_model.dart';
import 'package:wisdom/presentation/pages/grammar/viewmodel/grammar_detail_page_viewmodel.dart';
import 'package:wisdom/presentation/pages/thesaurus/viewmodel/thesaurus_detail_page_viewmodel.dart';
import 'package:wisdom/presentation/pages/thesaurus/viewmodel/thesaurus_page_viewmodel.dart';
import 'package:wisdom/presentation/widgets/loading_widget.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_decoration.dart';
import '../../../../config/constants/assets.dart';
import '../../../components/catalog_item.dart';
import '../../../widgets/custom_app_bar.dart';

class ThesaurusPage extends ViewModelBuilderWidget<ThesaurusPageViewModel> {
  ThesaurusPage({super.key});

  @override
  void onViewModelReady(ThesaurusPageViewModel viewModel) {
    viewModel.getThesaurusWordsList(null);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, ThesaurusPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goMain(),
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        backgroundColor: AppColors.lightBackground,
        appBar: CustomAppBar(
          leadingIcon: Assets.icons.arrowLeft,
          onTap: () => viewModel.goMain(),
          isSearch: true,
          onChange: (value) => viewModel.getThesaurusWordsList(value),
          title: "Thesaurus",
        ),
        body: viewModel.isSuccess(tag: viewModel.getThesaurusTag)
            ? ListView.builder(
                itemCount: viewModel.categoryRepository.thesaurusWordsList.length,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 75.h),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var element = viewModel.categoryRepository.thesaurusWordsList[index];
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
  ThesaurusPageViewModel viewModelBuilder(BuildContext context) {
    return ThesaurusPageViewModel(
        context: context,
        homeRepository: locator.get(),
        categoryRepository: locator.get(),
        localViewModel: locator.get());
  }
}
