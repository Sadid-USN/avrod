import 'package:avrod/constant/routes/route_names.dart';
import 'package:avrod/main.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class FavoriteScreenController extends GetxController {
  Box? likesBox;

  Future<void> setLike(String chapterID, bool isLiked, Map content) async {
    await likesBox!.delete(chapterID);
    update();
  }

  bool isChapterLiked(String chapterID) {
    bool isLiked = likesBox!.containsKey(chapterID);

    return isLiked;
  }

  @override
  void onInit() {
    likesBox = Hive.box(FAVORITES_BOX);
    super.onInit();
  }

  goToHomePage() {
    Get.offNamed(AppRouteNames.homepage);
  }
}
