import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sylph/app/app/controller/ProfileController.dart';
import 'package:sylph/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController> (
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.backgroundColor,
          appBar: AppBar(
            backgroundColor: ThemeProvider.appColor,
            elevation: 0,
            centerTitle: true,
            title: Text('My Account'.tr, style: ThemeProvider.titleStyle,),
          ),
          body: SingleChildScrollView(
            physics: const ScrollPhysics(),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                const SizedBox(height: 24,),
                Card(
                  child: ListTile(
                    onTap: () {

                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.payment_outlined),
                    minLeadingWidth: 0,
                    title: heading4('구독 설정'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                /*Card(
                  child: ListTile(
                    onTap: () {
                      // value.onAppPages('이용 약관'.tr, '5');
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.help_outline),
                    minLeadingWidth: 0,
                    title: heading4('도움말'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),*/
                /*Card(
                  child: ListTile(
                    onTap: () {

                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.lock_open_outlined),
                    minLeadingWidth: 0,
                    title: heading4('이용 약관'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),*/
                Card(
                  child: ListTile(
                    onTap: () {

                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.privacy_tip_outlined),
                    minLeadingWidth: 0,
                    title: heading4('사용 설명'.tr),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
                Card(
                  child: ListTile(
                    onTap: () {
                      value.onContactUs();
                    },
                    visualDensity: const VisualDensity(vertical: -3),
                    leading: const Icon(Icons.contact_mail_outlined),
                    minLeadingWidth: 0,
                    title: heading4('문의 하기'.tr),
                    trailing: const Icon(Icons.chevron_right),
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
