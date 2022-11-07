import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jbaza/jbaza.dart';
import 'package:new_exercise/presentation/routes/routes.dart';

import 'config/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupConfigs(() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Hive.registerAdapter<CompanyModel>(CompanyModelAdapter());
    // setupLocator();
    // initializeTimeZones();    timezone: ^0.9.0
    runApp(const MyApp());
  }, appVersion: '1.0.0');
  runApp(const MyApp());
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
    return MaterialApp(
      title: 'Flutter demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      navigatorKey: navigatorKey,
      // supportedLocales: const <Locale>[Locale('en', '')],
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      onGenerateRoute: (setting) => Routes.generateRoutes(setting),
    );
  }
}
