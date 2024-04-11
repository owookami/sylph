import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sylph/app/app/controller/ContactUsController.dart';
import 'package:sylph/theme.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(
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
              '문의하기'.tr,
              style: ThemeProvider.titleStyle,
            )
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 40,),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: myBoxDecoration(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: textFieldDecoration(),
                          child: TextFormField(
                            controller: value.emailContact,
                            cursorColor: ThemeProvider.appColor,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                color: ThemeProvider.greyColor,
                              ),
                              border: InputBorder.none,
                              labelText: "이메일 주소를 입력 하세요.".tr,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: textFieldDecoration(),
                          child: TextFormField(
                            maxLines: 4,
                            controller: value.messageContact,
                            cursorColor: ThemeProvider.appColor,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                fontSize: 14,
                                color: ThemeProvider.greyColor,
                              ),
                              border: InputBorder.none,
                              labelText: "문의 또는 건의 사항을 입력 하세요".tr,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0.0,
                          vertical: 20,
                        ),
                        child: InkWell(
                          onTap: () {
                            value.saveContactUs();
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 13.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(50.0),
                              ),
                              color: ThemeProvider.appColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '문의하기',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'bold1',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
