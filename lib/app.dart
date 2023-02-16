import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'config/constants/constants.dart';
import 'core/services/theme_preferences.dart';
import 'presentation/routes/routes.dart';

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
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: child!,
                );
              },
              onGenerateRoute: (setting) => Routes.generateRoutes(setting),
            );
          },
        );
      },
    );
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
