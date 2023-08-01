import 'package:cats_app/src/config/app_router.dart';
import 'package:cats_app/src/config/app_theme.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRouter.getRoutes(),
      onGenerateRoute: AppRouter.generateRoutes,
    );
  }
}
