import 'package:flutter/material.dart';
import 'package:share/share.dart';


class DrawerModel extends StatefulWidget {
  const DrawerModel({Key? key}) : super(key: key);

  @override
  State<DrawerModel> createState() => _DrawerModelState();
}

class _DrawerModelState extends State<DrawerModel> {
  

  // final bool _switch = false;
  // final ThemeData _dark = ThemeData(brightness: Brightness.dark);
  // final ThemeData _light = ThemeData(brightness: Brightness.light);

 

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
                onPressed: () {
                  Share.share('Барномаи «Avrod» дуоҳои саҳеҳи набави (ﷺ) бо забони тоҷикӣ, ба дустону наздикони худ равон кунед, чун роҳнамоӣ ба амали хайр дар савоб монанди анҷомдиҳандаи он аст.\nhttps://play.google.com/store/apps/details?id=com.darulasar.avrod');
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
              style: TextStyle(fontSize: 16, color: Colors.white),
            )
          ],
        ),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mail,
                  color: Colors.blueGrey,
                  size: 25,
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
      ],
    );
  }
}
