// @dart=2.9
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avrod/colors/colors.dart';
import 'package:avrod/screens/subchapter_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'colors/colors.dart';
import 'data/book_class.dart';
import 'data/book_map.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/favorite_chapter_screen.dart';

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
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: GoogleFonts.ptSerifTextTheme(
                  Theme.of(context).textTheme),
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: const HomePage());
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController(viewportFraction: 12.0, keepPage: true);
  int _selectedIndex;
  int yourActiveIndex;
  final colorizeColors = [
    Colors.white,
    Colors.orange,
    Colors.indigo,
    Colors.blueGrey,
  ];

  final colorizeTextStyle =
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w900);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gradientEndColor,
      body: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: FutureBuilder<List<Book>>(
          future: BookMap.getBookLocally(context),
          builder: (contex, snapshot) {
            final books = snapshot.data;
            if (snapshot.hasData) {
              return ListView(
                
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                      ),

                      // ignore: avoid_unnecessary_containers
                      Container(
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
                        height: 70.h,
                        child: Swiper(
                          duration: 300,
                          curve: Curves.linearToEaseOut,
                          scrollDirection: Axis.horizontal,
                          autoplayDisableOnInteraction: true,
                          itemCount: books.length,
                          itemWidth: 66.w,
                          layout: SwiperLayout.STACK,
                          pagination: const
                          SwiperPagination(
                            margin:  EdgeInsets.only(top: 20),
                            builder:  DotSwiperPaginationBuilder(
                              activeColor: Colors.cyanAccent,
                                activeSize: 15, space: 6),
                          ),
                          itemBuilder: (context, index) {
                           

                            return InkWell(
                              onTap: () {
                                Navigator.push(context, PageRouteBuilder(
                                    pageBuilder: (context, a, b) {
                                  return SubchapterScreen(index);
                                }));
                              },
                              
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      // ignore: sized_box_for_whitespace
                                      Container(
                                        height: 40.h,
                                        width: 40.h,
                                        child: Card(
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(25.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    books[index].name,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 20.sp,
                                                        color: primaryTextColor,
                                                        fontWeight:
                                                            FontWeight.w900),
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
                                                      children: [
                                                        Text(
                                                          'Маълумоти бештар',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryTextColor,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        // ignore: sized_box_for_whitespace
                                                        const Icon(
                                                          FontAwesomeIcons
                                                              .arrowRight,
                                                              size: 16,
                                                          color:
                                                              Colors.blueGrey,
                                                        ),
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
                                  Image.asset(
                                    books[index].image,
                                    height: 35.h,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                   
                    ],
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Some erro occured'),
              );
            } else {
              return Center(
                  child: GlowingProgressIndicator(
                duration: const Duration(seconds: 2),
                child: FadingText(
                  'Боргузорӣ...',
                  style: const TextStyle(
                      fontSize: 21.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ));
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(.3),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16.0))),
          padding: const EdgeInsets.all(25),
          child: GNav(
            rippleColor: Colors.blue, // tab button ripple color when pressed
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
            duration:
                const Duration(milliseconds: 300), // tab animation duration
            gap: 8, // the tab button gap between icon and text
            color: Colors.blueGrey, // unselected icon color
            activeColor: Colors.blue, // selected icon and text color
            iconSize: 24, // tab button icon size
            tabBackgroundColor:
                Colors.purple.withOpacity(0.1), // selected tab background color
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 5), // navigation bar padding
            tabs: [
              GButton(
                onPressed: () {},
                backgroundColor: Colors.white,
                icon: FontAwesomeIcons.search,
                text: 'Ҷустуҷӯ',
              ),
              GButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const FavoriteChapterSceen();
                  }));
                },
                backgroundColor: Colors.white,
                icon: Icons.favorite_sharp,
                iconSize: 26,
                iconColor: Colors.blueGrey,
                text: 'Маҳбуб',
                iconActiveColor: Colors.red,
              ),
              const GButton(
                backgroundColor: Colors.white,
                icon: FontAwesomeIcons.thumbsUp,
                //iconColor: Colors.green,
                text: 'Баҳодиҳи',
                textColor: Colors.blue,
              )
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          )),
    );
  }
}
