import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jbaza/jbaza.dart';
import 'package:wisdom/core/db/db_helper.dart';
import 'package:wisdom/core/db/preference_helper.dart';

import 'config/theme/themes.dart';
import 'core/di/app_locator.dart';
import 'core/services/push_notifications_service.dart';
import 'presentation/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationService().setupInteractedMessage();
  setupConfigs(() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    setupLocator();
    await locator<DBHelper>().init();
    await locator<SharedPreferenceHelper>().getInstance();

    runApp(const MyApp());
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: "channelGroupKey",
          channelKey: "channelKey",
          channelName: "channelName",
          channelDescription: "channelDescription",
          defaultColor: Colors.green,
          ledColor: Colors.lime,
        ),
      ],
    );
  }, appVersion: '1.0.0');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //     statusBarBrightness: Brightness.dark,
    //     statusBarIconBrightness: Brightness.dark));
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          title: 'Wisdom Dictionary',
          debugShowCheckedModeBanner: false,
          theme: Themes.lightTheme,
          navigatorKey: navigatorKey,
          // supportedLocales: const <Locale>[Locale('en', '')],
          // localizationsDelegates: const [
          //   GlobalMaterialLocalizations.delegate,
          //   GlobalWidgetsLocalizations.delegate,
          //   GlobalCupertinoLocalizations.delegate,
          // ],
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
  }
}
