import 'package:avrod/colors/colors.dart';
import 'package:avrod/screens/home_page.dart';
import 'package:avrod/widgets/notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String FAVORITES_BOX = 'favorites_box';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService().initNotification();
  await Firebase.initializeApp();
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  await Hive.initFlutter();
  await Hive.openBox(FAVORITES_BOX);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: bgColor,
        textTheme:
            GoogleFonts.ptSerifCaptionTextTheme(Theme.of(context).textTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}
