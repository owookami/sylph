import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sylph/app/backend/parse/home_parse.dart';
import 'package:sylph/app/helper/database_helper.dart';

class HomeController extends GetxController implements GetxService {
  final HomeParse parser;

  static const platform = MethodChannel('com.vs.sylph.sylph/callLog');

  bool apiCalled = false;
  String title = '';

  final phoneNumberController = TextEditingController();

  HomeController({required this.parser});

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> addPhoneNumber(String phoneNumber) async {
    Map<String, dynamic> data = {'PhoneNumber': phoneNumber};

    try{
      await DatabaseHelper().insert(data, 'Phone');
      Get.snackbar('Success','전화번호가 추가 되었습니다.', snackPosition: SnackPosition.BOTTOM);
    } catch(e) {
      print(e);
      Get.snackbar('Fail','전화번호 추가가 실패하였습니다..', snackPosition: SnackPosition.BOTTOM);
    }

  }

  /*Future<void> onStartPressed() async {
    List<String> phoneNumbers = await fetchPhoneNumbersFromDatabase();
    await deleteMatchingCllLogs(phoneNumbers);
  }*/

  Future<void> onStartPressed() async {
    //로컬에 저장 되어있는 전화 번호 목록을 가져 온다.
    List<String> phoneNumbers = await fetchPhoneNumbersFromDatabase();

    // Send the list to the Android side to start background monitoring and potential deletion of call logs.
    try {

      //background로 app 이동하여, 전화 통화 상태 모니터링 시작
      await platform.invokeMethod('startMonitoringCalls', {'phoneNumbers': phoneNumbers});
      Get.snackbar('Success', 'Monitoring started.', snackPosition: SnackPosition.BOTTOM);
      //flutter 앱을 백그라운드로 이동
      await platform.invokeMethod('moveTaskToBack');
    } on PlatformException catch (e) {
      Get.snackbar('Error', 'Failed to start monitoring: ${e.message}', snackPosition: SnackPosition.BOTTOM);
    }
  }


  Future<List<String>> fetchPhoneNumbersFromDatabase() async {
    List<String> phoneNumbers = [];
    List<Map<String, dynamic>> results = await DatabaseHelper().query('Phone');
    try {
      for(var result in results) {
        if(result.containsKey('PhoneNumber')){
          print(result['PhoneNumber']);
          phoneNumbers.add(result['PhoneNumber']);
        }
      }
    } catch (e) {
      print('Error fetching phone numbers from database: $e');
    }
    return phoneNumbers;
  }

  Future<void> deleteMatchingCllLogs(List<String> phoneNumbers) async {

    try {
      for(String number in phoneNumbers) {
        number = number.replaceAll("[^0-9]", "");
        print(number.toString());
        await platform.invokeMethod('deleteCallLogByNumber', {'phoneNumber': number})
        .then((result) {
          //Handle Success
          print(result); // "Call log deleted successfully."
        })
        .catchError((error){
          //Handle Error
          print(error);
        });
      }
      print("Call logs deletion succesful.");
    } on PlatformException catch (e) {
      print("Failed to delete call logs: '${e.message}'." );
      Get.snackbar('Fail','${e.message}.', snackPosition: SnackPosition.BOTTOM);
    }
  }





}

