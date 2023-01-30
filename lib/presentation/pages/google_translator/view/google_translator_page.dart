import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:lottie/lottie.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/presentation/components/translate_circle_button.dart';
import 'package:wisdom/presentation/pages/google_translator/viewmodel/google_translator_page_viewmodel.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_text_style.dart';
import '../../../../config/constants/assets.dart';

// ignore: must_be_immutable
class GoogleTranslatorPage extends ViewModelBuilderWidget<GoogleTranslatorPageViewModel> {
  GoogleTranslatorPage({super.key});

  late TextEditingController topController = TextEditingController();
  late TextEditingController bottomController = TextEditingController();
  bool isCancel = false;

  @override
  void onViewModelReady(GoogleTranslatorPageViewModel viewModel) {
    super.onViewModelReady(viewModel);
    topController.addListener(() {
      if (topController.text.isNotEmpty) {
        isCancel = true;
      } else {
        isCancel = false;
      }
      viewModel.notifyListeners();
    });
  }

  @override
  void onDestroy(GoogleTranslatorPageViewModel model) {
    // topController.dispose();
    // bottomController.dispose();
    super.onDestroy(model);
  }

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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          children: [
            Container(
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
                            controller: topController,
                            style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.blue),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: viewModel.topUzbek ? "O'zbekcha" : "English",
                              hintStyle: AppTextStyle.font14W500Normal.copyWith(color: AppColors.lightBlue),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TranslateCircleButton(
                                  onTap: () async {
                                    if (isCancel) {
                                      topController.clear();
                                      bottomController.clear();
                                      viewModel.notifyListeners();
                                    } else {
                                      FlutterClipboard.paste().then((value) {
                                        topController.text = value;
                                        viewModel.notifyListeners();
                                      });
                                    }
                                  },
                                  iconAssets: isCancel ? Assets.icons.crossClose : Assets.icons.copy),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.w),
                                child: TranslateCircleButton(
                                    onTap: () async {
                                      viewModel.startListening();
                                      topController.text = await viewModel.voiceToText();
                                      viewModel.stopListening();
                                    },
                                    iconAssets: Assets.icons.microphone),
                              ),
                              TranslateCircleButton(
                                  onTap: () {
                                    viewModel.readText(topController.text);
                                  },
                                  iconAssets: Assets.icons.sound),
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
                        onTap: () async {
                          bottomController.text = await viewModel.translate(topController.text);
                          viewModel.notifyListeners();
                        },
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
                            controller: bottomController,
                            style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.blue),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: viewModel.topUzbek ? "English" : "O'zbekcha",
                              enabled: false,
                              hintStyle: AppTextStyle.font14W500Normal.copyWith(color: AppColors.lightBlue),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TranslateCircleButton(
                                  onTap: () {
                                    FlutterClipboard.copy(bottomController.text);
                                  },
                                  iconAssets: Assets.icons.copy),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 18.w),
                                child: TranslateCircleButton(
                                    onTap: () {
                                      viewModel.readText(bottomController.text);
                                    },
                                    iconAssets: Assets.icons.sound),
                              ),
                              TranslateCircleButton(
                                onTap: () {},
                                iconAssets: Assets.icons.saveWord,
                              ),
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
                        onTap: () {
                          viewModel.exchangeLanguages();
                        },
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
            if (viewModel.isListening) const ListeningWidget()
          ],
        ),
      ),
    );
  }

  @override
  GoogleTranslatorPageViewModel viewModelBuilder(BuildContext context) {
    return GoogleTranslatorPageViewModel(context: context);
  }
}

class ListeningWidget extends StatelessWidget {
  const ListeningWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300.h,
        height: 300.h,
        margin: EdgeInsets.only(top: 100.h),
        child: Lottie.asset("assets/lottie/listening.json"),
      ),
    );
  }
}
