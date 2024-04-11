import 'package:get/get.dart';
import 'package:sylph/app/backend/parse/splash_parse.dart';
import 'package:sylph/app/helper/database_helper.dart';

class SplashScreenController extends GetxController implements GetxService {
  final SplashScreenParse parser;

  SplashScreenController({required this.parser});

  @override
  void onInit() {
    super.onInit();

    _createDatabase();
  }

  void _createDatabase() async {
    DatabaseHelper dbhelper = DatabaseHelper();
    // await dbhelper.deleteDatabase();
    await dbhelper.initDatabase();
  }
}