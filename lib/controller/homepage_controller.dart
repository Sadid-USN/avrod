import 'dart:convert';
import 'package:avrod/booksScreen/library_screen.dart';
import 'package:avrod/chat/helper/helper_function.dart';
import 'package:avrod/chat/pages/groups_home_page.dart';
import 'package:avrod/chat/pages/chat_search_page.dart';
import 'package:avrod/chat/pages/auth/login_page.dart';
import 'package:avrod/chat/pages/profile_page.dart';
import 'package:avrod/chat/pages/auth/register_page.dart';
import 'package:avrod/chat/services/auth_servisec.dart';
import 'package:avrod/chat/services/database_service.dart';
import 'package:avrod/chat/widgets/Input_decoration.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/chaptercontroller.dart';
import 'package:avrod/screens/favorite_chapter_screen.dart';
import 'package:avrod/screens/home_page.dart';
import 'package:avrod/screens/languge.page.dart';
import 'package:avrod/screens/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Calendars/gregorian_calendar.dart';

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
  ChapterController get chapterController => ChapterController();
  bool isSignIn = false;
  bool isLoading = false;
  

  AuthService authService = AuthService();

  final GlobalKey<FormState> registerFormKey = GlobalKey<FormState>();

  String emailLogin = '';
  String passwordLogin = '';
  bool passwordVisible = true;

  String emailRegister = '';
  String passwordRegister = '';

  String fullName = '';
  String groupName = '';
  String groupId = '';

  Stream? groups;

  @override
  void onInit() {
    super.onInit();
    groups;
  }

  @override
  void dispose() {
    groups;
    super.dispose();
  }

  @override
  void onReady() {
    bookRef.onValue.listen((event) {
      // convert object to JSON String
      data = jsonEncode(event.snapshot.value);
      // convert JSON into Map<String, dynamic>
      book = jsonDecode(data!);
      update();
    });

    update();
    super.onReady();

    isLoading;
    isSignIn;
    groups;

    getUserLoggedInStatus();
    gettingUserData();
    update();
    super.onReady();
  }

  final Stream<QuerySnapshot> books = FirebaseFirestore.instance
      .collection('books')
      .orderBy(
        'author',
      )
      .snapshots();

  @override
  onTapCurvedNavigationBar(int index) {
    currrentIndexTab = index;
    if (index == 0) {
      Get.toNamed(SearchScreen.routName, parameters: {});
    } else if (index == 1) {
      Get.toNamed(LibraryScreen.routName);
    } else if (index == 2) {
      Get.toNamed(FavoriteChaptersScreen.routName);
    } else if (index == 3) {
      Get.toNamed(GregorianCalendar.routName);
    } else if (index == 4) {
      isSignIn ? Get.toNamed(GroupsHomePage.routName) : goToLogin();
    }
    update();
  }

  String getGroupId(String id) {
    return id.split('_').first;
  }

  String getGroupName(String name) {
    return name.split('_').last;
  }

  getUserLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value != null) {
        isSignIn = value;
        update();
      }
    });
  }

  exitDialog(String middleText, void Function()? onPressed) {
    showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) {
          return AlertDialog(
            title: Center(child: Text(middleText)),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                //   SizedBox(height: 50, child: TextField()),
              ],
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: bgColor, // Background color
                ),
                onPressed: () {
                  Navigator.of(context).pop();
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
                onPressed: onPressed,
                child: const Text(
                  'Бале',
                  style: TextStyle(color: skipColor),
                ),
              ),
            ],
          );
        });
  }

  popUpDialog(String middleText) {
    showDialog(
        barrierDismissible: false,
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
                      colorText: Colors.white,
                      backgroundColor: audiplayerColor.withOpacity(0.7),
                      duration: const Duration(seconds: 4),
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(
                        Icons.add_alert,
                        color: Colors.white,
                      ),
                    );
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

  // Future<void> login() async {
  //   if (loginFormKey.currentState!.validate()) {
  //     isLoading = true;
  //     update();
  //   }
  //   await authService
  //       .signInWithEmailAndPassword(emailLogin, passwordLogin)
  //       .then((value) async {
  //     if (value == true) {
  //       QuerySnapshot snapshot =
  //           await DtabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //               .gettingUserData(emailLogin)
  //               .whenComplete(() {
  //         if (currrentIndexTab == 1) {
  //           Get.offNamed(LibraryScreen.routName);
  //         } else {
  //           goToChatHomePage();
  //           update();
  //         }
  //       });
  //       // saving the values to our shared preferences
  //       await HelperFunction.saveUserLoggedInStatus(true);
  //       await HelperFunction.saveUserEmailSf(emailLogin);
  //       await HelperFunction.saveUserNameSf(
  //         snapshot.docs[0]['fullName'],
  //       );
  //       // Get.offNamed(ChatHomePage.routName);
  //       // update();
  //     } else {
  //       errorSnackbar();
  //       isLoading = false;

  //       update();
  //     }
  //   });
  // }

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

  Future<void> register() async {
    if (registerFormKey.currentState!.validate()) {
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
            .gettingUserData(emailRegister)
            .whenComplete(() {
          goToChatHomePage();
          update();
        });
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
      await authService.signOut().whenComplete(() {
        goToLogin();
      });

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
    Get.to(() => const LangugesPage());
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
    Get.toNamed(GroupsHomePage.routName);
  }

  goToHomePage() {
    Get.offAllNamed(HomePage.routName);
  }
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