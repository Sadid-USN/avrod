import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/text_screen_controller.dart';
import 'package:avrod/style/my_text_style.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PronunciationText extends StatelessWidget {
  final String text;
  const PronunciationText({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextScreenController controller = Get.put(TextScreenController());
    return ExpandablePanel(
      header: Text(
        "Талаффуз:",
        textAlign: TextAlign.start,
        style: expandableTextStyle,
      ),
      collapsed: SelectableText(
        text,
        style: TextStyle(
          letterSpacing: 1.2,
          fontWeight: FontWeight.w600,
          fontSize: controller.fontSize,
          color: listTitleColor,
        ),
      ),
      expanded: SelectableText(
        text,
        maxLines: 2,
        style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Colors.blueGrey,
            overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
