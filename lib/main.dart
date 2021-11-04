// @dart=2.9
import 'package:avrod/data/book_functions.dart';
import 'package:avrod/screens/home_page.dart';
import 'package:avrod/screens/search_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/book_map.dart';

// ignore: constant_identifier_names
const String FAVORITES_BOX = 'favorites_box';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(FAVORITES_BOX);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key, this.bookIndex}) : super(key: key);
  final int bookIndex;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print('build');
    return Sizer(
      builder: (context, orientation, deviceType) {
        return FutureProvider<List<Book>>(
          initialData: [],
          create: (_) async => await BookFunctions.getBookLocally(context),
          child: MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              // GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ru', 'RU'),
              Locale('ar', 'SA'),
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme:
                  GoogleFonts.ptSerifTextTheme(Theme.of(context).textTheme),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: HomePage(),
          ),
        );
      },
    );
  }
}
