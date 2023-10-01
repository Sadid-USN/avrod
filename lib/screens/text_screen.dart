import 'package:avrod/core/addbunner_helper.dart';
import 'package:avrod/models/text_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:avrod/controller/text_screen_controller.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../constant/colors/colors.dart';
import 'content_alltext.dart';

class TextScreen extends StatefulWidget {
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
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  BannerAdHelper bannerAdHelper = BannerAdHelper();

  @override
  void initState() {
    super.initState();

    bannerAdHelper.initializeAdMob(
      onAdLoaded: (ad) {
        setState(() {
          bannerAdHelper.isBannerAd = true;
        });
      },
    );
  }

  @override
  void dispose() {
    bannerAdHelper.bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextScreenController>(
      init: TextScreenController(),
      builder: (controller) => DefaultTabController(
        length: widget.texts!.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: SafeArea(
              child:
                  bannerAdHelper.isBannerAd
                      ? SizedBox(
                          height:
                              bannerAdHelper.bannerAd.size.height.toDouble(),
                          width: bannerAdHelper.bannerAd.size.width.toDouble(),
                          child: AdWidget(ad: bannerAdHelper.bannerAd),
                        )
                      : const SizedBox(),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         '${widget.chapterID}',
                  //         textAlign: TextAlign.center,
                  //         style: TextStyle(
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600,
                  //           color: listTitleColor,
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text(
                  //         widget.titleAbbar ?? "error",
                  //         style: TextStyle(
                  //             color: listTitleColor,
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
              
            ),
            // title:
            // SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         Text(
            //           '${widget.chapterID}',
            //           textAlign: TextAlign.center,
            //           style: TextStyle(
            //             fontSize: 14,
            //             fontWeight: FontWeight.w600,
            //             color: listTitleColor,
            //           ),
            //         ),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         Text(
            //           widget.titleAbbar ?? "error",
            //           style: TextStyle(
            //               color: listTitleColor,
            //               fontSize: 14,
            //               fontWeight: FontWeight.bold),
            //         ),
            //       ],
            //     )),
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
              tabs: widget.texts!.map((e) => Tab(text: e.id)).toList(),
            ),
          ),
          body: TabBarView(
            children: widget.texts!.map(
              (e) {
                return ColoredBox(
                  color: bgColor,
                  child: Builder(builder: (context) {
                    return ContetAllTexts(
                      titleAbbar: widget.titleAbbar,
                      textsModel: e,
                      text: e.text ?? "error",
                      arabic: e.arabic ?? "error",
                      translation: e.translation ?? "error",
                    );
                  }),
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
