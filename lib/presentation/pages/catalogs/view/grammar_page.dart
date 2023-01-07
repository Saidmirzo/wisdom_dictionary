import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/presentation/components/catalog_item.dart';
import 'package:wisdom/presentation/pages/catalogs/viewmodel/catalogs_page_viewmodel.dart';
import 'package:wisdom/presentation/routes/routes.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../config/constants/assets.dart';

class GrammarPage extends ViewModelBuilderWidget<CatalogsPageViewModel> {
  GrammarPage({super.key});

  @override
  Widget builder(BuildContext context, CatalogsPageViewModel viewModel, Widget? child) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: const Color(0XFFF6F9FF),
      appBar: CustomAppBar(
        title: 'Grammar',
        onTap: () => Navigator.pop(context),
        leadingIcon: Assets.icons.arrowLeft,
      ),
      resizeToAvoidBottomInset: true,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          CatalogItem(
              firstText: 'ability',
              onTap: () => viewModel.navigateTo(Routes.grammarPageabout, arg: {'title': 'ability'})),
          CatalogItem(firstText: 'baby', onTap: () {}),
          CatalogItem(firstText: 'abroad', onTap: () {}),
          CatalogItem(firstText: 'band', onTap: () {}),
          CatalogItem(firstText: 'ache', onTap: () {}),
          CatalogItem(firstText: 'activity', onTap: () {}),
          CatalogItem(firstText: 'actual', onTap: () {}),
          CatalogItem(firstText: 'advantage', onTap: () {}),
          CatalogItem(firstText: 'adverb', onTap: () {}),
          CatalogItem(firstText: 'adverb', onTap: () {}),
          CatalogItem(firstText: 'adverb', onTap: () {}),
          CatalogItem(firstText: 'adverb', onTap: () {}),
          CatalogItem(firstText: 'adverb', onTap: () {}),
        ],
      ),
    );
  }

  @override
  CatalogsPageViewModel viewModelBuilder(BuildContext context) {
    return CatalogsPageViewModel(context: context);
  }
}
