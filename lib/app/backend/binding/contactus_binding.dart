import 'package:get/get.dart';
import 'package:sylph/app/app/controller/ContactUsController.dart';

class ContactUsBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsController(parser: Get.find()));
  }

}