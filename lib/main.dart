import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/db/preference_helper.dart';

import 'config/theme/themes.dart';
import 'core/di/app_locator.dart';
import 'presentation/routes/routes.dart';

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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var widgetKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
              title: 'Wisdom Dictionary',
              debugShowCheckedModeBanner: false,
              theme: Themes.lightTheme,
              navigatorKey: MyApp.navigatorKey,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              onGenerateRoute: (setting) => Routes.generateRoutes(setting),
            );
      },
    );
  }
}
