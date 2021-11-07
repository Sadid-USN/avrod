// @dart=2.9
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:avrod/colors/colors.dart';
import 'package:avrod/colors/gradient_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:avrod/screens/library_book_list_screen.dart';
import 'package:avrod/Calendars/calendar_tabbar.dart';
import 'package:avrod/screens/search_screen.dart';
import 'package:avrod/widgets/my_fab_menu.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'favorite_chapter_screen.dart';
import 'chapter_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool gowColors = false;
  Chapter chapter;
  final String _lounchGooglePlay =
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

  // final controller = PageController(viewportFraction: 12.0, keepPage: true);
  int selectedIndex = 2;
  final navItems = [
    const Icon(Icons.search, color: Colors.blueGrey, size: 30),
    const Icon(
      FontAwesomeIcons.book,
      color: Colors.blueGrey,
      size: 25,
    ),
    const Icon(Icons.favorite, color: Colors.red, size: 30),
    const Icon(FontAwesomeIcons.calendarAlt, color: Colors.blueGrey, size: 25),
    const Icon(Icons.star, color: Colors.blueGrey, size: 30),
  ];
  int yourActiveIndex;
  final colorizeColors = [
    Colors.white,
    Colors.orange,
    Colors.blue,
    Colors.indigo,
    Colors.blueGrey,
    Colors.deepOrange,
  ];

  final colorizeTextStyle =
      TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w900);

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<List<Book>>(context);
    return Scaffold(
        floatingActionButton: const MyFabCircularMenu(),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: AnimatedTextKit(
            totalRepeatCount: 2,
            animatedTexts: [
              ColorizeAnimatedText('Авроди субҳу шом',
                  textStyle: colorizeTextStyle, colors: colorizeColors),
            ],
          ),
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: gradientEndColor,
        body: Container(
          height: double.maxFinite,
          decoration: mainScreenGradient,
          child:  ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 32, top: 60),
                          height: 70.h,
                          child: Swiper(
                            duration: 300,
                            curve: Curves.linearToEaseOut,
                            scrollDirection: Axis.horizontal,
                            autoplayDisableOnInteraction: false,
                            itemCount: books.length,
                            itemWidth: 66.w,
                            layout: SwiperLayout.STACK,
                            pagination: const SwiperPagination(
                              margin: EdgeInsets.only(top: 20),
                              builder: DotSwiperPaginationBuilder(
                                  activeColor: Colors.deepOrange,
                                  activeSize: 14,
                                  space: 5),
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, PageRouteBuilder(
                                      pageBuilder: (context, a, b) {
                                    return ChapterScreen(index, chapter,);
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
                                          height: 40.h,
                                          width: 40.h,
                                          child: Card(
                                            elevation: 8,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(25.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Center(
                                                    child: Text(
                                                      books[index].name,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 19.sp,
                                                          color:
                                                              primaryTextColor,
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
                                                                fontSize: 14.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          SizedBox(
                                                            width: 1.w,
                                                          ),
                                                          // ignore: sized_box_for_whitespace
                                                          Icon(
                                                            FontAwesomeIcons
                                                                .arrowRight,
                                                            size: 14.sp,
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 20),
                                      child: AvatarGlow(
                                        shape: BoxShape.circle,
                                        glowColor: Colors.blue,
                                        endRadius: 120,
                                        duration:
                                            const Duration(milliseconds: 1500),
                                        repeat: true,
                                        showTwoGlows: true,
                                        repeatPauseDuration:
                                            const Duration(milliseconds: 1000),
                                        child: Image.asset(
                                          books[index].image,
                                          height: 35.h,
                                          width: 80.w,
                                        ),
                                      ),
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
                ),
            
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          height: 60.0,
          index: selectedIndex,
          backgroundColor: Colors.cyan,
          items: navItems,
          onTap: (index) {
            //Handle button tap
            setState(() {
              selectedIndex = index;
              if (index == 0) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SearcScreen();
                }));
              } else if (index == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LibraryBookList();
                }));
              } else if (index == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const FavoriteChaptersSceen();
                }));
              } else if (index == 3) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const CalendarTabBarView();
                }));
              } else if (index == 4) {
                _launchInBrowser(_lounchGooglePlay);
              }
            });
          },
        ));
  }
}
