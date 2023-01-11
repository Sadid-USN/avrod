import 'package:avrod/constant/routes/routes.dart';
import 'package:avrod/localization/translation.dart';
import 'package:avrod/services/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'constant/colors/colors.dart';
import 'localization/local_controller.dart';

const String FAVORITES_BOX = 'favorites_box';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await intServices();
  await Firebase.initializeApp();

  //MobileAds.instance.initialize();
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  await Hive.initFlutter();

  await Hive.openBox(FAVORITES_BOX);
  await Hive.openBox('pageBox');
  // TODO messaging
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalController localController = Get.put(LocalController());

    return GetMaterialApp(
      locale: localController.defaultLanguge,
      translations: MyTranslation(),
      getPages: getPages,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: bgColor,
        textTheme:
            GoogleFonts.ptSerifCaptionTextTheme(Theme.of(context).textTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
