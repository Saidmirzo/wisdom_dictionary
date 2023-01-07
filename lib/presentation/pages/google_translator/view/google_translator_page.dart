import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/presentation/components/translate_circle_button.dart';
import 'package:wisdom/presentation/pages/google_translator/viewmodel/google_translator_page_viewmodel.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_text_style.dart';
import '../../../../config/constants/assets.dart';

class GoogleTranslatorPage extends ViewModelBuilderWidget<GoogleTranslatorPageViewModel> {
  GoogleTranslatorPage({super.key});

  @override
  Widget builder(BuildContext context, GoogleTranslatorPageViewModel viewModel, Widget? child) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        title: 'Translate',
        onTap: () {},
        leadingIcon: Assets.icons.arrowLeft,
      ),
      resizeToAvoidBottomInset: true,
      // body: const EmptyJar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(18.r), color: AppColors.white),
                height: 158.h,
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 23),
                child: Column(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.blue),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Uzbek',
                          hintStyle: AppTextStyle.font14W500Normal.copyWith(color: AppColors.darkForm),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TranslateCircleButton(onTap: () {}, iconAssets: Assets.icons.crossClose),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: TranslateCircleButton(onTap: () {}, iconAssets: Assets.icons.microphone),
                          ),
                          TranslateCircleButton(onTap: () {}, iconAssets: Assets.icons.sound),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 14),
                decoration: AppDecoration.bannerDecor.copyWith(color: AppColors.blue),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(18.5),
                    child: SizedBox(
                      height: 37.h,
                      width: 91.w,
                      child: Center(child: SvgPicture.asset(Assets.icons.send)),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(18.r), color: AppColors.white),
                height: 158.h,
                padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 23),
                child: Column(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.blue),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'English',
                          enabled: false,
                          hintStyle: AppTextStyle.font14W500Normal.copyWith(color: AppColors.darkForm),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TranslateCircleButton(onTap: () {}, iconAssets: Assets.icons.copy),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 18.w),
                            child: TranslateCircleButton(onTap: () {}, iconAssets: Assets.icons.microphone),
                          ),
                          TranslateCircleButton(onTap: () {}, iconAssets: Assets.icons.saveWord),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 14),
                decoration: AppDecoration.bannerDecor.copyWith(color: AppColors.blue),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(18.5),
                    child: SizedBox(
                      height: 37.h,
                      width: 91.w,
                      child: Center(child: SvgPicture.asset(Assets.icons.changeLangTranslate)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  GoogleTranslatorPageViewModel viewModelBuilder(BuildContext context) {
    return GoogleTranslatorPageViewModel(context: context);
  }
}
