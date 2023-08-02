import 'package:get/get.dart';

import '../presentation/screens/catDetails/cat_details_screen_controller.dart';
import '../presentation/screens/home/home_controller.dart';
import '../presentation/screens/splash/splash_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<CardDetailsController>(() => CardDetailsController(),
        fenix: true);
  }
}
