import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sylph/app/app/controller/HomeController.dart';
import 'package:sylph/app/app/controller/TabsController.dart';
import 'package:sylph/app/backend/api/api.dart';
import 'package:sylph/app/backend/parse/home_parse.dart';
import 'package:sylph/app/backend/parse/splash_parse.dart';
import 'package:sylph/app/backend/parse/tabs_parse.dart';
import 'package:sylph/app/env.dart';
import 'package:sylph/app/helper/SharedPreferencesManager.dart';

class MainBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final sharedPref = await SharedPreferences.getInstance();

    Get.put(
      SharedPreferencesManager(sharedPreferences: sharedPref)
    );

    Get.lazyPut(() => ApiService(appBaseUrl: Environments.apiBaseURL));

    Get.lazyPut(() => SplashScreenParse(sharedPreferencesManager: Get.find(), apiService: Get.find()));
    Get.lazyPut(() => TabsParser(sharedPreferencesManager: Get.find(), apiService: Get.find()),fenix: true);
    Get.lazyPut(() => HomeParse(sharedPreferencesManager: Get.find(), apiService: Get.find()),fenix: true);

    Get.lazyPut(() => TabsController(parser: Get.find()),fenix: true);
    Get.lazyPut(() => HomeController(parser: Get.find()),fenix: true);


  }

}