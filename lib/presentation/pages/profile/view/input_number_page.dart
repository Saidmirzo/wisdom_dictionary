import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../viewmodel/input_number_page_viewmodel.dart';

class InputNumberPage extends ViewModelBuilderWidget<InputNumberPageViewModel> {
  InputNumberPage({super.key});

  @override
  void onViewModelReady(InputNumberPageViewModel viewModel) {
    super.onViewModelReady(viewModel);
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '+998(##) ### ## ##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  TextEditingController editingController = TextEditingController();

  @override
  Widget builder(BuildContext context, InputNumberPageViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: CustomAppBar(
        title: 'Registratsiya',
        onTap: () => viewModel.pop(),
        leadingIcon: Assets.icons.arrowLeft,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 57.h, left: 18.w, right: 18.w),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.icons.logoBlueText,
                height: 52.h,
                fit: BoxFit.scaleDown,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.h, bottom: 36.h),
                child: Text(
                  'Iltimos davom etish uchun raqamingizni kiriting',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.font12W400Normal.copyWith(color: AppColors.darkGray),
                ),
              ),
              Container(
                decoration: AppDecoration.bannerDecor,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                child: Column(
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: AppColors.lightBackground),
                      height: 45.h,
                      margin: EdgeInsets.only(top: 24.h, bottom: 12.h),
                      padding: EdgeInsets.only(left: 22.w),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          autofocus: true,
                          controller: editingController,
                          keyboardType: TextInputType.number,
                          style: AppTextStyle.font16W400Normal.copyWith(color: AppColors.blue),
                          inputFormatters: [maskFormatter],
                          decoration: InputDecoration(
                            hintText: '+998(--) --- -- --',
                            hintStyle: AppTextStyle.font16W400Normal.copyWith(color: AppColors.blue),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: AppColors.blue),
                      height: 45.h,
                      margin: EdgeInsets.only(top: 20.h, bottom: 12.h),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: (() {
                            if (editingController.text.length == 18) {
                              viewModel.onNextPressed(editingController.text);
                            } else {
                              viewModel.callBackError('Something went wrong. Please check your number');
                            }
                          }),
                          borderRadius: BorderRadius.circular(40.r),
                          child: Center(
                            child: Text(
                              'Davom etish',
                              style: AppTextStyle.font14W500Normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  InputNumberPageViewModel viewModelBuilder(BuildContext context) {
    return InputNumberPageViewModel(
        context: context,
        profileRepository: locator.get(),
        localViewModel: locator.get(),
        sharedPreferenceHelper: locator.get());
  }
}
