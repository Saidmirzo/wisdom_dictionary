import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/config/constants/app_colors.dart';
import 'package:wisdom/config/constants/app_decoration.dart';
import 'package:wisdom/config/constants/app_text_style.dart';
import 'package:wisdom/config/constants/assets.dart';
import 'package:wisdom/data/model/verify_model.dart';
import 'package:wisdom/presentation/widgets/custom_app_bar.dart';

import '../../../../core/di/app_locator.dart';
import '../../../components/custom_banner.dart';
import '../viewmodel/payment_page_viewmodel.dart';

class PaymentPage extends ViewModelBuilderWidget<PaymentPageViewModel> {
  PaymentPage({
    super.key,
    required this.verifyModel,
    required this.phoneNumber,
  });

  TextEditingController editingController = TextEditingController();
  final VerifyModel? verifyModel;
  final String? phoneNumber;

  @override
  void onViewModelReady(PaymentPageViewModel viewModel) {
    viewModel.init();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, PaymentPageViewModel viewModel, Widget? child) {
    return WillPopScope(
      onWillPop: () => viewModel.goToProfile(),
      child: Scaffold(
        backgroundColor: AppColors.lightBackground,
        appBar: CustomAppBar(
          title: 'To\'lov',
          onTap: () => viewModel.goToProfile(),
          leadingIcon: Assets.icons.arrowLeft,
        ),
        body: viewModel.isSuccess(tag: viewModel.subscribeSuccessfulTag)
            ? Padding(
                padding: EdgeInsets.only(top: 57.h, left: 18.w, right: 18.w),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: AppDecoration.bannerDecor,
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 27.h),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              Assets.icons.logoBlueText,
                              height: 32.h,
                              fit: BoxFit.scaleDown,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: Text(
                                'To\'lovni Payme, Click yoki Paynet ilovalari orqali Wisdom ilovasini qidirib topib quyidagi ko\'rsatilgan hisob raqam va summani kiritgan holda ham amalga oshirishingiz mumkin!',
                                style: AppTextStyle.font12W500Normal.copyWith(color: AppColors.darkGray),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Sizing hisob raqamingiz: ',
                                    style: AppTextStyle.font12W500Normal.copyWith(color: AppColors.darkGray),
                                    children: [
                                      TextSpan(
                                        text: viewModel.subscribeModel.billingId.toString(),
                                        style: AppTextStyle.font16W600Normal.copyWith(
                                          color: AppColors.blue,
                                        ),
                                      ),
                                    ]),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20.h),
                              child: RichText(
                                text: TextSpan(
                                    text: 'Tanlangan obuna tarifi: \n',
                                    style: AppTextStyle.font12W500Normal.copyWith(color: AppColors.darkGray),
                                    children: [
                                      TextSpan(
                                        text:
                                            (viewModel.tariffsList.name!.en ?? "Contact with developers").toUpperCase(),
                                        style: AppTextStyle.font14W700Normal.copyWith(
                                          color: AppColors.blue,
                                        ),
                                      ),
                                      // TextSpan(
                                      //   text: ' evaziga butunlay sotib olishingiz mumkin.',
                                      //   style: AppTextStyle.font12W500Normal.copyWith(color: AppColors.darkGray),
                                      // ),
                                    ]),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomBanner(
                        title: 'To\'lov turi',
                        height: 330.h,
                        contentPadding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
                        child: Column(
                          children: [
                            RadioListTile(
                              title: Padding(
                                padding: EdgeInsets.only(left: 100.w),
                                child: SvgPicture.asset(
                                  Assets.images.click,
                                ),
                              ),
                              value: 'click',
                              groupValue: viewModel.radioValue,
                              onChanged: (value) {
                                viewModel.radioValue = value.toString();
                                viewModel.notifyListeners();
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Divider(
                                height: 1,
                                thickness: 0.5,
                                color: AppColors.borderWhite,
                              ),
                            ),
                            RadioListTile(
                              title: Padding(
                                padding: EdgeInsets.only(left: 100.w),
                                child: SvgPicture.asset(
                                  Assets.images.payme,
                                ),
                              ),
                              value: 'payme',
                              groupValue: viewModel.radioValue,
                              onChanged: (value) {
                                viewModel.radioValue = value.toString();
                                viewModel.notifyListeners();
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              child: Divider(
                                height: 1,
                                thickness: 0.5,
                                color: AppColors.borderWhite,
                              ),
                            ),
                            RadioListTile(
                              title: Padding(
                                padding: EdgeInsets.only(left: 100.w),
                                child: SvgPicture.asset(
                                  Assets.images.paynet,
                                ),
                              ),
                              value: 'paynet',
                              groupValue: viewModel.radioValue,
                              onChanged: (value) {
                                viewModel.radioValue = value.toString();
                                viewModel.notifyListeners();
                              },
                            ),
                            Container(
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(40.r), color: AppColors.blue),
                              height: 45.h,
                              margin: EdgeInsets.only(top: 40.h, bottom: 12.h),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () => viewModel.onPayPressed(),
                                  borderRadius: BorderRadius.circular(40.r),
                                  child: Center(
                                    child: Text(
                                      'To\'lovni amalga oshirish',
                                      style: AppTextStyle.font14W500Normal,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  @override
  PaymentPageViewModel viewModelBuilder(BuildContext context) {
    return PaymentPageViewModel(
        context: context,
        profileRepository: locator.get(),
        localViewModel: locator.get(),
        sharedPreferenceHelper: locator.get(),
        phoneNumber: phoneNumber,
        verifyModel: verifyModel);
  }
}
