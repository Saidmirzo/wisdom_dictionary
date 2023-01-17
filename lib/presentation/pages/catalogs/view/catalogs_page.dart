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

// ignore: must_be_immutable
class CatalogsPage extends ViewModelBuilderWidget<CatalogsPageViewModel> {
  CatalogsPage({super.key});

  @override
  Widget builder(BuildContext context, CatalogsPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goMain(),
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        drawerEnableOpenDragGesture: false,
        appBar: CustomAppBar(
          leadingIcon: Assets.icons.menu,
          onTap: () => ZoomDrawer.of(context)!.toggle(),
          isSearch: true,
          title: 'Catalogue',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 36),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                CatalogButton(text: 'Grammar', onTap: () => locator<LocalViewModel>().changePageIndex(11)),
                CatalogButton(text: 'Thesaurus', onTap: () => locator<LocalViewModel>().changePageIndex(12)),
                CatalogButton(text: 'Differences', onTap: () => locator<LocalViewModel>().changePageIndex(13)),
                CatalogButton(text: 'Metaphors', onTap: () => locator<LocalViewModel>().changePageIndex(14)),
                CatalogButton(text: 'Culture', onTap: () => locator<LocalViewModel>().changePageIndex(15)),
                CatalogButton(text: 'Speaking', onTap: () => locator<LocalViewModel>().changePageIndex(17)),
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
