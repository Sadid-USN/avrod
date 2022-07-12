import 'dart:async';
import 'dart:io';
import 'package:avrod/widgets/watch/watch.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant/colors/colors.dart';

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

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'header_key': 'header_value'});
    } else {
      throw 'Пайванд кушода нашуд $url';
    }
  }

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
                  // fit: BoxFit.cover,

                  width: MediaQuery.of(context).size.width,
                ),
                _header(context),
                const Watch(
                  fontSize: 20,
                ),
              ],
            ),

            ListTile(
              title: Text(
                'share'.tr,
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
                size: 20,
              ),
            ),
            ListTile(
              title: Text(
                'Darul-asar',
                style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
              ),
              onTap: () {
                _launchInBrowser(_youTubeLink);
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
                _launchInBrowser(_linkInstagramm);
              },
              leading: const Icon(
                FontAwesomeIcons.instagram,
                color: Colors.pinkAccent,
                size: 21,
              ),
            ),
            // ListTile(
            //   title: Text(
            //     '',
            //     style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
            //   ),
            //   onTap: () {
            //     _launchInBrowser(_linkInstagramm);
            //   },
            //   leading: Switch(
            //     value: _light,
            //     onChanged: (state) {
            //       setState(() {
            //         _light = state;
            //       });
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

Widget _header(BuildContext context) {
  return Material(
    color: bgColor,
    child: Padding(
      padding: const EdgeInsets.only(top: 70),
      child: Container(
        width: 180,
        height: 180,
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(4.0, 4.0),
                  blurRadius: 3.0,
                  spreadRadius: 1.0),
              BoxShadow(
                  color: Colors.grey[200]!,
                  offset: const Offset(-2.0, -2.0),
                  blurRadius: 3.0,
                  spreadRadius: 1.0),
            ]),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: Image.asset(
            'assets/images/iconavrod.png',
            height: 190,
            width: 190,
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),

    // Container(
    //   width: MediaQuery.of(context).size.width,
    //   padding: EdgeInsets.only(
    //       top: 22 + MediaQuery.of(context).padding.top, bottom: 25),
    //   child: Column(
    //     children: const [
    //       CircleAvatar(
    //           radius: 72, backgroundImage: AssetImage('images/iconavrod.png'))
    //     ],
    //   ),
    // ),
  );
}
