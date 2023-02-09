import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/local_data.dart';
import 'package:wisdom/presentation/components/abbreviation_word_item.dart';
import '../../../../config/constants/assets.dart';
import '../../../config/constants/constants.dart';
import '../../widgets/custom_app_bar.dart';

class AbbreviationPage extends StatelessWidget {
  const AbbreviationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: CustomAppBar(
        title: 'abbreviations'.tr(),
        onTap: () => Navigator.of(context).pop(),
        leadingIcon: Assets.icons.arrowLeft,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        itemCount: abbreviations.length,
        itemBuilder: (BuildContext context, int index) {
          var item = abbreviations[index];
          return AbbreviationWordItem(firstText: item.keys.first, secondText: item.values.first);
        },
      ),
    );
  }
}
