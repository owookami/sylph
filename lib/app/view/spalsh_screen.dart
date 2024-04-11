import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sylph/app/app/controller/SplashScreenController.dart';
import 'package:sylph/app/helper/router.dart';
import 'package:sylph/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.whiteColor,
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon.png',
                  fit: BoxFit.cover,
                  height: 150,
                  width: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Please Wait'.tr,
                  style: const TextStyle(
                    color: ThemeProvider.appColor,
                    fontFamily: 'bold',
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _routing();
  }

  Future<void> _routing() async {
    await Future.delayed(Duration(seconds: 3));

    Get.offNamed(AppRouter.getTabRoute());
  }
}
