import 'package:cats_app/src/presentation/screens/catDetails/cat_details_screen.dart';
import 'package:cats_app/src/presentation/screens/home/home_screen.dart';
import 'package:get/get.dart';

import '../presentation/screens/catDetails/cat_details_screen_binding.dart';
import '../presentation/screens/home/home_binding.dart';
import '../presentation/screens/splash/splash_binding.dart';
import '../presentation/screens/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String catDetails = '/catDetails';
}

class AppPages {
  static final pages = [
    GetPage(
      name: AppRouter.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRouter.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRouter.catDetails,
      page: () => const CatDetailsScreen(),
      binding: CatDetailsBinding(),
    ),
  ];
}
