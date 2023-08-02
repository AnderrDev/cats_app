import 'package:cats_app/src/infrastructure/models/the_cat_api_response.dart';
import 'package:get/get.dart';

class CatDetailsController extends GetxController {
  late CatData catData;
  set setCatData(CatData catData) => this.catData = catData;
  CatData get getCatData => catData;

  @override
  void onInit() {
    super.onInit();
    setCatData = Get.arguments;
    update();
  }
}
