import 'package:cats_app/src/presentation/screens/splash/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          backgroundColor: const Color(0x00030a1a),
          body: Center(
              child: Image.asset(
            'assets/splash/splash_ico.png',
            width: 200,
            height: 200,
          )),
        );
      },
    );
  }
}
