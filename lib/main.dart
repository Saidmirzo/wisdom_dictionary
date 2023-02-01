import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:provider/provider.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/db/preference_helper.dart';

import 'config/constants/constants.dart';
import 'core/di/app_locator.dart';
import 'core/services/theme_preferences.dart';
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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MainProvider()),
        ],
        builder: (context, child) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (BuildContext context, Widget? child) {
              Provider.of<MainProvider>(context, listen: false).loadTheme();
              return Consumer<MainProvider>(
                builder: (BuildContext context, provider, Widget? child) {
                  return MaterialApp(
                    title: 'Wisdom Dictionary',
                    debugShowCheckedModeBanner: false,
                    navigatorKey: MyApp.navigatorKey,
                    localizationsDelegates: context.localizationDelegates,
                    supportedLocales: context.supportedLocales,
                    locale: context.locale,
                    onGenerateRoute: (setting) => Routes.generateRoutes(setting),
                  );
                },
              );
            },
          );
        });
  }
}

class MainProvider extends ChangeNotifier {
  ThemePreferences preferences = ThemePreferences();
  var isDark = true;
  loadTheme() async {
    isDark = await preferences.getTheme();
    isDarkTheme = isDark;
    notifyListeners();
  }

  changeToDarkTheme() async {
    if (!isDark) {
      await preferences.setTheme(true);
      isDark = true;
      isDarkTheme = isDark;
      notifyListeners();
    }
  }

  changeToLightTheme() async {
    if (isDark) {
      await preferences.setTheme(false);
      isDark = false;
      isDarkTheme = isDark;
      notifyListeners();
    }
  }
}
