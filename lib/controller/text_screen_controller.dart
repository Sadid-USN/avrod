import 'package:animate_icons/animate_icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:avrod/main.dart';
import 'package:avrod/models/text_model.dart';
import 'package:avrod/screens/audioplayer.dart';
import 'package:avrod/screens/chapter_screen.dart';
import 'package:avrod/screens/content_alltext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../helper/text_storage.dart';

class TextScreenController extends GetxController {
  double fontSize = 16.0;
  double fontSizeIncrease = 25.0;

  int currentIndex = 0;
  double? newSize;

  AnimateIconController animateIconController = AnimateIconController();
  AnimateIconController buttonController = AnimateIconController();
  Duration duration = const Duration();
  Duration position = const Duration();
  //double sliderPosition = 0.0;
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;

  // void stopPlaying(String url) async {
  //   if (isPlaying) {
  //     var reslult = await audioPlayer.pause();
  //     if (reslult == 1) {
  //       isPlaying = false;
  //       audioPlayer.stop();
  //       update();
  //     }
  //   }
  // }
  @override
  void onInit() {
    super.onInit();
    fontSize = textStorage.read('fontSize') ?? 16.0;
  }

  playSound(String url) async {
    if (isPlaying) {
      var result = await audioPlayer.pause();
      update();
      if (result == 1) {
        isPlaying = false;
        update();
      }
    } else if (!isPlaying) {
      var result = await audioPlayer.play(url);
      if (result == 1) {
        isPlaying = true;
        update();
      }
    }

    audioPlayer.onDurationChanged.listen((event) {
      duration = event;
      update();
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      position = event;
      update();
    });

    audioPlayer.onPlayerCompletion.listen((event) {
      isPlaying = false;
      position = const Duration(seconds: 0);
      update();
    });
  }

  IconData chengeIcon(bool condition) {
    return isPlaying ? Icons.pause : Icons.play_circle;
  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
    update();
  }

  Widget buildBook(
    TextsModel text,
    int index,
  ) {
    currentIndex = index;
    return ContetAllTexts(
      text: text.text!,
      arabic: text.arabic!,
      translation: text.translation!,
    );
  }

  deletAllControllers() {
    Get.delete<TextScreenController>();
  }

  void increaseSize() {
    if (fontSize < 25.0) {
      fontSize++;
      textStorage.write('fontSize', fontSize);
    }
    update();
  }

  void decreaseSize() {
    if (fontSize > 16.0) {
      fontSize--;
      textStorage.write('fontSize', fontSize);
    }
    update();
  }

  void getDialog(Widget title) {
    Get.dialog(
      AlertDialog(
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Ҳаҷми чоп'),
            const SizedBox(
              height: 16,
            ),
            Center(child: title),
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Сабт"),
            onPressed: () => Get.back(),
          ),
         
        ],
      ),
    );
  }

  goToChapterScreen() {
    Get.to(ChapterScreen.routName);
  }

  myAudioPlayer(List<TextsModel>? texts, String? titleAbbar) {
    return Audiplayer(
      titleAbbar: titleAbbar,
      texts: texts,
    );
  }
}
