import 'dart:io';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/screens/home_page.dart';
import 'package:avrod/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../language_storage.dart';

class LocalController extends GetxController {
  // ThemeData appTheme = tajikTheme;
  // Rx<Locale>? language;
  Locale? defaultLanguge;
  MyServices myServices = Get.find();

  void onLanguageTapped(String languageCode, String countryCode) {
    Get.updateLocale(Locale(languageCode, countryCode));
    languageBox.write('code', languageCode);
    Intl.defaultLocale = languageCode;
    Get.back();
  }

  Future<bool?> exitDialog() {
    return Get.defaultDialog(
      buttonColor: signinButtonColor,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      textConfirm: 'textConfirm'.tr,
      textCancel: 'textCancel'.tr,
      confirmTextColor: whiteColor,
      onConfirm: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else {}
      },
      onCancel: () {},
      title: "",
      middleText: "middleText".tr,
      backgroundColor: whiteColor,
      titleStyle: const TextStyle(color: titleColor),
      middleTextStyle: const TextStyle(color: titleColor, fontSize: 14),
    );
  }

  @override
  void onInit() {
    String? sharedLang = myServices.sharedPreferences.getString('lang');
    if (sharedLang == 'en') {
      defaultLanguge = const Locale('en');
    } else if (sharedLang == 'ru') {
      defaultLanguge = const Locale('ru');
    } else {
      defaultLanguge = const Locale('en');

      defaultLanguge = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
    update();
  }

  goToHomePage() {
    myServices.sharedPreferences.setString("homepage", "1");
    Get.offNamed(HomePage.routName);
    update();
  }
}
