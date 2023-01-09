import 'package:flutter/material.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/local_data.dart';
import 'package:wisdom/presentation/components/abbreviation_word_item.dart';
import '../../../../config/constants/assets.dart';
import '../../widgets/custom_app_bar.dart';

class AbbreviationPage extends StatelessWidget {
  const AbbreviationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        title: 'Qisqartmalar',
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
