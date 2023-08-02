import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    FlutterNativeSplash.remove();
    super.onInit();
    validateTheme();
    Future.delayed(const Duration(seconds: 4), () {
      Get.offNamed('/home');
    });
  }

  void validateTheme() async {}
}
