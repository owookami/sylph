import 'package:get/get.dart';
import 'package:sylph/app/app/controller/SplashScreenController.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController(parser: Get.find()));
  }

}