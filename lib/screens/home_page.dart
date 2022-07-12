import 'package:avrod/constant/animated_text.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/constant/navigeton_items.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:avrod/screens/chapter_screen.dart';
import 'package:avrod/widgets/drawer_widget.dart';
import 'package:avrod/widgets/path_of_images.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'dart:io' show Platform;

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());
    return Scaffold(
      drawer: const DrawerModel(),
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              controller.goToLangugePage();
            },
            icon: Icon(
              Icons.language,
              color: Colors.indigo.shade400,
            ),
          ),
        ],
        backgroundColor: const Color(0xffF2DFC7),
        title: const ListTile(
          title: Center(
            child: MyanimetedText(),
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AnimationLimiter(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 1.3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              crossAxisCount: 3,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: images.length,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 400),
                      columnCount: images.length,
                      child: FlipAnimation(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ChapterScreen(
                                indexChapter: index,
                              );
                            }));
                          },
                          child: Image.asset(
                            images[index].pathImages,
                            height: 110,
                            width: 110,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      images[index].name.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 10,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: Platform.isIOS ? 65 : 50,
        index: controller.currrentIndexTab,
        backgroundColor: const Color(0xffF2DFC7),
        items: navItems,
        onTap: (index) {
          controller.onTapCurvedNavigationBar(index);
        },
      ),
    );
  }
}

























// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:avrod/colors/colors.dart';
// import 'package:avrod/colors/gradient_class.dart';
// import 'package:avrod/data/book_map.dart';
// import 'package:avrod/models/bottom_nav_bar.dart';
// import 'package:avrod/widgets/notification.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';
// import '../widgets/drawer_widget.dart';
// import 'chapter_screen.dart';
// import 'package:timezone/data/latest.dart' as tz;

// class HomePage extends StatefulWidget {
//   const HomePage({
//     Key? key,
//   }) : super(key: key);
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   BannerAd? _bannerAd;
//   // NativeAd _nativeAd;
//   bool isAdLoaded = false;
//   Chapter? chapter;

//   @override
//   void dispose() {
//     _bannerAd!.dispose();

//     super.dispose();
//   }

//   @override
//   void initState() {
//     //_initNativeAd();

//     //_initBannerAd();
//     super.initState();

//     tz.initializeTimeZones();

