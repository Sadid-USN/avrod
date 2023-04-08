// import 'package:avrod/controller/chaptercontroller.dart';
// import 'package:avrod/main.dart';
// import 'package:avrod/models/text_model.dart';
// import 'package:avrod/screens/home_page.dart';
// import 'package:get/get.dart';
// import 'package:hive_flutter/adapters.dart';

// class FavoriteScreenController extends GetxController {
//   Box<List<TextsModel>>? likesBox;

//   ChapterController chapterController = Get.put(ChapterController());

//   Future<void> setLike(
//       String chapterID, bool isLiked, List<TextsModel> content) async {
//     await likesBox!.delete(chapterID);
//     update();
//   }

//   bool isChapterLiked(String chapterID) {
//     bool isLiked = likesBox!.containsKey(chapterID);

//     return isLiked;
//   }

//   @override
//   void onInit() {
//     likesBox = Hive.box(FAVORITES_BOX);
//     super.onInit();
//   }

//   goToHomePage() {
//     Get.offNamed(HomePage.routName);
//   }
// }
