import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/text_screen_controller.dart';
import 'package:avrod/core/addbunner_helper.dart';
import 'package:avrod/utility/texts/arabic_text.dart';
import 'package:avrod/utility/font_magnifier_button.dart';
import 'package:avrod/utility/texts/pronunciation_text.dart';
import 'package:avrod/utility/texts/translation_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../models/text_model.dart';
import 'audioplayer.dart';

class ContetAllTexts extends StatefulWidget {
  final String text, arabic, translation;

  final String? titleAbbar;
  final TextsModel? textsModel;

  const ContetAllTexts({
    Key? key,
    required this.text,
    required this.translation,
    required this.arabic,
    required this.textsModel,
    this.titleAbbar,
  }) : super(key: key);

  @override
  State<ContetAllTexts> createState() => _ContetAllTextsState();
}

class _ContetAllTextsState extends State<ContetAllTexts> {
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

  // double _fontSize = 16.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: GetBuilder<TextScreenController>(
        builder: (controller) => ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              // ignore: sized_box_for_whitespace
              child: Column(
                children: [
                  bannerAdHelper.isBannerAd
                      ? SizedBox(
                          height:
                              bannerAdHelper.bannerAd.size.height.toDouble(),
                          width: bannerAdHelper.bannerAd.size.width.toDouble(),
                          child: AdWidget(ad: bannerAdHelper.bannerAd),
                        )
                      : const SizedBox(
                          height: 20,
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        controller.fontSize.toString().split(".").first,
                        style: const TextStyle(
                            fontSize: 18,
                            color: audiplayerColor,
                            fontWeight: FontWeight.w600),
                      ),
                      const FontMagnifiereButton(),
                    ],
                  ),
                  PronunciationText(
                    text: widget.text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ArabicText(
                    arabic: widget.arabic,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TranslationText(
                    translation: widget.translation,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2 * 0.4,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: ColoredBox(
        color: bgColor,
        child: Audiplayer(
          textModel: widget.textsModel!,
          titleAbbar: widget.titleAbbar,
        ),
      ),
    );
  }
}
