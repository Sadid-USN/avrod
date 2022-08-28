import 'dart:io';

import 'package:animate_icons/animate_icons.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/text_screen_controller.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class Audiplayer extends StatelessWidget {
  final List<dynamic>? texts;
  final String? titleAbbar;
  const Audiplayer({
    Key? key,
    this.texts,
    this.titleAbbar,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextScreenController>(
      dispose: (state) => Get.delete<TextScreenController>(),
      builder: (controller) => Container(
        margin: const EdgeInsets.only(right: 10.0, left: 10.0, bottom: 8.0),
        height: Platform.isIOS ? 70 : 65,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          color: audiplayerColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: Offset(2.0, 3.0),
              blurRadius: 5.0,
            ),
            // BoxShadow(
            //   color: Colors.black87,
            //   offset: Offset(-2, -0),
            //   blurRadius: 3.0,
            // ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimateIcons(
              startIcon: Icons.play_circle,
              endIcon: Icons.pause,
              controller: controller.buttonController,
              size: 30.0,
              onStartIconPress: () {
                controller.playSound(texts![controller.currentIndex]['url']);

                return true;
              },
              onEndIconPress: () {
                controller.playSound(texts![controller.currentIndex]['url']);
                return true;
              },
              duration: const Duration(milliseconds: 250),
              startIconColor: Colors.white,
              endIconColor: Colors.white,
              clockwise: false,
            ),
            Expanded(
              child: Row(
                children: [
                  controller.mySlider(),
                  controller.showPosition(),
                  AnimateIcons(
                    startIcon: Icons.copy,
                    endIcon: Icons.check_circle_outline,
                    controller: controller.animateIconController,
                    size: 25.0,
                    onStartIconPress: () {
                      if (Platform.isIOS) {
                        FlutterClipboard.copy(
                            '**$titleAbbar**\n\nТалаффуз:\n${texts![controller.currentIndex]['text']}\n\nАраби:\n${texts![controller.currentIndex]['arabic']}\n\nТарҷума:\n${texts![controller.currentIndex]['translation']}\n\nСадо 🎵:\n${texts![controller.currentIndex]['url']}\n\nБарномаи *Avrod* дар App Store\n👇👇👇👇\nhttps://apple.co/3GNRT3D');
                      } else {
                        FlutterClipboard.copy(
                            '**$titleAbbar**\n\nТалаффуз:\n${texts![controller.currentIndex]['text']}\n\nАраби:\n${texts![controller.currentIndex]['arabic']}\n\nТарҷума:\n${texts![controller.currentIndex]['translation']}\n\nСадо 🎵:\n${texts![controller.currentIndex]['url']}\n\nБарномаи *Avrod* дар Google Play\n👇👇👇👇\nhttps://bit.ly/3mdiwFw');
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
                  GestureDetector(
                    onTap: () {
                      if (Platform.isIOS) {
                        Share.share(
                            '**$titleAbbar**\n\nТалаффуз:\n${texts![controller.currentIndex]['text']}\n\nАраби:\n${texts![controller.currentIndex]['arabic']}\n\nТарҷума:\n${texts![controller.currentIndex]['translation']}\n\nAudio 🎵:\n${texts![controller.currentIndex]['url']}\n\nБарномаи *Avrod* дар App Store\n👇👇👇👇\nhttps://apple.co/3GNRT3D');
                      } else {
                        Share.share(
                            '**$titleAbbar**\n\nТалаффуз:\n${texts![controller.currentIndex]['text']}\n\nАраби:\n${texts![controller.currentIndex]['arabic']}\n\nТарҷума:\n${texts![controller.currentIndex]['translation']}\n\nAudio 🎵:\n${texts![controller.currentIndex]['url']}\n\nБарномаи *Avrod* дар Google Play\n👇👇👇👇\nhttps://bit.ly/3mdiwFw');
                      }
                    },
                    child: const Icon(Icons.share,
                        size: 25.0, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
