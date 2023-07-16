import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/text_screen_controller.dart';
import 'package:avrod/utility/texts/arabic_text.dart';
import 'package:avrod/utility/font_magnifier_button.dart';
import 'package:avrod/utility/texts/pronunciation_text.dart';
import 'package:avrod/utility/texts/translation_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/text_model.dart';
import 'audioplayer.dart';

class ContetAllTexts extends StatelessWidget {
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

  // double _fontSize = 16.0;
  // int currentIndex = 0;
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
                  const SizedBox(
                    height: 10,
                  ),
                  // todo FONTSIZE
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
                    text: text,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ArabicText(
                    arabic: arabic,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TranslationText(
                    translation: translation,
                  ),

                   SizedBox(
                  height: MediaQuery.of(context).size.height / 2 * 0.3,
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
          
          textModel: textsModel!,
          titleAbbar: titleAbbar,
        ),
      ),
    );
  }
}
