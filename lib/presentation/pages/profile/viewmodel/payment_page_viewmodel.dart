import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jbaza/jbaza.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/core/di/app_locator.dart';
import 'package:wisdom/core/services/custom_client.dart';
import 'package:wisdom/data/model/subscribe_model.dart';
import 'package:wisdom/data/model/verify_model.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/profile_repository.dart';
import 'package:wisdom/presentation/widgets/custom_dialog.dart';

import '../../../../config/constants/app_colors.dart';
import '../../../../config/constants/app_text_style.dart';
import '../../../../config/constants/assets.dart';
import '../../../../config/constants/constants.dart';
import '../../../../data/model/tariffs_model.dart';
import '../../../routes/routes.dart';
import '../../../widgets/loading_widget.dart';

class PaymentPageViewModel extends BaseViewModel {
  PaymentPageViewModel({
    required super.context,
    required this.profileRepository,
    required this.localViewModel,
    required this.sharedPreferenceHelper,
    required this.phoneNumber,
    required this.verifyModel,
  });

  final ProfileRepository profileRepository;
  final LocalViewModel localViewModel;
  final SharedPreferenceHelper sharedPreferenceHelper;

  String? phoneNumber;
  VerifyModel? verifyModel;

  String? radioValue = '';
  String subscribeSuccessfulTag = 'subscribeSuccessfulTag';
  TariffsModel tariffsList = TariffsModel();
  SubscribeModel subscribeModel = SubscribeModel();
  Future? dialog;

  void init() {
    safeBlock(
      () async {
        if (await locator<NetWorkChecker>().isNetworkAvailable()) {
          var tariffId = sharedPreferenceHelper.getInt(Constants.KEY_TARIFID, 0);
          subscribeModel = await profileRepository.subscribe(tariffId);
          sharedPreferenceHelper.putString(Constants.KEY_SUBSCRIBE, jsonEncode(subscribeModel));
          tariffsList = TariffsModel.fromJson(jsonDecode(sharedPreferenceHelper.getString(Constants.KEY_TARIFFS, "")));
          verifyModel ??= VerifyModel.fromJson(jsonDecode(sharedPreferenceHelper.getString(Constants.KEY_VERIFY, "")));
          setSuccess(tag: subscribeSuccessfulTag);
        } else {
          callBackError('Connection lost');
        }
      },
      callFuncName: 'init',
      tag: subscribeSuccessfulTag,
    );
  }

  onPayPressed() async {
    switch (radioValue) {
      case "click":
        openClick();
        break;
      case "payme":
        openPayme();
        break;
      case "paynet":
        showCustomDialog(
          context: context!,
          icon: Assets.icons.inform,
          iconColor: AppColors.accentLight,
          iconBackgroundColor: AppColors.error,
          title: "payment".tr(),
          positive: "Ok",
          onPositiveTap: () {
            Navigator.of(context!).pop();
          },
          contentText: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: SvgPicture.asset(
                  isDarkTheme ? Assets.icons.logoWhiteText : Assets.icons.logoBlueText,
                  height: 32.h,
                  fit: BoxFit.scaleDown,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Text(
                  'payment_full_descr'.tr(),
                  style: AppTextStyle.font12W500Normal
                      .copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: RichText(
                  text: TextSpan(
                      text: 'order_id'.tr(),
                      style: AppTextStyle.font12W500Normal
                          .copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
                      children: [
                        TextSpan(
                          text: subscribeModel.billingId.toString(),
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
                      text: 'selected_subs'.tr(),
                      style: AppTextStyle.font12W500Normal
                          .copyWith(color: isDarkTheme ? AppColors.lightGray : AppColors.darkGray),
                      children: [
                        TextSpan(
                          text: (tariffsList.name!.en ?? "Contact with developers").toUpperCase(),
                          style: AppTextStyle.font14W700Normal.copyWith(
                            color: AppColors.blue,
                          ),
                        ),
                      ]),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
        break;
    }
  }

  @override
  callBackBusy(bool value, String? tag) {
    if (dialog == null && isBusy(tag: tag)) {
      Future.delayed(Duration.zero, () {
        dialog = showLoadingDialog(context!);
      });
    }
  }

  @override
  callBackSuccess(value, String? tag) {
    if (dialog != null) {
      pop();
      dialog = null;
    }
  }

  @override
  callBackError(String text) {
    showTopSnackBar(
      Overlay.of(context!)!,
      CustomSnackBar.error(
        message: text,
      ),
    );
  }

  goToProfile() {
    navigateTo(Routes.profilePage, isRemoveStack: true);
  }

  void openClick() async {
    var isInstalled = await LaunchApp.isAppInstalled(
      androidPackageName: 'air.com.ssdsoftwaresolutions.clickuz',
      // iosUrlScheme: 'pulsesecure://',
    );
    if (isInstalled) {
      LaunchApp.openApp(
        androidPackageName: 'air.com.ssdsoftwaresolutions.clickuz',
        // iosUrlScheme: 'pulsesecure://',
      );
    } else {
      launchUrl(Uri.parse('${subscribeModel.click}/'));
    }
  }

  void openPayme() async {
    var isInstalled = await LaunchApp.isAppInstalled(
      androidPackageName: 'uz.dida.payme',
      // iosUrlScheme: 'pulsesecure://',
    );
    if (isInstalled) {
      LaunchApp.openApp(
        androidPackageName: 'air.com.ssdsoftwaresolutions.clickuz',
        // iosUrlScheme: 'pulsesecure://',
      );
    } else {
      launchUrl(Uri.parse('${subscribeModel.payme}/'));
    }
  }
}
