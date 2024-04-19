import 'package:get/get.dart';
import 'package:sylph/app/app/controller/ContactUsController.dart';
import 'package:sylph/app/app/controller/PurchaseController.dart';
import 'package:sylph/app/backend/parse/profile_parse.dart';
import 'package:sylph/app/helper/router.dart';

class ProfileController extends GetxController implements GetxService {
  final ProfileParse parser;

  ProfileController({required this.parser});

  void onContactUs() {
    Get.delete<ContactUsController>(force: true);
    Get.toNamed(AppRouter.getContactUsRoute());
  }

  void purchase() {
    Get.delete<PurchaseController>(force: true);
    Get.toNamed(AppRouter.getPurchaseRoute());
  }

  /*void onAppPages(String tr, String s) {
    Get.delete<AppPageController>(force: true);
    Get.toNamed(AppRouter.getAppPageRoute(), arguments: [name, id], preventDuplicates: false);
  }*/


}