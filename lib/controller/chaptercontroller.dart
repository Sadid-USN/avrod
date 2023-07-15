import 'dart:convert';
import 'package:avrod/controller/text_screen_controller.dart';
import 'package:avrod/localization/local_controller.dart';
import 'package:avrod/models/book.dart';
import 'package:avrod/models/chapter_model.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:avrod/services/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class MyChapterController extends GetxController {
  initHive();
  goToHomePage();
  goToTextSreen();
  isChapterLiked(ChaptersModel chapter);
  saveLikedChapter(ChaptersModel chapter, bool isLiked);
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
  final likes = GetStorage("chapters");
  int currentIndex = 0;
  



  
 
  

  @override
  Future<void> saveLikedChapter(ChaptersModel chapter, bool isLiked) async {
    if (isLiked) {
      // Глава еще не сохранена, сохраняем её
      await likes.write(chapter.id.toString(), chapter);
      print(chapter.id);
    } else {
      // Проверяем, есть ли глава в коллекции likes
      final isChapterSaved = await likes.getValues();
      if (isChapterSaved != null) {
        // Глава уже сохранена, удаляем её
        await likes.remove(chapter.id.toString());
        print("CHAPTER ${chapter.id} REMOVED");
      }
    }
  }

  @override
  bool isChapterLiked(ChaptersModel chapter) {
    final likes = GetStorage();
    return likes.hasData(chapter.id.toString());
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

  @override
  void initHive() async {
    // likesBox = await Hive.openBox(FAVORITES_BOX);
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
