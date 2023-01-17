import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/presentation/components/word_jar_item.dart';
import 'package:wisdom/presentation/pages/exercise/viewmodel/exercise_viewmodel.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_text_style.dart';
import '../../../../config/constants/assets.dart';
import '../../../widgets/custom_app_bar.dart';

class ExercisePage extends ViewModelBuilderWidget<ExerciseViewModel> {
  ExercisePage({super.key});

  @override
  Widget builder(BuildContext context, ExerciseViewModel viewModel, Widget? child) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        leadingIcon: Assets.icons.menu,
        onTap: () => ZoomDrawer.of(context)!.toggle(),
        isSearch: true,
        title: 'Lug\'atlar oynsi',
      ),
      // body: const EmptyJar(),
      body: ListView(
        padding: const EdgeInsets.only(top: 16, bottom: 130),
        physics: const BouncingScrollPhysics(),
        children: [
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
          WordJarItem(firstText: 'adverb', secondText: 'ravish', onDelete: () {}, onView: () {}),
        ],
      ),
      endDrawerEnableOpenDragGesture: true,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 65),
        decoration: BoxDecoration(color: AppColors.blue, borderRadius: BorderRadius.circular(25.r)),
        height: 40.h,
        width: 125.w,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(25.r),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SvgPicture.asset(Assets.icons.exercise, height: 20.h, fit: BoxFit.scaleDown),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Mashq',
                  style: AppTextStyle.font14W500Normal,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  ExerciseViewModel viewModelBuilder(BuildContext context) {
    return ExerciseViewModel(context: context);
  }
}
