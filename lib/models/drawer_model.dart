import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerModel extends StatefulWidget {
  const DrawerModel({Key? key}) : super(key: key);

  @override
  State<DrawerModel> createState() => _DrawerModelState();
}

class _DrawerModelState extends State<DrawerModel> {
  final bool _switch = false;
  final ThemeData _dark = ThemeData(brightness: Brightness.dark);
  final ThemeData _light = ThemeData(brightness: Brightness.light);
  final String _lounchUrl =
      'https://play.google.com/store/apps/details?id=com.darulasar.avrod';
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
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _launchInBrowser(_lounchUrl);
                  });
                },
                icon: const Icon(
                  Icons.share,
                  color: Colors.blueGrey,
                  size: 25,
                )),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'Ба дигарон ирсол кунед',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(
                  Icons.language,
                  color: Colors.blueGrey,
                  size: 25,
                )),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'Забонҳо',
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (_switch == false) {
                      _light;
                    } else {
                      _dark;
                    }
                  });
                },
                icon: Icon(
                  Icons.lightbulb,
                  color: Colors.amber[400],
                  size: 25,
                )),
            const SizedBox(
              width: 5,
            ),
            const Text(
              'Сабки равшан ва торик',
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      ],
    );
  }
}
