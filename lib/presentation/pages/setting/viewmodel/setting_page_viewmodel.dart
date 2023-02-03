import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:jbaza/jbaza.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:wisdom/core/db/preference_helper.dart';
import 'package:wisdom/core/domain/entities/def_enum.dart';
import 'package:workmanager/workmanager.dart';

import '../../../../core/di/app_locator.dart';
import '../../../../core/services/local_notification_service.dart';

class SettingPageViewModel extends BaseViewModel {
  SettingPageViewModel({required super.context, required this.preferenceHelper});

  RemindOption currentRemind = RemindOption.manual;
  ThemeOption currentTheme = ThemeOption.day;
  LanguageOption currentLang = LanguageOption.uzbek;
  final SharedPreferenceHelper preferenceHelper;
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

  Future<void> scheduleNotification(TimeOfDay timeOfDay) async {
    await locator<LocalNotificationService>().cancelAll();
    await locator<LocalNotificationService>()
        .scheduleNotification(
      id: 0,
      title: "Wisdom Dictionary",
      body: "So'z eslatuvchi ${timeOfDay.hour} : ${timeOfDay.minute}",
      time: timeOfDay,
    )
        .then((value) {
      showTopSnackBar(
        Overlay.of(context!)!,
        const CustomSnackBar.success(
          message: "So'z eslatuvchi saqlandi",
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
    // await locator<LocalNotificationService>()
    //     .createNotification(
    //   id: 0,
    //   title: "Wisdom Dictionary",
    //   body: "So'z eslatuvchi har $currentRepeatHourValue soatda bildiriladi",
    // ).then((value) {
    //   showTopSnackBar(
    //     Overlay.of(context!)!,
    //     CustomSnackBar.success(
    //       message: "So'z eslatuvchi har $currentRepeatHourValue soatga saqlandi",
    //     ),
    //   );
    // });
  }
}
