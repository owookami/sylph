import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sylph/app/app/controller/HomeController.dart';
import 'package:sylph/app/widget/elevated_button.dart';
import 'package:sylph/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (value) {
        return Scaffold(
          // drawer: const NavBar(),
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            iconTheme: const IconThemeData(color: ThemeProvider.whiteColor),
            elevation: 0,
            centerTitle: true,
            title: GestureDetector(
              onTap: () {
                print("title click");
              },
              child: Text(
                "Sylph".tr,
                // value.title.toString(),
                overflow: TextOverflow.ellipsis,
                style: ThemeProvider.titleStyle,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height*0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            heading1('Sylph'.tr),
                            const SizedBox(height: 6,),
                            lightText('자동으로 통화 기록을 청소해주는 마법 같은 앱'.tr),
                            const SizedBox(height: 6,),
                            lightText('흔적을 남기지 않습니다.'.tr),
                            const SizedBox(height: 20,)
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: myBoxDecoration(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  decoration: textFieldDecoration(),
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      TextFormField(
                                        controller: value.phoneNumberController,
                                        onChanged: (String txt) {

                                        },
                                        cursorColor: ThemeProvider.appColor,
                                        decoration: InputDecoration(
                                          labelStyle: const TextStyle(
                                            fontSize: 14,
                                            color: ThemeProvider.greyColor,
                                          ),
                                          border: InputBorder.none,
                                          labelText: '0101231234'.tr,
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.blue,
                                          child: IconButton(
                                            icon: Icon(Icons.add, size: 20, color: Colors.white,),
                                            onPressed: () async{
                                              if(value.phoneNumberController.text.isNotEmpty) {
                                                await value.addPhoneNumber(value.phoneNumberController.text);
                                                value.phoneNumberController.text = '';
                                              } else {
                                                print('18');
                                                Get.snackbar('Error', '전화번호를 입력하세요.', snackPosition: SnackPosition.BOTTOM);
                                              }
                                            },
                                            padding: EdgeInsets.zero, // remove padding
                                            constraints: BoxConstraints(), //remove constraints
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12,),
                              MyElevatedButton(
                                onPressed: () async {
                                  var permissionStatus = await Permission.phone.request();

                                  if(permissionStatus.isGranted) {
                                    value.onStartPressed();
                                  } else {
                                    Get.snackbar('Error', '권한이 승인 되지 않았습니다.', snackPosition: SnackPosition.BOTTOM);
                                    print('Permission denied');
                                  }
                                },
                                color: ThemeProvider.appColor,
                                height: 45,
                                width: double.infinity,
                                child: Text(
                                  'Service Start'.tr,
                                  style: const TextStyle(
                                    letterSpacing: 1,
                                    fontSize: 16,
                                    color: ThemeProvider.whiteColor,
                                    fontFamily: 'bold',
                                  ),
                                ),

                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

          )
          /*body: Container(
            color: Colors.grey.shade300,
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8), // Adjust padding as needed
                  decoration: BoxDecoration(
                    color: Colors.grey[300], // Light background color
                    borderRadius: BorderRadius.circular(8), // Rounded corners for the container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple,
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(4,4),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: Offset(-4,-4),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _phonseNumberController,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      filled: true,
                      border: InputBorder.none, // Remove the default underline border
                      hintText: '0101231234',
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      if(_phonseNumberController.text.isNotEmpty) {
                        await value.addPhoneNumber(_phonseNumberController.text);
                        _phonseNumberController.text = '';
                      } else {
                        Get.snackbar('Error', '전화번호를 입력하세요.', snackPosition: SnackPosition.BOTTOM);
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(4,4),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(-4,-4),
                          ),
                        ]
                      ),
                      child: Center(
                        child: Text(
                          "전화번호 추가",
                          style: TextStyle(
                            color: ThemeProvider.appColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      var permissionStatus = await Permission.phone.request();

                      if(permissionStatus.isGranted) {
                        value.onStartPressed();
                      } else {
                        print('Permission denied');
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple,
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(4,4),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(-4,-4),
                            ),
                          ]
                      ),
                      child: Center(
                        child: Text(
                          "Start",
                          style: TextStyle(
                              color: ThemeProvider.appColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),*/
        );
      },
    );
  }


}


