// import 'package:animate_icons/animate_icons.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AudioPlayerController extends GetxController {
//   AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
//   bool isPlaying = false;
//   Duration duration = const Duration();
//   Duration position = const Duration();
//     double fontSize = 16.0;
//   int currentIndex = 0;
//   double? newSize;

//   AnimateIconController animateIconController = AnimateIconController();
//   AnimateIconController buttonController = AnimateIconController();

//   @override
//   void dispose() {
//     //Get.delete<TextScreenController>();
//     audioPlayer.dispose();

//     super.dispose();
//   }

//   playSound(String url) async {
//     if (isPlaying) {
//       var result = await audioPlayer.pause();

//       if (result == 1) {
//         isPlaying = false;
//         update();
//       }
//     } else if (!isPlaying) {
//       var result = await audioPlayer.play(url);
//       if (result == 1) {
//         isPlaying = true;
//         update();
//       }
//     }

//     audioPlayer.onDurationChanged.listen((event) {
//       duration = event;
//       update();
//     });
//     audioPlayer.onAudioPositionChanged.listen((event) {
//       position = event;
//       update();
//     });
//   }

//   void seekAudio(Duration durationToSeek) {
//     audioPlayer.seek(durationToSeek);
//     update();
//   }

//   Widget mySlider() {
//     return SizedBox(
//       width: 180.0,
//       child: Slider(
//         onChanged: (double newPosition) {
//           seekAudio(Duration(seconds: newPosition.round()));
//           update();
//         },
//         onChangeEnd: ((value) {}),
//         activeColor: Colors.white,
//         inactiveColor: Colors.blueGrey,
//         min: 0.0,
//         max: duration.inSeconds.toDouble(),
//         value: position.inSeconds.toDouble(),
//       ),
//     );
//   }

//   Widget showPosition() {
//     return Expanded(
//         child: Text(
//       position.toString().split('.').first,
//       style: const TextStyle(fontSize: 10, color: Colors.white),
//     ));
//   }
// }
