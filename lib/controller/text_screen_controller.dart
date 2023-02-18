import 'package:animate_icons/animate_icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:avrod/main.dart';
import 'package:avrod/screens/audioplayer.dart';
import 'package:avrod/screens/chapter_screen.dart';
import 'package:avrod/screens/content_alltext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

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

  Box? saveFontSize;

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
    var text,
    int index,
  ) {
    currentIndex = index;
    return ContetAllTexts(
      text: text['text'],
      arabic: text['arabic'],
      translation: text['translation'],
    );
  }

  // Widget showPosition() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       const Spacer(),
  //       Container(
  //         padding: const EdgeInsets.all(4),
  //         decoration: BoxDecoration(
  //           border: Border.all(width: 2, color: Colors.white),
  //           borderRadius: const BorderRadius.all(
  //             Radius.circular(12),
  //           ),
  //         ),
  //         child: Text(
  //           duration.toString().split('.').first,
  //           style: const TextStyle(fontSize: 10, color: Colors.white),
  //         ),
  //       ),
  //       const Spacer(
  //         flex: 3,
  //       ),
  //       Container(
  //         padding: const EdgeInsets.all(4),
  //         decoration: BoxDecoration(
  //           border: Border.all(width: 2, color: Colors.white),
  //           borderRadius: const BorderRadius.all(
  //             Radius.circular(12),
  //           ),
  //         ),
  //         child: Text(
  //           position.toString().split('.').first,
  //           style: const TextStyle(fontSize: 10, color: Colors.white),
  //         ),
  //       ),
  //       const Spacer(),
  //     ],
  //   );
  // }

  // Widget showDuration() {
  //   return Expanded(
  //       child: Text(
  //     duration.toString().split('.').first,
  //     style: const TextStyle(fontSize: 10, color: Colors.white),
  //   ));
  // }

  deletAllControllers() {
    Get.delete<TextScreenController>();
  }

  void initFont() async {
    saveFontSize = await Hive.openBox(FAVORITES_BOX);
    update();
  }

  increaseSize() {
    if (fontSize < 25.0) {
      fontSize++;
    }
    update();
  }

  decreaseSize() {
    if (fontSize > 16.0) {
      fontSize--;
    }
    update();
  }

  Future<double> setFont(double font) async {
    fontSize = font;
    if (fontSize > 0) {
      await saveFontSize!.put(font, fontSize);
      print(fontSize);
      update();
    }
    return font;
  }

  onChangedSliderSize(double newSize) {
    fontSize = newSize;
    setFont(fontSize);

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
            child: const Text("Пӯшонидан"),
            onPressed: () => Get.back(),
          ),
        ],
      ),
    );
  }

  goToChapterScreen() {
    Get.to(ChapterScreen.routName);
  }

  myAudioPlayer(List<dynamic>? texts, String? titleAbbar) {
    return Audiplayer(
      titleAbbar: titleAbbar,
      texts: texts,
    );
  }
}
