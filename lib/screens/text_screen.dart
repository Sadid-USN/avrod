import 'package:avrod/models/text_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:avrod/controller/text_screen_controller.dart';
import '../constant/colors/colors.dart';
import 'content_alltext.dart';

class TextScreen extends StatelessWidget {
  final String? titleAbbar;

  final int? chapterID;

  final List<TextsModel>? texts;

  const TextScreen({
    Key? key,
    this.titleAbbar,
    this.texts,
    this.chapterID,
  }) : super(key: key);

  static String routName = '/textScreen';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextScreenController>(
      init: TextScreenController(),
      builder: (controller) => DefaultTabController(
        length: texts!.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      '$chapterID',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: listTitleColor,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      titleAbbar ?? "error",
                      style: TextStyle(
                          color: listTitleColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                controller.audioPlayer.stop();

                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            bottom: TabBar(
              indicatorColor: audiplayerColor,
              isScrollable: true,
              tabs: texts!.map((e) => Tab(text: e.id)).toList(),
            ),
          ),
          body: TabBarView(
            children: texts!.map(
              (e) {
                return Column(
                  children: [
                    Expanded(
                      child: ColoredBox(
                        color: bgColor,
                        child: Builder(builder: (context) {
                          return ContetAllTexts(
                            titleAbbar: titleAbbar,
                            textsModel: e,
                            text: e.text ?? "error",
                            arabic: e.arabic ?? "error",
                            translation: e.translation ?? "error",
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}

class PositioneData {
  final Duration positione;
  final Duration bufferedPosition;
  final Duration duration;
  PositioneData(
    this.positione,
    this.bufferedPosition,
    this.duration,
  );
}
