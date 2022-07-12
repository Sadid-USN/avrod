import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class MyanimetedText extends StatelessWidget {
  const MyanimetedText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      totalRepeatCount: 2,
      animatedTexts: [
        ColorizeAnimatedText(
          'avrod'.tr,
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
        ),
      ],
    );
  }
}

final colorizeColors = [
  Colors.blueGrey[800]!,
  Colors.white,
  Colors.orange,
  Colors.blue,
  Colors.indigo,
  Colors.deepOrange,
];

const colorizeTextStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w900);
