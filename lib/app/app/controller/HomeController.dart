import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sylph/app/backend/parse/home_parse.dart';
import 'package:sylph/app/helper/database_helper.dart';

class HomeController extends GetxController implements GetxService {
  final HomeParse parser;

  static const platform = MethodChannel('com.vs.sylph.sylph/callLog');

  bool apiCalled = false;
  String title = '';

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

  Future<void> onStartPressed() async {
    List<String> phoneNumbers = await fetchPhoneNumbersFromDatabase();
    await deleteMatchingCllLogs(phoneNumbers);
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

