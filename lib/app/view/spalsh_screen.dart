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

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

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
                RotationTransition(
                  turns: _animation,
                  child: Image.asset(
                    'assets/images/icon.png',
                    fit: BoxFit.cover,
                    height: 150,
                    width: 150,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // const CircularProgressIndicator(
                //   color: ThemeProvider.appColor,
                // ),
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

    //로고 360도 회전
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); // This ensures the animation continues indefinitely

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _routing();
  }


  @override
  void dispose() {
    _controller.dispose(); //콘트롤러 삭제를 잊으면 안됨
    super.dispose();
  }

  Future<void> _routing() async {
    await Future.delayed(Duration(seconds: 3));

    Get.offNamed(AppRouter.getTabRoute());
  }
}
