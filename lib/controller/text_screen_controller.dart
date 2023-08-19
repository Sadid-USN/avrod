import 'package:animate_icons/animate_icons.dart';

import 'package:avrod/main.dart';
import 'package:avrod/models/text_model.dart';
import 'package:avrod/screens/audioplayer.dart';
import 'package:avrod/screens/chapter_screen.dart';
import 'package:avrod/screens/content_alltext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart' as get_rx;
import 'package:rxdart/rxdart.dart' as rxdart;

import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../helper/text_storage.dart';
import '../screens/text_screen.dart';

class TextScreenController extends GetxController {
  double fontSize = 16.0;

  int currentIndex = 0;
  double? newSize;

  AnimateIconController animateIconController = AnimateIconController();
  AnimateIconController buttonController = AnimateIconController();
  Duration duration = const Duration();
  Duration position = const Duration();
  //double sliderPosition = 0.0;

  @override
  void onInit() {
    super.onInit();
    fontSize = textStorage.read('fontSize') ?? 16.0;
   
  }

  late final List<AudioPlayer> _audioPlayers;

  getAudioPlayers(int trackCount) {
    _audioPlayers = List.generate(trackCount, (_) => AudioPlayer());
  }

  late final AudioPlayer _audioPlayer = AudioPlayer();

  AudioPlayer get audioPlayer => _audioPlayer;

  List<AudioPlayer> get audioPlayers => _audioPlayers;

// void refreshAudioUrls() {
//   for (int i = 0; i < listInfo.length; i++) {
//     listInfo[i].audioUrl = generateRandomAudioUrl();
//     notifyListeners();
//   }
// }

  Stream<PositioneData> get positioneDataStream =>
      rxdart.Rx.combineLatest3<Duration, Duration, Duration?, PositioneData>(
          _audioPlayer.positionStream,
          _audioPlayer.bufferedPositionStream,
          _audioPlayer.durationStream,
          (positione, bufferedPosition, duration) => PositioneData(
                positione,
                bufferedPosition,
                duration ?? Duration.zero,
              ));

  void playAudio({
    required String url,
    required String id,
    required String title,
  }) {
    _audioPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: id,
          title: title,
        ),
      ),
    );
    _audioPlayer.play();

    update();
  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
    update();
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

  goToChapterScreen() {
    Get.to(ChapterScreen.routName);
  }

  // myAudioPlayer(List<TextsModel>? texts, String? titleAbbar, int index) {
  //   return Audiplayer(
  //     index: index,
  //     titleAbbar: titleAbbar,
  //     texts: texts,
  //   );
  // }
}
