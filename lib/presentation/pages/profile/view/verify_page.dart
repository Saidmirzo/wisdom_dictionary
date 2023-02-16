import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../config/constants/constants.dart';
import '../../../../core/di/app_locator.dart';
import '../viewmodel/verify_page_viewmodel.dart';

class VerifyPage extends ViewModelBuilderWidget<VerifyPageViewModel> {
  VerifyPage({
    super.key,
    required this.phoneNumber,
  });

  final String phoneNumber;
  TextEditingController editingController = TextEditingController();

  @override
  Widget builder(BuildContext context, VerifyPageViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: CustomAppBar(
        title: 'verification_code'.tr(),
        onTap: () => viewModel.pop(),
        leadingIcon: Assets.icons.arrowLeft,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
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
                  child: RichText(
                    text: TextSpan(
                        text: 'verification_code'.tr(),
                        style: AppTextStyle.font12W400Normal
                            .copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
                        children: [
                          TextSpan(
                            text: phoneNumber.substring(4, phoneNumber.length),
                            style: AppTextStyle.font12W500Normal.copyWith(
                              color: AppColors.blue,
                            ),
                          ),
                          TextSpan(
                            text: 'code_sent_to'.tr(),
                            style: AppTextStyle.font12W400Normal
                                .copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
                          ),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  decoration: isDarkTheme ? AppDecoration.bannerDarkDecor : AppDecoration.bannerDecor,
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.r),
                            color: isDarkTheme ? AppColors.darkBackground : AppColors.lightBackground),
                        height: 45.h,
                        margin: EdgeInsets.only(top: 24.h, bottom: 12.h),
                        padding: EdgeInsets.only(left: 22.w, right: 22.w),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: PinCodeTextField(
                            controller: editingController,
                            appContext: context,
                            length: 5,
                            autoFocus: true,
                            keyboardType: TextInputType.number,
                            textStyle: AppTextStyle.font18W500Normal.copyWith(color: AppColors.blue),
                            onChanged: (String value) {},
                            cursorColor: Colors.transparent,
                            pinTheme: PinTheme(
                                fieldHeight: 40.h,
                                shape: PinCodeFieldShape.underline,
                                inactiveColor: AppColors.blue,
                                selectedColor: AppColors.blue,
                                activeFillColor: AppColors.blue,
                                selectedFillColor: AppColors.blue,
                                disabledColor: AppColors.blue,
                                activeColor: Colors.blue),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: AppColors.blue),
                        height: 45.h,
                        margin: EdgeInsets.only(top: 20.h, bottom: 10.h),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (editingController.text.length == 5) {
                                viewModel.onNextPressed(editingController.text);
                              } else {
                                viewModel.callBackError('Something went wrong. Please check sms code');
                              }
                            },
                            borderRadius: BorderRadius.circular(40.r),
                            child: Center(
                              child: Text(
                                'next'.tr(),
                                style: AppTextStyle.font14W500Normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'sent_info'.tr(),
                        textAlign: TextAlign.center,
                        style: AppTextStyle.font12W400Normal.copyWith(color: const Color(0xFF919399)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
                        child: GestureDetector(
                          onTap: () => viewModel.onReSendPressed(),
                          child: Text(
                            'resent'.tr(),
                            textAlign: TextAlign.center,
                            style: AppTextStyle.font14W500Normal.copyWith(color: AppColors.gray),
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
      ),
    );
  }

  @override
  VerifyPageViewModel viewModelBuilder(BuildContext context) {
    return VerifyPageViewModel(
        context: context,
        profileRepository: locator.get(),
        localViewModel: locator.get(),
        sharedPreferenceHelper: locator.get(),
        homeRepository: locator.get(),
        phoneNumber: phoneNumber);
  }
}
