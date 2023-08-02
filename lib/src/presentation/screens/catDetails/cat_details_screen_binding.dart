import 'package:get/get.dart';

import 'cat_details_screen_controller.dart';

class CatDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CatDetailsController>(() => CatDetailsController());
  }
}
