import 'package:get/get.dart';
import 'package:sylph/app/app/controller/PurchaseController.dart';

class PurchaseBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseController(parser: Get.find()));
  }

}