// @dart=2.9
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:avrod/colors/colors.dart';
import 'package:avrod/colors/gradient_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:avrod/models/bottom_nav_bar.dart';
import 'package:avrod/widgets/notification.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../widgets/drawer_widget.dart';
import 'chapter_screen.dart';
import 'package:timezone/data/latest.dart' as tz;

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BannerAd _bannerAd;
  // NativeAd _nativeAd;
  bool isAdLoaded = false;
  Chapter chapter;

  @override
  void initState() {
    _initBannerAd();
    //_initNativeAd();

    super.initState();

    tz.initializeTimeZones();

    NotificationService().dailyAtNotification(
        1,
        "Дуо сипари мусалмон аст",
        "Парвардигоратон фармуд: «Маро бихонед, то [дуои] шуморо иҷобат кунам» (Ғофир 60)",
        2);
  }

  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-6143129378445620/5225466438',
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('This is error message ->>>>> ${error.message}');
          isAdLoaded = false;
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    )..load();
  }

  // _initNativeAd() {
  //   _nativeAd = NativeAd(
  //     adUnitId: 'ca-app-pub-6636812855826330/7135204661',
  //     factoryId: 'ListTile',
  //     listener: NativeAdListener(onAdLoaded: (ad) {
  //       setState(() {
  //         isAdLoaded = true;
  //       });
  //     }, onAdFailedToLoad: (ad, error) {
  //       ad.dispose();
  //       print('failed to load the ad ${error.message}');
  //     }),
  //     request: const AdRequest(),
  //   )..load();
  // }
  // final controller = PageController(viewportFraction: 12.0, keepPage: true);

  final navItems = [
    Icon(FontAwesomeIcons.search, color: Colors.indigo.shade400, size: 22.sp),
    Icon(
      FontAwesomeIcons.book,
      color: Colors.indigo.shade400,
      size: 22.sp,
    ),
    Icon(Icons.favorite, color: Colors.red, size: 22.sp),
    Icon(FontAwesomeIcons.calendarAlt,
        color: Colors.indigo.shade400, size: 22.sp),
    Icon(Icons.star, color: Colors.indigo.shade400, size: 22.sp),
  ];

  final colorizeColors = [
    Colors.white,
    Colors.orange,
    Colors.blue,
    Colors.indigo,
    Colors.blueGrey,
    Colors.deepOrange,
  ];

  final colorizeTextStyle =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900);

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<List<Book>>(context);
    return ChangeNotifierProvider(
      create: (context) => BottomNavBar(),
      child: Scaffold(
          drawer: const DrawerModel(),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: ListTile(
              title: AnimatedTextKit(
                totalRepeatCount: 2,
                animatedTexts: [
                  ColorizeAnimatedText('Авроди субҳу шом',
                      textStyle: colorizeTextStyle, colors: colorizeColors),
                ],
              ),
            ),
            centerTitle: true,
            elevation: 1.0,
            backgroundColor: Colors.transparent,
          ),
          //  backgroundColor: gradientEndColor,
          body: Container(
            height: double.maxFinite,
            decoration: mainScreenGradient,
            child: ListView(
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
                              // Get.toNamed('/chapterscreen');
                              Navigator.push(context, PageRouteBuilder(
                                  pageBuilder: (context, a, b) {
                                return ChapterScreen(
                                  index,
                                  chapter,
                                );
                              }));
                            },
                            child: Stack(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                      fontSize: 19.sp,
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
                                                            fontSize: 10.sp,
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
                                                        color: Colors.blueGrey,
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
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 20),
                                  child: AvatarGlow(
                                    shape: BoxShape.circle,
                                    glowColor: Colors.green,
                                    endRadius: 90.sp,
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
                                isAdLoaded
                                    ? SizedBox(
                                        height:
                                            _bannerAd.size.height.toDouble(),
                                        width: _bannerAd.size.width.toDouble(),
                                        child: AdWidget(ad: _initBannerAd()),
                                      )
                                    : const SizedBox(),
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
          bottomNavigationBar: Consumer<BottomNavBar>(
            builder: (context, bottomBar, child) => CurvedNavigationBar(
                color: Colors.white,
                buttonBackgroundColor: Colors.white,
                height: 45.sp,
                index: bottomBar.selectedIndex,
                backgroundColor: Colors.indigo.shade400,
                items: navItems,
                onTap: (index) {
                  bottomBar.onTapBar(context, index);
                }),
          )),
    );
  }
}
