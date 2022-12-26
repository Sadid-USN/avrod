import 'dart:convert';
import 'dart:io' show Platform;

import 'package:avrod/Calendars/calendar_tabbar.dart';
import 'package:avrod/booksScreen/library_screen.dart';
import 'package:avrod/screens/favorite_chapter_screen.dart';
import 'package:avrod/screens/languge.page.dart';
import 'package:avrod/screens/search_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share/share.dart';
// import 'package:url_launcher/url_launcher.dart';

abstract class HomeController extends GetxController {
  final String googlePlayLink =
      'https://play.google.com/store/apps/details?id=com.darulasar.avrod';
  final String appStoreLink =
      'https://apps.apple.com/ru/app/avrod/id1626614344?l=en';
  int currrentIndexTab = 2;
  onTapCurvedNavigationBar(int index);
  // launchInBrowser(String url);
  goToLangugePage();
}

class HomePageController extends HomeController {
  //Dcloration
  String? data;
  List<dynamic>? book;
  DatabaseReference bookRef = FirebaseDatabase.instance.ref('book');
  late BannerAd _bannerAd;
  bool isAdLoade = false;
  // @override
  // Future<void> launchInBrowser(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url,
  //         forceSafariVC: false,
  //         forceWebView: false,
  //         headers: <String, String>{'header_key': 'header_value'});
  //   } else {
  //     throw 'Пайванд кушода нашуд $url';
  //   }
  // }

  @override
  onTapCurvedNavigationBar(int index) {
    currrentIndexTab = index;
    if (index == 0) {
      Get.toNamed(SearchScreen.routName);
    } else if (index == 1) {
      Get.toNamed(LibraryScreen.routName);
    } else if (index == 2) {
      Get.toNamed(FavoriteChaptersSceen.routName);
    } else if (index == 3) {
      Get.toNamed(CalendarTabBarView.routName);
    } else if (index == 4) {
      if (Platform.isAndroid) {
        Share.share(
            'Барномаи «Avrod» дуоҳои саҳеҳи набави (ﷺ) бо забони тоҷикӣ, ба дустону наздикони худ равон кунед, чун роҳнамоӣ ба амали хайр дар савоб монанди анҷомдиҳандаи он аст.\nhttps://play.google.com/store/apps/details?id=com.darulasar.avrod');
      } else {
        Share.share(
            'Барномаи «Avrod» дуоҳои саҳеҳи набави (ﷺ) бо забони тоҷикӣ, ба дустону наздикони худ равон кунед, чун роҳнамоӣ ба амали хайр дар савоб монанди анҷомдиҳандаи он аст.\nhttps://apps.apple.com/ru/app/avrod/id1626614344?l=en');
      }
    }
  }

  @override
  void onInit() {
    bookRef.onValue.listen((event) {
      // convert object to JSON String
      data = jsonEncode(event.snapshot.value);
      // convert JSON into Map<String, dynamic>
      book = jsonDecode(data!);
      update();
    });

    super.onInit();
    _initBanner();
  }

  _initBanner() {
    _bannerAd = BannerAd(
        size: AdSize.banner,
        adUnitId: 'ca-app-pub-7613540986721565/6723282918',
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            isAdLoade = true;
            update();
          },
          onAdFailedToLoad: (ad, error) {},
        ),
        request: const AdRequest());

    _bannerAd.load();
    update();
  }

  Widget adBanner() {
    return SizedBox(
      height: _bannerAd.size.height.toDouble(),
      width: _bannerAd.size.width.toDouble(),
      child: AdWidget(ad: _bannerAd),
    );
  }

  @override
  goToLangugePage() {
    Get.offNamed(LangugesPage.routName);
  }
}
