import 'dart:convert';
import 'package:avrod/localization/local_controller.dart';
import 'package:avrod/main.dart';
import 'package:avrod/screens/home_page.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:avrod/services/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class MyChapterController extends GetxController {
  initHive();
  setLike(String chapterID, bool isLiked, Map content);
  isChapterLiked(int chapterID);
  goToHomePage();
  goToTextSreen();
}

class ChapterController extends MyChapterController {
  LocalController localController = LocalController();
  MyServices myServices = Get.find();
  String? data;
  List<dynamic>? bookFromFB;
  List<dynamic>? chapters;

  //DatabaseReference bookRuRef = FirebaseDatabase.instance.ref('book');
  DatabaseReference bookEnRef = FirebaseDatabase.instance.ref('book');

  Box? likesBox;

  @override
  void onInit() {
    initHive();

    bookEnRef.onValue.listen((event) {
      // convert object to JSON String
      data = jsonEncode(event.snapshot.value);
      // convert JSON into Map<String, dynamic>
      bookFromFB = jsonDecode(data!);

      update();
    });

    super.onInit();
  }

  void foundChapter(String inputKeyWord) {
    List<dynamic>? results;
    if (inputKeyWord.isEmpty) {
      results = chapters;
    } else {
      // results!.contains([results].map((e) => e['name']));
    }
    update();
  }

  @override
  void initHive() async {
    likesBox = await Hive.openBox(FAVORITES_BOX);
  }

  @override
  Future<bool> setLike(String chapterID, bool isLiked, Map content) async {
    if (!isLiked) {
      await likesBox!.put(chapterID, content);
    } else {
      await likesBox!.delete(chapterID);
    }

    return !isLiked;
  }

  @override
  bool isChapterLiked(int chapterID) {
    bool isLiked = likesBox!.containsKey(chapterID);
    return isLiked;
  }

  @override
  goToHomePage() {
    Get.offAllNamed(HomePage.routName);
  }

  @override
  goToTextSreen() {
    Get.offAllNamed(TextScreen.routName);
  }
}
