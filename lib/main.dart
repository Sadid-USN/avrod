// @dart=2.9

import 'package:avrod/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: constant_identifier_names
const String FAVORITES_BOX = 'favorites_box';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(FAVORITES_BOX);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
        //    localizationsDelegates: const [
        //    //GlobalMaterialLocalizations.delegate,
        //   // GlobalWidgetsLocalizations.delegate,
        //  ],
        //    supportedLocales: const [
        //    Locale('ru', 'RU'),
        //  ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme:
                  GoogleFonts.ptSerifTextTheme(Theme.of(context).textTheme),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const HomePage());
      },
    );
  }
}
