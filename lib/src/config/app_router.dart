import 'package:cats_app/src/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String first = '/';

  static const routes = <Map<String, dynamic>>[
    //ChekAuthScreen
    {
      'route': '/',
      'screen': HomeScreen(),
    },
  ];

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    for (var route in routes) {
      appRoutes[route['route']] = (context) => route['screen'];
    }
    return appRoutes;
  }

  // Generator of routes
  static Route generateRoutes(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const HomeScreen(),
    );
  }
}
