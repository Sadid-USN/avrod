// @dart=2.9
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avrod/screens/subchapter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'colors/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme:
            GoogleFonts.ptSerifCaptionTextTheme(Theme.of(context).textTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final colorizeColors = [
    Colors.white,
    Colors.green,
    Colors.pink,
    Colors.deepOrange,
  ];

  final colorizeTextStyle =
      const TextStyle(fontSize: 30.0, fontWeight: FontWeight.w900);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: gradientEndColor,
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [gradientStartColor, gradientEndColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.3, 0.7])),
          child: FutureBuilder(
            future: DefaultAssetBundle.of(context)
                .loadString('lib/data/book.json'),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var showData = json.decode(snapshot.data?.toString() ?? '');
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          // ignore: sized_box_for_whitespace
                          Container(
                            height: 40,
                            child: AnimatedTextKit(
                              totalRepeatCount: 2,
                              animatedTexts: [
                                ColorizeAnimatedText('Авроди субҳу шом',
                                    textStyle: colorizeTextStyle,
                                    colors: colorizeColors),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 32, top: 60),
                            height: 570,
                            child: Swiper(
                              autoplayDisableOnInteraction: true,
                              itemCount: showData.length,
                              itemWidth:
                                  MediaQuery.of(context).size.width - 2 * 64,
                              layout: SwiperLayout.STACK,
                              pagination: const SwiperPagination(
                                margin: EdgeInsets.only(top: 20),
                                builder: DotSwiperPaginationBuilder(
                                    activeSize: 15, space: 6),
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context, PageRouteBuilder(
                                        pageBuilder: (context, a, b) {
                                      return  SubchapterScreen(index);
                                    }));
                                  },
                                  child: Stack(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 100,
                                          ),
                                          // ignore: sized_box_for_whitespace
                                          Container(
                                            height: 320,
                                            width: 310,
                                            child: Card(
                                              elevation: 8,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(25.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        showData[index]['name'],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: const TextStyle(
                                                            fontSize: 30,
                                                            color:
                                                                primaryTextColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: const [
                                                            Text(
                                                              'Маълумоти бештар',
                                                              style: TextStyle(
                                                                  color:
                                                                      primaryTextColor,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Icon(
                                                              FontAwesomeIcons
                                                                  .arrowRight,
                                                              color:
                                                                  contentTextColor,
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Image.asset(showData[index]['image']),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                         
                        ],
                      ),
                      
                    );
                  },
                  itemCount: showData.length,
                );
              } else {
                return const Offstage();
              }
            },
          ),
        ),
          bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.3),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0))),
          padding: const EdgeInsets.all(25),
          child: GNav(
            
              rippleColor:
                  Colors.blue, // tab button ripple color when pressed
              hoverColor: Colors.blue[700], // tab button hover color
              haptic: true, // haptic feedback
              tabBorderRadius: 15,
              tabActiveBorder: Border.all(
                  color: Colors.white, width: 1.5), // tab button border
              tabBorder: Border.all(
                  color: Colors.white, width: 1.5), // tab button border
              tabShadow: const [
                BoxShadow(color: Colors.white, blurRadius: 8)
              ], // tab button shadow
              curve: Curves.easeIn, // tab animation curves
              duration: const Duration(milliseconds: 300), // tab animation duration
              gap: 8, // the tab button gap between icon and text
              color: Colors.blueGrey, // unselected icon color
              activeColor: Colors.blue, // selected icon and text color
              iconSize: 24, // tab button icon size
              tabBackgroundColor: Colors.purple
                  .withOpacity(0.1), // selected tab background color
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 5), // navigation bar padding
              tabs: [
                const GButton(
                  backgroundColor: Colors.white,
                  icon: Icons.favorite_sharp, iconSize: 26,
                  iconColor: Colors.red,
                  text: 'Мунтахаб',
                ),
                GButton(
                  backgroundColor: Colors.yellow[50],
                  icon: FontAwesomeIcons.search,
                  text: 'Ҷустуҷӯ',
                ),
                const GButton(
                  backgroundColor: Colors.white,
                  icon: FontAwesomeIcons.thumbsUp,
                  //iconColor: Colors.green,
                  text: 'Баҳодиҳи',
                  textColor: Colors.blue,
                )
              ])),
    );
      
  }
// Text(showData[index]['name'])
  // Future<List<Avrod>> readJsonData() async {
  //   final jsondata =
  //       await rootbundle.rootBundle.loadString('lib/data/avrod.json');
  //   final list = json.decode(jsondata) as List<dynamic>;
  //   return list.map((e) => Avrod.fromJson(e)).toList();
  // }
}
