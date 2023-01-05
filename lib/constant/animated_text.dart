import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class MyanimetedText extends StatelessWidget {
  final String title;
  final double fontSize;
  const MyanimetedText({Key? key, required this.title, this.fontSize = 16})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.bounceIn,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Padding(
            padding: EdgeInsets.only(top: value * 20, bottom: 16),
            child: child,
          ),
        );
      },
      child: AnimatedTextKit(
        totalRepeatCount: 3,
        animatedTexts: [
          ColorizeAnimatedText(
            title,
            textStyle:
                TextStyle(fontSize: fontSize, fontWeight: FontWeight.w900),
            colors: colorizeColors,
          ),
        ],
      ),
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
