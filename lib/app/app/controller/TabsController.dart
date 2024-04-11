import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sylph/app/backend/parse/tabs_parse.dart';


class TabsController extends GetxController with GetTickerProviderStateMixin implements GetxService {
  final TabsParser parser;

  int currentIndex = 0 ;
  String title = '';
  late TabController tabController;

  TabsController({required this.parser});

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: currentIndex,
    );
  }

  void updateTabId(int id) {
    currentIndex = id;
    tabController.animateTo(currentIndex);
    update();
  }
}