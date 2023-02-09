import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/presentation/components/catalog_button.dart';
import 'package:wisdom/presentation/pages/catalogs/viewmodel/catalogs_page_viewmodel.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/assets.dart';
import '../../../../config/constants/constants.dart';

// ignore: must_be_immutable
class CatalogsPage extends ViewModelBuilderWidget<CatalogsPageViewModel> {
  CatalogsPage({super.key});

  @override
  Widget builder(BuildContext context, CatalogsPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goMain(),
      child: Scaffold(
        backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
        drawerEnableOpenDragGesture: false,
        appBar: CustomAppBar(
          leadingIcon: Assets.icons.menu,
          onTap: () => ZoomDrawer.of(context)!.toggle(),
          isSearch: false,
          focus: false,
          title: 'navigation_catalogue'.tr(),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 36),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                CatalogButton(text: 'grammar'.tr(), onTap: () => locator<LocalViewModel>().changePageIndex(11)),
                CatalogButton(text: 'thesaurus'.tr(), onTap: () => locator<LocalViewModel>().changePageIndex(12)),
                CatalogButton(text: 'difference'.tr(), onTap: () => locator<LocalViewModel>().changePageIndex(13)),
                CatalogButton(text: 'metaphor'.tr(), onTap: () => locator<LocalViewModel>().changePageIndex(14)),
                CatalogButton(text: 'culture'.tr(), onTap: () => locator<LocalViewModel>().changePageIndex(15)),
                CatalogButton(text: 'speaking'.tr(), onTap: () => locator<LocalViewModel>().changePageIndex(17)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  CatalogsPageViewModel viewModelBuilder(BuildContext context) {
    return CatalogsPageViewModel(context: context, localViewModel: locator.get());
  }
}
