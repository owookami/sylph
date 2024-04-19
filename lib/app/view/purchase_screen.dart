import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:sylph/app/app/controller/PurchaseController.dart';
import 'package:sylph/app/widget/elevated_button.dart';
import 'package:sylph/theme.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({Key? key}) : super(key: key);

  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
        builder: (value) {
          return Scaffold(
            backgroundColor: ThemeProvider.backgroundColor,
            appBar: AppBar(
              backgroundColor: ThemeProvider.appColor,
              iconTheme: const IconThemeData(
                color: ThemeProvider.whiteColor,
              ),
              elevation: 0,
              centerTitle: true,
              title: Text(
                'App 구매',
                style: ThemeProvider.titleStyle,
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                    ),
                    decoration: myBoxDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 190,
                          child: Image.asset(
                            'assets/images/ThirdScreen1.png',
                            width: double.infinity,
                            height: 190,
                            fit: BoxFit.cover,
                          )
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        bodyText1('통화 종료의 흔적이 남지 않습니다.'),
                        const SizedBox(
                          height: 16,
                        ),
                        bodyText1('전화를 끊으면 지우고, 비밀을 유지해 줍니다.'),
                        const SizedBox(
                          height: 16,
                        ),
                        bodyText1('통화 기록을 자동 삭제하고 평화를 유지하세요.'),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '3,300원',
                          style: const TextStyle(
                            color: ThemeProvider.appColor,
                            fontFamily: 'bold',
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  right: 8
                                ),
                                child: MyElevatedButton(
                                  onPressed: () {
                                    value.buyProduct(value.products.first);
                                  },
                                  color: ThemeProvider.appColor,
                                  height: 45,
                                  width: double.infinity,
                                  child: Text(
                                    '구매하기',
                                    style: const TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 16,
                                      color: ThemeProvider.whiteColor,
                                      fontFamily: 'bold',
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
      },
    );
  }
}

