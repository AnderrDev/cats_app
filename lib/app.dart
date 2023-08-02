import 'package:cats_app/src/config/app_router.dart';
import 'package:cats_app/src/config/app_theme.dart';
import 'package:cats_app/src/config/initial_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouter.splash,
      getPages: AppPages.pages,
      initialBinding: InitialBinding(),
    );
  }
}
