import 'dart:convert';
import 'dart:io' show Platform;

import 'package:avrod/constant/routes/route_names.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Calendars/calendar_tabbar.dart';

abstract class HomeController extends GetxController {
  final String googlePlayLink =
      'https://play.google.com/store/apps/details?id=com.darulasar.avrod';
  final String appStoreLink =
      'https://apps.apple.com/ru/app/avrod/id1626614344?l=en';
  int currrentIndexTab = 2;
  onTapCurvedNavigationBar(int index);
  launchInBrowser(String url);
  goToLangugePage();
}

class HomePageController extends HomeController {
  //Dcloration
  String? data;
  List<dynamic>? book;
  DatabaseReference bookRef = FirebaseDatabase.instance.ref('book');

  @override
  Future<void> launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: false,
          forceWebView: false,
          headers: <String, String>{'header_key': 'header_value'});
    } else {
      throw 'Пайванд кушода нашуд $url';
    }
  }

  @override
  onTapCurvedNavigationBar(int index) {
    currrentIndexTab = index;
    if (index == 0) {
      Get.offNamed(AppRouteNames.searchScreen);
    } else if (index == 1) {
      Get.offNamed(AppRouteNames.selectedBooks);
    } else if (index == 2) {
      Get.offNamed(AppRouteNames.favorite);
    } else if (index == 3) {
      Get.to(const CalendarTabBarView());
    } else if (index == 4) {
      if (Platform.isAndroid) {
        launchInBrowser(googlePlayLink);

        // Android-specific code
      } else if (Platform.isIOS) {
        launchInBrowser(appStoreLink);

        // iOS-specific code
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
  }

  @override
  goToLangugePage() {
    Get.offNamed(AppRouteNames.languge);
  }
}
