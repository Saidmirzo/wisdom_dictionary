import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/presentation/components/catalog_button.dart';
import 'package:wisdom/presentation/pages/catalogs/viewmodel/catalogs_page_viewmodel.dart';
import 'package:wisdom/presentation/routes/routes.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/assets.dart';

// ignore: must_be_immutable
class CatalogsPage extends ViewModelBuilderWidget<CatalogsPageViewModel> {
  CatalogsPage({super.key});

  @override
  Widget builder(BuildContext context, CatalogsPageViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      drawerEnableOpenDragGesture: false,
      appBar: CustomAppBar(
        leadingIcon: Assets.icons.menu,
        onTap: () => ZoomDrawer.of(context)!.toggle(),
        isSearch: true,
        title: 'Bo\'limlar',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 36),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CatalogButton(
                  text: 'Grammar',
                  onTap: () {
                    viewModel.navigateTo(Routes.grammarPage);
                  }),
              CatalogButton(text: 'Thesaurus', onTap: () {}),
              CatalogButton(text: 'Differences', onTap: () {}),
              CatalogButton(text: 'Metaphors', onTap: () {}),
              CatalogButton(text: 'Culture', onTap: () {}),
              CatalogButton(text: 'Speaking', onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }

  @override
  CatalogsPageViewModel viewModelBuilder(BuildContext context) {
    return CatalogsPageViewModel(context: context);
  }
}
