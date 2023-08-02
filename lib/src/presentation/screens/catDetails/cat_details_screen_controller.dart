import 'package:get/get.dart';

class CardDetailsController extends GetxController {
  CardDetailsController();

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}
