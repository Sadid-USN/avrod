import 'package:avrod/constant/animated_text.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/constant/navigeton_items.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:avrod/screens/chapter_screen.dart';
import 'package:avrod/widgets/drawer_widget.dart';
import 'package:avrod/widgets/path_of_images.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'dart:io' show Platform;

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
        actions: [
          IconButton(
            onPressed: () {
              controller.goToLangugePage();
            },
            icon: const Icon(
              Icons.language,
              color: Color(0xff006064),
            ),
          ),
        ],
        backgroundColor: const Color(0xffF2DFC7),
        title: const ListTile(
          title: Center(
            child: MyanimetedText(),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimationLimiter(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 1.3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              crossAxisCount: 3,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 400),
                      columnCount: images.length,
                      child: FlipAnimation(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ChapterScreen(
                              indexChapter: index,
                            ));
                          },
                          child: Image.asset(
                            images[index].pathImages,
                            height: 110,
                            width: 110,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      images[index].name.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 10,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
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
