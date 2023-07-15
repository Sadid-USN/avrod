import 'package:avrod/constant/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class MyanimetedText extends StatelessWidget {
  final String title;
  final double fontSize;
  const MyanimetedText({Key? key, required this.title, this.fontSize = 16})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title.tr,
      style: const TextStyle(color: skipColor),
    )
        .animate()
        .fadeIn() // uses `Animate.defaultDuration`
        .scale()
        .move(delay: 1000.ms, duration: 1000.ms)
        .scaleXY();
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
