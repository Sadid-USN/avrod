import 'package:avrod/constant/colors/colors.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;

  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  const CustomText({
    Key? key,
    required this.title,
    required this.fontSize,
    required this.fontWeight,
    this.textAlign = TextAlign.center,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: skipColor,
      ),
    );
  }
}
