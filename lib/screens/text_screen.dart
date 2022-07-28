import 'dart:io';

import 'package:animate_icons/animate_icons.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

import 'package:avrod/controller/text_screen_controller.dart';
import 'package:avrod/screens/content_alltext.dart';

import '../constant/colors/colors.dart';

class TextScreen extends StatelessWidget {
  final String? titleAbbar;

  final int? textsIndex;

  final List<dynamic>? texts;

  TextScreen({
    Key? key,
    this.titleAbbar,
    this.textsIndex,
    this.texts,
  }) : super(key: key);

  TextScreenController controller = Get.put(TextScreenController());
  Widget buildBook(
    var text,
    int index,
  ) {
    controller.currentIndex = index;
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ContetAllTexts(
          text: text['text'],
          arabic: text['arabic'],
          translation: text['translation'],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextScreenController>(
      builder: (controller) => DefaultTabController(
        length: texts!.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            title: SizedBox(
              height: 20,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    titleAbbar!,
                    style: TextStyle(
                        color: listTitleColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                controller.audioPlayer.stop();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              isScrollable: true,
              tabs: texts!.map((e) => Tab(text: e['id'])).toList(),
            ),
          ),
          body: TabBarView(
            children: texts!
                .map(
                  (e) => Container(
                    color: bgColor,
                    child: Builder(builder: (context) {
                      return buildBook(
                        e,
                        texts!.indexOf(e),
                      );
                    }),
                  ),
                )
                .toList(),
          ),
          bottomSheet: Container(
            // padding: const EdgeInsets.symmetric(horizontal: 5),
            height: Platform.isIOS ? 70 : 60,
            decoration: const BoxDecoration(
              color: audiplayerColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black87,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 6.0),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimateIcons(
                  startIcon: Icons.play_circle,
                  endIcon: Icons.pause,
                  controller: controller.buttonController,
                  size: 30.0,
                  onStartIconPress: () {
                    controller
                        .playSound(texts![controller.currentIndex]['url']);

                    return true;
                  },
                  onEndIconPress: () {
                    controller
                        .playSound(texts![controller.currentIndex]['url']);
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
                        controller: controller.controller,
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
        ),
      ),
    );
  }
}
