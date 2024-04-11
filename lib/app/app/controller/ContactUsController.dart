import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:sylph/app/backend/parse/contact_us_parse.dart';
import 'package:sylph/app/util/toast.dart';

class ContactUsController extends GetxController implements GetxService {
  final ContactUsParse parser;

  String title = '문의하기';

  final nameContact = TextEditingController();
  final emailContact = TextEditingController();
  final messageContact = TextEditingController();

  ContactUsController({required this.parser});

  Future<void> saveContactUs() async {
    if( emailContact.text == '') {
      showToast('이메일을 입력하세요'.tr);
    }
    if( messageContact.text == '') {
      showToast('문의 또는 건의 내용을 입력하세요.'.tr);
    }

    if(!GetUtils.isEmail(emailContact.text)) {
      showToast('이메일이 형식에 맞지 않습니다.'.tr);
      return;
    }
    /*update();
    DateTime now = DateTime.now();
    String ymd = now.toIso8601String().split('T').first;*/

    final Email email = Email(
      body: messageContact.text,
      subject: 'Sylph - 문의 사항'.tr,
      recipients: ['zanedutainment@gmail.com'],
      isHTML: false,
    );

    try {
      await FlutterEmailSender.send(email);
      emailContact.text = '';
      messageContact.text = '';
      showToast('이메일이 발송 되었습니다.'.tr);
    } catch (e) {
      showToast('이메일 발송에 실패 하였습니다.'.tr);
      print(e.toString());
    }
  }
}