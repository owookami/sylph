import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sylph/app/helper/init.dart';
import 'package:sylph/app/helper/router.dart';
import 'package:sylph/app/util/constants.dart';
import 'package:sylph/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      color: ThemeProvider.appColor,
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      initialRoute: AppRouter.initial,
      getPages: AppRouter.routes,
      defaultTransition: Transition.native,
      theme: ThemeData(
        fontFamily: 'regular',
      ),
    );
  }
}
