import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/text_screen_controller.dart';
import 'package:avrod/style/my_text_style.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TranslationText extends StatelessWidget {
  final String translation;
  const TranslationText({Key? key, required this.translation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextScreenController controller = Get.put(TextScreenController());
    return Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: ExpandablePanel(
            header: Text(
              "Тарҷума:",
              textAlign: TextAlign.start,
              style: expandableTextStyle,
            ),
            collapsed: SelectableText(
              translation,
              style: TextStyle(
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
                fontSize: controller.fontSize,
                color: listTitleColor,
              ),
            ),
            expanded: SelectableText(
              translation,
              maxLines: 2,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Colors.blueGrey,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ));
  }
}
