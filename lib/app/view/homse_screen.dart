import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sylph/app/app/controller/HomeController.dart';
import 'package:sylph/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _phonseNumberController = TextEditingController();
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
          body: Container(
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
          ),
        );
      },
    );
  }
}
