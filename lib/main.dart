import 'package:avrod/constant/routes/routes.dart';
import 'package:avrod/language_storage.dart';
import 'package:avrod/localization/translation.dart';
import 'package:avrod/services/firebase_service.dart';
import 'package:avrod/services/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'constant/colors/colors.dart';

final navigatorKey = GlobalKey<NavigatorState>();
const String FAVORITES_BOX = 'favorites_box';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await GetStorage.init();
  await intServices();
  await Firebase.initializeApp();
 // await FirebaseService().initNotifications();
 
  
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  await Hive.initFlutter();

  await Hive.openBox(FAVORITES_BOX);
  await Hive.openBox('pageBox');

  

  //  await JustAudioBackground.init(
  //   androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
  //   androidNotificationChannelName: 'Audio playback',
  //   androidNotificationOngoing: true,
  // );

  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  // LocalController localController = Get.put(LocalController());

    return GetMaterialApp(
      navigatorKey: navigatorKey,
      locale: Locale("${languageStorage.read('code') ?? Get.deviceLocale}"),
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
