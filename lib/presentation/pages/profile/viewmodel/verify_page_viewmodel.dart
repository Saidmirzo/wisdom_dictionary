import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/data/model/verify_model.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:wisdom/domain/repositories/home_repository.dart';
import 'package:wisdom/domain/repositories/profile_repository.dart';

import '../../../../config/constants/constants.dart';
import '../../../routes/routes.dart';
import '../../../widgets/loading_widget.dart';

class VerifyPageViewModel extends BaseViewModel {
  VerifyPageViewModel({
    required super.context,
    required this.profileRepository,
    required this.localViewModel,
    required this.sharedPreferenceHelper,
    required this.homeRepository,
    required this.phoneNumber,
  });

  final ProfileRepository profileRepository;
  final LocalViewModel localViewModel;
  final SharedPreferenceHelper sharedPreferenceHelper;
  final HomeRepository homeRepository;
  String verifyTag = 'verifyTag';
  final String phoneNumber;
  Future? dialog;

  void onNextPressed(String smsCode) {
    safeBlock(
      () async {
        String? deviceId = await PlatformDeviceId.getDeviceId;
        if (deviceId == null) {
          callBackError("Device Id not found");
        } else {
          var verifyModel = await profileRepository.verify(
              phoneNumber.replaceAll('+', '').replaceAll(' ', '').replaceAll('(', '').replaceAll(')', ''),
              smsCode,
              deviceId);
          if (verifyModel != null && verifyModel.status!) {
            sharedPreferenceHelper.putString(Constants.KEY_TOKEN, verifyModel.token!);
            sharedPreferenceHelper.putString(Constants.KEY_PHONE, phoneNumber);
            sharedPreferenceHelper.putInt(Constants.KEY_PROFILE_STATE, Constants.STATE_INACTIVE);
            sharedPreferenceHelper.putString(Constants.KEY_VERIFY, jsonEncode(verifyModel));

            // Adding device id into firebase Messaging to send notification message;
            var tokenF = await FirebaseMessaging.instance.getToken();
            addDeviceToFirebase(verifyModel, tokenF);
            setSuccess();
          }
        }
      },
      callFuncName: 'onNextPressed',
      inProgress: true,
    );
  }

  void addDeviceToFirebase(VerifyModel verifyModel, String? tokenF) {
    safeBlock(
      () async {
        var status = await profileRepository.applyFirebaseId(tokenF!);
        if (status) {
          var subscribeModel = await homeRepository.checkSubscription();
          if (subscribeModel != null && subscribeModel.status!) {
            if (subscribeModel.expiryStatus!) {
              var tariffId = sharedPreferenceHelper.getInt(Constants.KEY_TARIFID, 0);
              profileRepository.subscribe(tariffId).then((value) {
                sharedPreferenceHelper.putString(Constants.KEY_SUBSCRIBE, jsonEncode(subscribeModel));
                localViewModel.profileState = Constants.STATE_ACTIVE;
                sharedPreferenceHelper.putInt(Constants.KEY_PROFILE_STATE, Constants.STATE_ACTIVE);
                navigateTo(Routes.profilePage, isRemoveStack: true);
              });
            } else {
              localViewModel.profileState = Constants.STATE_INACTIVE;
              sharedPreferenceHelper.putInt(Constants.KEY_PROFILE_STATE, Constants.STATE_INACTIVE);
              navigateTo(Routes.paymentPage,
                  arg: {'verifyModel': verifyModel, 'phoneNumber': phoneNumber}, isRemoveStack: true);
            }
          }
        }
        setSuccess();
      },
      callFuncName: 'addDeviceToFirebase',
      inProgress: true,
    );
  }

  void onReSendPressed() {
    safeBlock(
      () async {
        await profileRepository
            .login(phoneNumber.replaceAll('+', '').replaceAll(' ', '').replaceAll('(', '').replaceAll(')', ''));
      },
      callFuncName: 'onReSendPressed',
      inProgress: false,
    );
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
}
