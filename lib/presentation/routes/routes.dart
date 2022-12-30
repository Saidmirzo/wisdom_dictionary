import 'package:flutter/material.dart';
import 'package:wisdom/presentation/pages/home/view/home_page.dart';
import 'package:wisdom/presentation/pages/spalsh/view/splash_page.dart';

class Routes {
  static const mainPage = '/';

  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    try {
      final Map<String, dynamic>? args = routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case mainPage:
          return MaterialPageRoute(
            builder: (_) => HomePage(),
          );
        default:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => SplashPage(),
          );
      }
    } catch (e) {
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SplashPage(),
      );
    }
  }
}
