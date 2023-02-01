
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/db/preference_helper.dart';

import 'app.dart';
import 'core/di/app_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupConfigs(() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setupLocator();
    await locator<DBHelper>().init();
    await locator<SharedPreferenceHelper>().getInstance();
    await EasyLocalization.ensureInitialized();
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('uz', 'UZ')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
    );
  }, appVersion: '1.0.0');
}

