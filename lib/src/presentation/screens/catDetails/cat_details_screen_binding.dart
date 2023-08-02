import 'package:get/get.dart';

import 'cat_details_screen_controller.dart';

class CardDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardDetailsController>(() => CardDetailsController());
  }
}
