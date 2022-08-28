import 'package:avrod/controller/text_screen_controller.dart';
import 'package:avrod/utility/texts/arabic_text.dart';
import 'package:avrod/utility/font_magnifier_button.dart';
import 'package:avrod/utility/texts/pronunciation_text.dart';
import 'package:avrod/utility/texts/translation_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContetAllTexts extends StatelessWidget {
  final String text, arabic, translation;
  final List<dynamic>? texts;
  final String? titleAbbar;

  const ContetAllTexts({
    Key? key,
    required this.text,
    required this.translation,
    required this.arabic,
    this.texts,
    this.titleAbbar,
  }) : super(key: key);

  // double _fontSize = 16.0;
  // int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextScreenController>(
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
                const FontMagnifiereButton(),

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
                const SizedBox(
                  height: 90,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
