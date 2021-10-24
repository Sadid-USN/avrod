import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerModel extends StatefulWidget {
  const DrawerModel({Key? key}) : super(key: key);

  @override
  State<DrawerModel> createState() => _DrawerModelState();
}

class _DrawerModelState extends State<DrawerModel> {
  final String _lounchUrl =
      'https://accounts.google.com/signout/chrome/landing?continue=https://mail.google.com&oc=https://mail.google.com&hl=en';
  final String _linkInstagramm =
      'https://instagram.com/darul_asar?utm_medium=copy_link';
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
       backgroundColor: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 50),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Share.share(
                          'Барномаи «Avrod» дуоҳои саҳеҳи набави (ﷺ) бо забони тоҷикӣ, ба дустону наздикони худ равон кунед, чун роҳнамоӣ ба амали хайр дар савоб монанди анҷомдиҳандаи он аст.\nhttps://play.google.com/store/apps/details?id=com.darulasar.avrod');
                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.blueGrey,
                      size: 20.sp,
                    )),
                 SizedBox(
                  width: 1.w,
                ),
                const Text(
                  'Ба дигарон ирсол кунед',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.language,
                      color: Colors.blueGrey,
                      size: 20.sp,
                    )),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'Забонҳо',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _launchInBrowser(_lounchUrl);
                    },
                    icon: Icon(
                      FontAwesomeIcons.envelope,
                      color: Colors.blueGrey,
                      size: 18.sp,
                    )),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'Бо мо тамос гиред',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _launchInBrowser(_linkInstagramm);
                    },
                    icon: Icon(
                      FontAwesomeIcons.instagram,
                      color: Colors.pinkAccent,
                      size: 21.sp,
                    )),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'Instagram',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
