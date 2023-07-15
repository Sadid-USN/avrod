import 'dart:io';

import 'package:animate_icons/animate_icons.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/text_screen_controller.dart';
import 'package:avrod/models/text_model.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:avrod/widgets/audio/duration_and_position.dart';
import 'package:avrod/widgets/audio/my_slider.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class Audiplayer extends StatelessWidget {
  final TextsModel textModel;
  final String? titleAbbar;


  const Audiplayer({
    Key? key,
   required this.textModel,
    this.titleAbbar,

   
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextScreenController>(
      dispose: (state) => state.controller!.audioPlayer.stop(),
      builder: (controller) {
    
        return Container(
          margin: const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 8.0),
          height: MediaQuery.of(context).size.height / 2 * 0.3,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            color: audiplayerColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                offset: Offset(3.0, 3.0),
                blurRadius: 6.0,
              ),
            ],
          ),
          child: Column(
            children: [
              const Spacer(
                flex: 3,
              ),
              // GetBuilder<TextScreenController>(
              //   builder: (_) => DurationAndPosition(
              //     duration: controller.duration,
              //     position: controller.position,
              //   ),
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimateIcons(
                    startIcon: Icons.copy,
                    endIcon: Icons.check_circle_outline,
                    controller: controller.animateIconController,
                    size: 25.0,
                    onStartIconPress: () {
                      if (Platform.isIOS) {
                        FlutterClipboard.copy(
                            '**$titleAbbar**\n\nТалаффуз:\n${textModel.text}\n\nАраби:\n${textModel.arabic}\n\nТарҷума:\n${textModel.translation}\n\nСадо 🎵:\n${textModel.url}\n\nБарномаи *Avrod* дар App Store\n👇👇👇👇\nhttps://apple.co/3GNRT3D');
                      } else {
                        FlutterClipboard.copy(
                            '**$titleAbbar**\n\nТалаффуз:\n${textModel.text}\n\nАраби:\n${textModel.arabic}\n\nТарҷума:\n${textModel.translation}\n\nСадо 🎵:\n${textModel.url}\n\nБарномаи *Avrod* дар Google Play\n👇👇👇👇\nhttps://bit.ly/3mdiwFw');
                      }

                      return true;
                    },
                    onEndIconPress: () {
                      return true;
                    },
                    duration: const Duration(milliseconds: 250),
                    startIconColor: Colors.white,
                    endIconColor: Colors.white,
                    clockwise: false,
                  ),
                  AnimateIcons(
                    startIcon: Icons.play_circle_outline,
                    endIcon: Icons.pause_circle_outline,
                    controller: controller.buttonController,
                    size: 40.0,
                    onStartIconPress: () {
                      controller.playAudio(
                        url: textModel.url?? "",
                        id: textModel.id!,
                        title: titleAbbar ?? "",
                      );

                      return true;
                    },
                    onEndIconPress: () {
                      // controller.playSound(
                      //     texts![controller.currentIndex].url ?? 'error url');
                      controller.audioPlayer.pause();
                      return true;
                    },
                    duration: const Duration(milliseconds: 250),
                    startIconColor: Colors.white,
                    endIconColor: Colors.white,
                    clockwise: false,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (Platform.isIOS) {
                        Share.share(
                            '**$titleAbbar**\n\nТалаффуз:\n${textModel.text}\n\nАраби:\n${textModel.arabic}\n\nТарҷума:\n${textModel.translation}\n\nAudio 🎵:\n${textModel.url}\n\nБарномаи *Avrod* дар App Store\n👇👇👇👇\nhttps://apple.co/3GNRT3D');
                      } else {
                        Share.share(
                            '**$titleAbbar**\n\nТалаффуз:\n${textModel.text}\n\nАраби:\n${textModel.arabic}\n\nТарҷума:\n${textModel.translation}\n\nAudio 🎵:\n${textModel.url}\n\nБарномаи *Avrod* дар Google Play\n👇👇👇👇\nhttps://bit.ly/3mdiwFw');
                      }
                    },
                    child: const Icon(Icons.share,
                        size: 25.0, color: Colors.white),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<PositioneData>(
                        stream: controller.positioneDataStream,
                        builder: (context, snapshot) {
                          final positionData = snapshot.data;

                          return SizedBox(
                            width: 250,
                            child: ProgressBar(
                              barHeight: 4,
                              baseBarColor: Colors.grey.shade400,
                              bufferedBarColor: Colors.white,
                              thumbColor: Colors.white,
                              thumbRadius: 6,
                              timeLabelTextStyle: const TextStyle(
                                  height: 1.2,
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              progress:
                                  positionData?.positione ?? Duration.zero,
                              buffered: positionData?.bufferedPosition ??
                                  Duration.zero,
                              total: positionData?.duration ?? Duration.zero,
                              onSeek: controller.audioPlayer.seek,
                            ),
                          );
                        }),
                  ],
                ),
              ),

              const Spacer(
                flex: 2,
              ),
            ],
          ),
        );
      },
    );
  }
}
