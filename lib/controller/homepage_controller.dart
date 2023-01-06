import 'dart:convert';

import 'package:avrod/Calendars/calendar_tabbar.dart';
import 'package:avrod/booksScreen/library_screen.dart';
import 'package:avrod/chat/helper/helper_function.dart';
import 'package:avrod/chat/pages/chat_home_page.dart';
import 'package:avrod/chat/pages/chat_search_page.dart';
import 'package:avrod/chat/pages/login_page.dart';
import 'package:avrod/chat/pages/profile_page.dart';
import 'package:avrod/chat/pages/register_page.dart';
import 'package:avrod/chat/services/auth_servisec.dart';
import 'package:avrod/chat/services/database_service.dart';
import 'package:avrod/chat/widgets/Input_decoration.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/screens/favorite_chapter_screen.dart';
import 'package:avrod/screens/languge.page.dart';
import 'package:avrod/screens/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
  // late BannerAd _bannerAd;

  bool isSignIn = false;
  bool isLoading = false;

  AuthService authService = AuthService();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get loginFormKey => _loginFormKey;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> get registerFormKey => _registerFormKey;
  String emailLogin = '';
  String passwordLogin = '';

  String fullName = '';
  String emailRegister = '';
  String passwordRegister = '';
  String groupName = '';

  Stream? groups;
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
      isSignIn
          ? Get.toNamed(ChatHomePage.routName)
          : Get.toNamed(LoginPage.routName);
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

    getUserLoggedInStatus();
    gettingUserData();
  }

  getdefaultDialog(String middleText, void Function() onConfirm) {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 16),
      buttonColor: audiplayerColor,
      radius: 16,
      title: '!',
      middleText: middleText,
      backgroundColor: appBabgColor,
      titleStyle: const TextStyle(color: Colors.yellow, fontSize: 30),
      middleTextStyle: const TextStyle(color: skipColor),
      onConfirm: onConfirm,
      onCancel: () {
        Get.close;
      },
    );
  }

  popUpDialog(
    String middleText,
    void Function() onConfirm,
  ) {
    showDialog(
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: const Center(child: Text('Гурӯҳи нав')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: audiplayerColor,
                      ))
                    : TextField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                            borderSide: const BorderSide(
                              color: navItemsColor,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                            borderSide: const BorderSide(
                              color: navItemsColor,
                              width: 1.0,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          groupName = value;
                          update();
                        },
                      ),

                //   SizedBox(height: 50, child: TextField()),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: bgColor, // Background color
                ),
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'Илғоъ',
                  style: TextStyle(color: skipColor),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: bgColor, // Background color
                ),
                onPressed: () async {
                  if (groupName != "") {
                    isLoading = true;
                    update();

                    DtabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                        .createGroup(fullName,
                            FirebaseAuth.instance.currentUser!.uid, groupName)
                        .whenComplete(() {
                      isLoading = false;
                      update();
                    });

                    Get.back();
                    Get.snackbar(
                      'Алҳамдулиллаҳ!',
                      "Гурӯҳ бо мувафақият эҷод шуд!",
                      colorText: skipColor,
                      backgroundColor: bgColor,
                      duration: const Duration(seconds: 4),
                      icon: const Icon(
                        Icons.add_alert,
                        color: Colors.white,
                      ),
                    );
                    // SnackBar(
                    //   content: const Text(''),
                    //   duration: const Duration(seconds: 1),
                    //   action: SnackBarAction(
                    //     label: 'ACTION',
                    //     onPressed: () {},
                    //   ),
                    // );
                  }
                },
                child: const Text(
                  'Иншо',
                  style: TextStyle(color: skipColor),
                ),
              ),
            ],
          );
        });
  }

  // _initBanner() {
  //   _bannerAd = BannerAd(
  //       size: AdSize.banner,
  //       adUnitId: 'ca-app-pub-7613540986721565/6723282918',
  //       listener: BannerAdListener(
  //         onAdLoaded: (ad) {
  //           isAdLoade = true;
  //           update();
  //         },
  //         onAdFailedToLoad: (ad, error) {},
  //       ),
  //       request: const AdRequest());

  //   _bannerAd.load();
  //   update();
  // }

  // Widget adBanner() {
  //   return SizedBox(
  //     height: _bannerAd.size.height.toDouble(),
  //     width: _bannerAd.size.width.toDouble(),
  //     child: AdWidget(ad: _bannerAd),
  //   );
  // }

  Future login() async {
    if (_loginFormKey.currentState!.validate()) {
      isLoading = true;
      update();
    }
    await authService
        .signInWithEmailAndPassword(emailLogin, passwordLogin)
        .then((value) async {
      if (value == true) {
        QuerySnapshot snapshot =
            await DtabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(emailLogin);
        // saving the values to our shared preferences
        await HelperFunction.saveUserLoggedInStatus(true);
        await HelperFunction.saveUserEmailSf(emailLogin);
        await HelperFunction.saveUserNameSf(
          snapshot.docs[0]['fullName'],
        );
        Get.offNamed(ChatHomePage.routName);
        update();
      } else {
        errorSnackbar();
        isLoading = false;

        update();
      }
    });
  }

  Future<void> gettingUserData() async {
    await HelperFunction.getUserNameFromSF().then((value) {
      fullName = value!;

      update();
    });

    await HelperFunction.getUserEmailFromSF().then((value) {
      emailLogin = value!;

      update();
    });
    //getting the list of snapshot in our stream
    await DtabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      groups = snapshot;
      update();
    });
  }

  Future register() async {
    if (_registerFormKey.currentState!.validate()) {
      isLoading = true;
      update();
    }
    await authService
        .registeUserWithEmailandPassword(
            fullName, emailRegister, passwordRegister)
        .then((value) async {
      if (value == true) {
        // saving the sharedpreference state
        await DtabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .gettingUserData(emailRegister);
        await HelperFunction.saveUserLoggedInStatus(true);
        await HelperFunction.saveUserEmailSf(emailRegister);
        await HelperFunction.saveUserNameSf(fullName);

        update();
      } else {
        existsAccountSnackbar();
        isLoading = false;
        update();
      }
    });
  }

  Future signOut() async {
    try {
      await HelperFunction.saveUserLoggedInStatus(false);
      await HelperFunction.saveUserEmailSf("");
      await HelperFunction.saveUserNameSf("");
      await authService.signOut();

      update();
    } catch (e) {
      return null;
    }
  }

  errorSnackbar() {
    Get.showSnackbar(
      GetSnackBar(
        borderRadius: 16,
        maxWidth: Get.context!.size!.width / 2 * 1.8,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        title: 'Исм ё рақами сирри хато аст!',
        message: 'Провайдери додашуда барои барномаи Firebase ғайрифаъол аст.',
        icon: const Icon(
          Icons.warning,
          color: Colors.yellow,
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  existsAccountSnackbar() {
    Get.showSnackbar(
      GetSnackBar(
        borderRadius: 16,
        maxWidth: Get.context!.size!.width / 2 * 1.8,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blueGrey,
        title: 'Хатоги дар эҷоди исм!',
        message:
            'Чунин ҳисоб аллакай вуҷуд дорад, лутфан дигар почтаро ихтиёр кунед!',
        icon: const Icon(
          Icons.warning,
          color: Colors.yellow,
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  void onChangedRegisterEmail(String value) {
    emailRegister = value;

    update();
  }

  void onChangedFullName(String value) {
    fullName = value;

    update();
  }

  void onChangedRegisterPassword(String value) {
    passwordRegister = value;

    update();
  }

  void onChangedLoginEmail(String value) {
    emailLogin = value;

    update();
  }

  void onChangedLoginPassword(String value) {
    passwordLogin = value;
    // print(passwordLogin);

    update();
  }

  @override
  goToLangugePage() {
    Get.offNamed(LangugesPage.routName);
  }

  goToRegisterPage() {
    Get.offNamed(RegisterPage.routName);
  }

  goToLogin() {
    Get.offNamed(LoginPage.routName);
  }

  goToProfilePage() {
    Get.toNamed(ProfilePage.routName);
  }

  goToChatSearcPage() {
    Get.toNamed(ChatSearchPage.routName);
  }

  goToChatHomePage() {
    Get.offNamed(ChatHomePage.routName);
  }

  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        isSignIn = value;
      }
    });
  }
}
