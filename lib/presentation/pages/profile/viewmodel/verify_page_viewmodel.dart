import 'dart:html';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/profile_repository.dart';
import 'package:device_info/device_info.dart';

import '../../../../config/constants/constants.dart';

class VerifyPageViewModel extends BaseViewModel {
  VerifyPageViewModel({
    required super.context,
    required this.profileRepository,
    required this.localViewModel,
    required this.sharedPreferenceHelper,
    required this.phoneNumber,
  });

  final ProfileRepository profileRepository;
  final LocalViewModel localViewModel;
  final SharedPreferenceHelper sharedPreferenceHelper;
  String verifyTag = 'verifyTag';
  final String phoneNumber;

  void onNextPressed(String smsCode) {
    safeBlock(
      () async {
        String? deviceId = await PlatformDeviceId.getDeviceId;
        if (deviceId == null) {
          callBackError("Device Id not found");
        } else {
          var verifyModel = await profileRepository.verify(phoneNumber, smsCode, deviceId);
          if (verifyModel != null && verifyModel.status!) {
            sharedPreferenceHelper.putString(Constants.KEY_TOKEN, verifyModel.token!);
            sharedPreferenceHelper.putString(Constants.KEY_PHONE, phoneNumber);
            sharedPreferenceHelper.putInt(Constants.KEY_PROFILE_STATE, Constants.STATE_INACTIVE);

            // Adding device id into firebase Messaging to send notification message;

          }
        }
        // viewModel.navigateTo(Routes.paymentPage);
      },
      callFuncName: 'onNextPressed',
      inProgress: false,
    );
  }

  void onReSendPressed() {
    safeBlock(
      () async {
        var status = await profileRepository
            .login(phoneNumber.replaceAll('+', '').replaceAll(' ', '').replaceAll('(', '').replaceAll(')', ''));
        // if (status) {
        //   navigateTo(Routes.verifyPage, arg: {'number': telNumber});
        // }
      },
      callFuncName: 'onReSendPressed',
      inProgress: false,
    );
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
}
