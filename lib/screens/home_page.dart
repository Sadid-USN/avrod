import 'dart:io';

import 'package:avrod/constant/animated_text.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/constant/navigeton_items.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:avrod/screens/home_body.dart';
import 'package:avrod/widgets/drawer_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static String routName = '/home';

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());

    return Scaffold(
      drawer: const DrawerModel(),
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        backgroundColor: const Color(0xffF2DFC7),
        title: MyanimetedText(
          title: 'avrod'.tr,
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: const HomeBody(),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: Platform.isIOS ? 65 : 50,
        index: controller.currrentIndexTab,
        backgroundColor: const Color(0xffF2DFC7),
        items: navItems,
        onTap: (index) {
          controller.onTapCurvedNavigationBar(index);
        },
      ),
    );
  }
}
