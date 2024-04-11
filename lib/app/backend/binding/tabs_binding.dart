import 'package:get/get.dart';
import 'package:sylph/app/app/controller/TabsController.dart';

class TabsBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => TabsController(parser: Get.find()), fenix: true);
  }
}