//     NotificationService().dailyAtNotification(
//       1,
//       listnotiece.title![0],
//       listnotiece.notiece![0],
//       2,
//     );
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _bannerAd = BannerAd(
//         size: AdSize.banner,
//         adUnitId: 'ca-app-pub-6636812855826330/4617524983',
//         listener: BannerAdListener(onAdLoaded: (ad) {
//           setState(() {
//             isAdLoaded = true;
//           });
//           print('<<<<Banner Ad Loaded>>>');
//         }, onAdFailedToLoad: (ad, error) {
//           ad.dispose();
//           print(error.message);
//         }),
//         request: const AdRequest());
//     _bannerAd!.load();
//   }

 // _initBannerAd() {
 //   _bannerAd = BannerAd(
 //     size: AdSize.banner,
 // test adUnitId: 'ca-app-pub-3940256099942544/6300978111',
 //      adUnitId: 'ca-app-pub-6143129378445620/5225466438',
 //     listener: BannerAdListener(
 //       onAdLoaded: (_) {
 //         setState(() {
 //           isAdLoaded = true;
 //         });
 //       },
 //       onAdFailedToLoad: (ad, error) {
 //         print('This is error message ->>>>> ${error.message}');
 //         isAdLoaded = false;
 //         ad.dispose();
 //       },
 //     ),
 //     request: const AdRequest(),
 //   )..load();
 // }

  // final navItems = [
  //   Icon(FontAwesomeIcons.search, color: Colors.indigo.shade400, size: 22.sp),
  //   Icon(
  //     FontAwesomeIcons.book,
  //     color: Colors.indigo.shade400,
  //     size: 22.sp,
  //   ),
  //   Icon(Icons.favorite, color: Colors.red, size: 22.sp),
  //   Icon(FontAwesomeIcons.calendarAlt,
  //       color: Colors.indigo.shade400, size: 22.sp),
  //   Icon(Icons.star, color: Colors.indigo.shade400, size: 22.sp),
  // ];

  // final colorizeColors = [
  //   Colors.white,
  //   Colors.orange,
  //   Colors.blue,
  //   Colors.indigo,
  //   Colors.blueGrey,
  //   Colors.deepOrange,
  // ];

  // final colorizeTextStyle =
  //     TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900);

//   @override
//   Widget build(BuildContext context) {
//     final books = Provider.of<List<Book>>(context);
//     return ChangeNotifierProvider(
//       create: (context) => BottomNavBar(),
//       child: Scaffold(
//           drawer: const DrawerModel(),
//           extendBodyBehindAppBar: true,
//           appBar: AppBar(
//             flexibleSpace: Lottie.network(
//               'https://assets7.lottiefiles.com/private_files/lf30_yeszgfau.json',
//               fit: BoxFit.cover,
//               height: 10,
//               width: MediaQuery.of(context).size.width,
//             ),
//             title: ListTile(
//               title: AnimatedTextKit(
//                 totalRepeatCount: 2,
//                 animatedTexts: [
//                   ColorizeAnimatedText('Авроди субҳу шом',
//                       textStyle: colorizeTextStyle, colors: colorizeColors),
//                 ],
//               ),
//             ),
//             centerTitle: true,
//             elevation: 1.0,
//             backgroundColor: Colors.transparent,
//           ),
//           //  backgroundColor: gradientEndColor,
//           body: Container(
//             height: double.maxFinite,
//             decoration: mainScreenGradient,
//             child: ListView(
//               children: [
//                 // const Spacer(),
//                 isAdLoaded
//                     ? SizedBox(
//                         height: _bannerAd!.size.height.toDouble(),
//                         width: _bannerAd!.size.width.toDouble(),
//                         child: AdWidget(ad: _bannerAd!),
//                       )
//                     : const SizedBox(),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.only(left: 32, top: 60),
//                       height: 70.h,
//                       child: Swiper(
//                         duration: 300,
//                         curve: Curves.linearToEaseOut,
//                         scrollDirection: Axis.horizontal,
//                         autoplayDisableOnInteraction: false,
//                         itemCount: books.length,
//                         itemWidth: 66.w,
//                         layout: SwiperLayout.STACK,
//                         pagination: const SwiperPagination(
//                           margin: EdgeInsets.only(top: 20),
//                           builder: DotSwiperPaginationBuilder(
//                               activeColor: Colors.deepOrange,
//                               activeSize: 14,
//                               space: 5),
//                         ),
//                         itemBuilder: (context, index) {
//                           return InkWell(
//                             onTap: () {
//                               // Get.toNamed('/chapterscreen');
//                               Navigator.push(context, PageRouteBuilder(
//                                   pageBuilder: (context, a, b) {
//                                 return ChapterScreen(
//                                   index,
//                                   chapter,
//                                 );
//                               }));
//                             },
//                             child: Stack(
//                               children: [
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(
//                                       height: 100,
//                                     ),
//                                     // ignore: sized_box_for_whitespace
//                                     Container(
//                                       height: 40.h,
//                                       width: 40.h,
//                                       child: Card(
//                                         elevation: 8,
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(25)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(25.0),
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Center(
//                                                 child: Text(
//                                                   books[index].name!,
//                                                   textAlign: TextAlign.center,
//                                                   style: TextStyle(
//                                                       fontSize: 19.sp,
//                                                       color: primaryTextColor,
//                                                       fontWeight:
//                                                           FontWeight.w900),
//                                                 ),
//                                               ),
//                                               Column(
//                                                 children: [
//                                                   const SizedBox(
//                                                     height: 30,
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Text(
//                                                         'Маълумоти бештар',
//                                                         style: TextStyle(
//                                                             color:
//                                                                 primaryTextColor,
//                                                             fontSize: 10.sp,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w500),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 1.w,
//                                                       ),
//                                                       // ignore: sized_box_for_whitespace
//                                                       Icon(
//                                                         FontAwesomeIcons
//                                                             .arrowRight,
//                                                         size: 14.sp,
//                                                         color: Colors.blueGrey,
//                                                       ),
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Padding(
//                                   padding:
//                                       const EdgeInsets.only(left: 20, top: 20),
//                                   child: AvatarGlow(
//                                     shape: BoxShape.circle,
//                                     glowColor: Colors.green,
//                                     endRadius: 90.sp,
//                                     duration:
//                                         const Duration(milliseconds: 1500),
//                                     repeat: true,
//                                     showTwoGlows: true,
//                                     repeatPauseDuration:
//                                         const Duration(milliseconds: 1000),
//                                     child: Image.asset(
//                                       books[index].image!,
//                                       height: 35.h,
//                                       width: 80.w,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//           bottomNavigationBar: Consumer<BottomNavBar>(
//             builder: (context, bottomBar, child) => CurvedNavigationBar(
//                 color: Colors.white,
//                 buttonBackgroundColor: Colors.white,
//                 height: 45.sp,
//                 index: bottomBar.selectedIndex,
//                 backgroundColor: Colors.indigo.shade400,
//                 items: navItems,
//                 onTap: (index) {
//                   bottomBar.onTapBar(context, index);
//                 }),
//           )),
//     );
//   }
// }
