import 'dart:io';

import 'package:avrod/constant/animated_text.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/constant/navigeton_items.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:avrod/screens/favorite_chapter_screen.dart';
import 'package:avrod/screens/home_body.dart';
import 'package:avrod/screens/on_board_screen.dart';
import 'package:avrod/screens/radioplayer_screen.dart';
import 'package:avrod/widgets/drawer_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../booksScreen/library_screen.dart';
import '../controller/audio_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static String routName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AudioController audioController = Get.put(AudioController());
    HomePageController controller = Get.put(HomePageController());

    List<Widget> pages = [
      const HomeBody(),
      const LibraryScreen(),
      const FavoriteChaptersScreen(),
      const RadioPlayerScreen(),
      const OnBoard()
    ];
    return Scaffold(
      drawer: const DrawerModel(),
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        backgroundColor: const Color(0xffF2DFC7),
        title: const MyanimetedText(
          title: 'Авроди субҳу шом',
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: const [
          // Padding(
          //   padding: const EdgeInsets.only(right: 10),
          //   child: IconButton(onPressed: (){
          //       controller.goToLangugePage();

          //   }, icon: const Icon(Icons.language)),
          // )
        ],
      ),
      body: GetBuilder<AudioController>(
        builder: (_) {
          return pages[audioController.selectedIndex];
        },
      ),

      // const HomeBody(),
      bottomNavigationBar: GetBuilder<AudioController>(
        builder: (_) => CurvedNavigationBar(
          animationDuration: const Duration(milliseconds: 500),
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          height: Platform.isIOS ? 65 : 50,
          index: audioController.selectedIndex,
          backgroundColor: const Color(0xffF2DFC7),
          items: navItems,
          onTap: (index) {
            audioController.onTapBar(index);
          },
        ),
      ),
    );
  }
}
