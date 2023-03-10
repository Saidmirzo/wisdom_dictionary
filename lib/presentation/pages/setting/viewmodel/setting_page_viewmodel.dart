import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wisdom/config/constants/constants.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/core/domain/entities/def_enum.dart';
import 'package:wisdom/data/viewmodel/local_viewmodel.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../core/services/local_notification_service.dart';
import '../../../routes/routes.dart';

class SettingPageViewModel extends BaseViewModel {
  SettingPageViewModel(
      {required super.context,
      required this.preferenceHelper,
      required this.localViewModel,
      required this.sharedPreferenceHelper});

  RemindOption currentRemind = RemindOption.manual;
  ThemeOption currentTheme = ThemeOption.day;
  LanguageOption currentLang = LanguageOption.uzbek;
  final SharedPreferenceHelper preferenceHelper;
  final LocalViewModel localViewModel;
  final SharedPreferenceHelper sharedPreferenceHelper;
  int currentHourValue = 1;
  int currentMinuteValue = 0;
  int currentRepeatHourValue = 1;
  double fontSizeValue = 12;

  changeFontSize(double value) {
    fontSizeValue = value;
    preferenceHelper.putDouble(preferenceHelper.fontSize, value);
    notifyListeners();
  }

  void init() {
    safeBlock(() async {
      fontSizeValue = preferenceHelper.getDouble(preferenceHelper.fontSize, 16);
      setSuccess();
    }, callFuncName: 'init', inProgress: false);
  }

  void goToByPro() {
    var token = sharedPreferenceHelper.getString(Constants.KEY_TOKEN, '');
    if (token == '') {
      navigateTo(Routes.gettingProPage);
    } else {
      navigateTo(Routes.profilePage);
    }
  }

  Future<void> scheduleNotification(TimeOfDay timeOfDay) async {
    await locator<LocalNotificationService>().cancelAll();
    await locator<LocalNotificationService>()
        .scheduleNotification(
      id: 0,
      title: "notif_name".tr(),
      body: "notif_text".tr(),
      time: timeOfDay,
    )
        .then((value) {
      showTopSnackBar(
        Overlay.of(context!)!,
        CustomSnackBar.success(
          message: "reminder_save".tr(),
        ),
      );
    });
  }

  Future<void> scheduleAutomaticNotification() async {
    await locator<LocalNotificationService>().cancelAll();
    try {
      Workmanager().registerPeriodicTask(
        "unique_name",
        "notification",
        frequency: Duration(hours: currentRepeatHourValue),
        inputData: {
          "title": "Wisdom Dictionary",
          "body": "So'z eslatuvchi har $currentRepeatHourValue soatda bildiriladi",
        },
      );
      log("left");
    } catch (e) {
      log("top");
      log(e.toString());
    }
  }
}
