import 'dart:io';

import 'package:avrod/screens/aboutapp_screen.dart';
import 'package:avrod/widgets/avrod_bunner.dart';
import 'package:avrod/widgets/watch/watch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import '../constant/colors/colors.dart';
import '../controller/homepage_controller.dart';

class DrawerModel extends StatefulWidget {
  const DrawerModel({Key? key}) : super(key: key);

  @override
  State<DrawerModel> createState() => _DrawerModelState();
}

class _DrawerModelState extends State<DrawerModel> {
  final String _azkarRuAppLink =
      'https://play.google.com/store/apps/details?id=com.darulasar.Azkar';

  final String _lounchUrlGmail =
      'https://accounts.google.com/signout/chrome/landing?continue=https://mail.google.com&oc=https://mail.google.com&hl=en';

  final String _linkInstagramm =
      'https://instagram.com/darul_asar?utm_medium=copy_link';

  final String _youTubeLink =
      'https://www.youtube.com/channel/UCR2bhAQKRXDmE4v_rDVNOrA';
  final String _supportLink = 'https://taplink.cc/avrod';

  final bool _light = true;

  final ThemeData _lightMode = ThemeData(
    brightness: Brightness.light,
    primaryColor: bgColor,
  );
  final ThemeData _darktMode = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xff112435),
  );

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());
    return Drawer(
      elevation: 30,
      backgroundColor: bgColor,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // ignore: sized_box_for_whitespace
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Lottie.asset(
                  'assets/animations/shine.json',
                  height: MediaQuery.of(context).size.height / 2 * 0.7,
                  width: MediaQuery.of(context).size.width,
                ),
                _HeaderWidget(context: context),
                const Watch(
                  fontSize: 20,
                ),
              ],
            ),
            // ListTile(
            //   title: Text(
            //     'lang'.tr,
            //     style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
            //   ),
            //   onTap: () {
            //     controller.goToLangugePage();
            //   },
            //   leading: const Icon(
            //     Icons.language,
            //     color: Color(0xff006064),
            //     size: 21,
            //   ),
            // ),
            ListTile(
              title: Text(
                'Darul-asar',
                style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
              ),
              onTap: () {
                Share.share(_youTubeLink);
              },
              leading: const Icon(
                FontAwesomeIcons.youtube,
                color: Colors.red,
                size: 21,
              ),
            ),

            ListTile(
              title: Text(
                '@darul_asar',
                style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
              ),
              onTap: () {
                Share.share(_linkInstagramm);
              },
              leading: const Icon(
                FontAwesomeIcons.instagram,
                color: Colors.pinkAccent,
                size: 21,
              ),
            ),
            ListTile(
              title: Text(
                'Оиди барнома',
                style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
              ),
              onTap: () {
                Get.toNamed(AboutAppScreen.routNaem);
              },
              leading: const Icon(
                Icons.info_outline,
                color: Colors.blueGrey,
                size: 22,
              ),
            ),

            // ListTile(
            //   title: Text(
            //     'support'.tr,
            //     style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
            //   ),
            //   onTap: () {
            //     Get.toNamed(SupportScreen.routNaem);

            //     //   Share.share(_supportLink);
            //   },
            //   leading: const Icon(
            //     FontAwesomeIcons.donate,
            //     color: Colors.blueGrey,
            //     size: 22,
            //   ),
            // ),
            ListTile(
              title: Text(
                'Ба дигарон ирсол кунед',
                style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
              ),
              onTap: () {
                if (Platform.isAndroid) {
                  Share.share(
                      'Барномаи «Avrod» дуоҳои саҳеҳи набави (ﷺ) бо забони тоҷикӣ, ба дустону наздикони худ равон кунед, чун роҳнамоӣ ба амали хайр дар савоб монанди анҷомдиҳандаи он аст.\nhttps://play.google.com/store/apps/details?id=com.darulasar.avrod');
                } else {
                  Share.share(
                      'Барномаи «Avrod» дуоҳои саҳеҳи набави (ﷺ) бо забони тоҷикӣ, ба дустону наздикони худ равон кунед, чун роҳнамоӣ ба амали хайр дар савоб монанди анҷомдиҳандаи он аст.\nhttps://apps.apple.com/ru/app/avrod/id1626614344?l=en');
                }
              },
              leading: const Icon(
                Icons.share,
                color: Colors.blueGrey,
                size: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  final BuildContext context;
  const _HeaderWidget({Key? key, required this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: bgColor,
      child: Padding(
        padding: EdgeInsets.only(top: 70),
        child: AvrodBunner(
          height: 160,
          width: 160,
          borderRadius: 100,
        ),
      ),
    );
  }
}
