import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sylph/app/app/controller/TabsController.dart';
import 'package:sylph/app/view/homse_screen.dart';
import 'package:sylph/theme.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabsController>(
      builder: (value) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: (TabBar(
              controller: value.tabController,
              labelColor: ThemeProvider.appColor,
              unselectedLabelColor: const Color.fromARGB(255, 285, 196, 207),
              indicatorColor: Colors.transparent,
              labelPadding: const EdgeInsets.symmetric(horizontal: 0),
              labelStyle: const TextStyle(
                fontFamily: 'regular',
                fontSize: 12,
              ),
              onTap: (int index) => value.updateTabId(index),
              tabs: [
                Tab(
                  icon: Icon(
                    value.currentIndex != 0 ? Icons.home_outlined : Icons.home_sharp,
                    color: value.currentIndex == 0 ? ThemeProvider.appColor : const Color.fromARGB(255, 185, 196, 207),
                  ),
                  text: 'Home'.tr,
                ),
                Tab(
                  icon: Icon(
                    value.currentIndex != 1 ? Icons.history_outlined : Icons.history,
                    color: value.currentIndex == 1 ? ThemeProvider.appColor : const Color.fromARGB(255, 185, 196, 207),
                  ),
                  text: 'History'.tr,
                ),
              ],
            )),
            body: TabBarView(
              controller: value.tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                HomeScreen(),
                HomeScreen(),
              ],
            ),
          ),
        );
      },
    );
  }
}

