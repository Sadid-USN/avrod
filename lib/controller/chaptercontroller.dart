import 'dart:convert';
import 'package:avrod/localization/local_controller.dart';
import 'package:avrod/models/book.dart';
import 'package:avrod/models/chapter_model.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:avrod/services/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../main.dart';

abstract class MyChapterController extends GetxController {
  initHive();
  goToHomePage();
  goToTextSreen();

  saveLikedChapter(int chapterId, bool isLiked);
}

class ChapterController extends MyChapterController {
  LocalController localController = LocalController();
  MyServices myServices = Get.find();
  String? data;
  List<Book>? bookFromFB;
  TextEditingController textEditingController = TextEditingController();
  //DatabaseReference bookRuRef = FirebaseDatabase.instance.ref('book');
  DatabaseReference bookEnRef = FirebaseDatabase.instance.ref('book');
  List<ChaptersModel> searchResults = [];
 
  int currentIndex = 0;
   Box ? likesBox;





  @override
  Future<bool> saveLikedChapter(int chapterId, bool isLiked) async {
    if (!isLiked) {
      await likesBox!.put(chapterId, (false).toString());
      print("CHAPTER $chapterId WAS SAVED");
    } else {
      await likesBox!.delete(chapterId);
      print("CHAPTER $chapterId WAS DELETED");
    }

    return !isLiked;
  }

  bool isChapterLiked(int chapterID) {
    bool isLiked = likesBox!.containsKey(chapterID);
    return isLiked;
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    initHive();
    bookInit();

    super.onInit();
    update();
  }
    @override
    void initHive() async {
    likesBox = await Hive.openBox(FAVORITES_BOX);
  }

  Future<List<Book>> bookInit() async {
    bookEnRef.onValue.listen((event) {
      // convert object to JSON String
      data = jsonEncode(event.snapshot.value);
      // convert JSON into Map<String, dynamic>
      List<dynamic> jsonData = jsonDecode(data!);
      bookFromFB = jsonData.map((book) => Book.fromJson(book)).toList();
      update();
    });
    return bookFromFB!;
  }

 

  searchChapters(String searchText) {
    if (searchText.isEmpty) {
      // If search text is empty, show all chapters
      searchResults = bookFromFB!.expand((book) => book.chapters!).toList();
    } else {
      // Otherwise, filter chapters based on search text
      searchResults = bookFromFB!
          .expand((book) => book.chapters!)
          .where((chapter) =>
              chapter.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
    update();
  }

  @override
  goToHomePage() {
    Get.back();
  }

  @override
  goToTextSreen() {
    Get.offAllNamed(TextScreen.routName);
  }
}
