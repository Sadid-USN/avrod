import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerModel extends StatelessWidget {
  const DrawerModel({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 30,
      backgroundColor: Colors.black12,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _header(context),
            ListTile(
              title: const Text(
                'Ба дигарон ирсол кунед',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              onTap: () {
                Share.share(
                    'Барномаи «Avrod» дуоҳои саҳеҳи набави (ﷺ) бо забони тоҷикӣ, ба дустону наздикони худ равон кунед, чун роҳнамоӣ ба амали хайр дар савоб монанди анҷомдиҳандаи он аст.\nhttps://play.google.com/store/apps/details?id=com.darulasar.avrod');
              },
              leading: const Icon(
                Icons.share,
                color: Colors.blueGrey,
                size: 20,
              ),
            ),
            ListTile(
                title: const Text(
                  'Azkar бо забони русӣ',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                onTap: () {
                  _launchInBrowser(_azkarRuAppLink);
                },
                leading: const CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage(
                      'images/iconavrod.png',
                    ))),
            ListTile(
              title: const Text(
                'Darul-asar',
                style: TextStyle(fontSize: 14, color: Colors.white),
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
              title: const Text(
                '@darul_asar',
                style: TextStyle(fontSize: 14, color: Colors.white),
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
          ],
        ),
      ),
    );
  }
}

Widget _header(BuildContext context) {
  return Material(
    color: Colors.transparent,
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          top: 22 + MediaQuery.of(context).padding.top, bottom: 25),
      child: Column(
        children: const [
          CircleAvatar(
              radius: 72, backgroundImage: AssetImage('images/iconavrod.png'))
        ],
      ),
    ),
  );
}
