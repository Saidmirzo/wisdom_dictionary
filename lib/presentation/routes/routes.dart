import 'package:flutter/material.dart';
import 'package:new_exercise/presentation/pages/main_page.dart';

class Routes {
  static const mainPage = '/';

  static Route<dynamic> generateRoutes(RouteSettings routeSettings) {
    try {
      final Map<String, dynamic>? args = routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};

      switch (routeSettings.name) {
        case mainPage:
          return MaterialPageRoute(
            builder: (_) => const MainPage(),
          );

        default:
          return MaterialPageRoute(
            settings: routeSettings,
            builder: (_) => const MainPage(),
          );
      }
    } catch (e) {
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainPage(),
      );
    }
  }
}
