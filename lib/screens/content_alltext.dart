import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/text_screen_controller.dart';
import 'package:avrod/style/my_text_style.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContetAllTexts extends StatelessWidget {
  final String text, arabic, translation;
  final List<dynamic>? texts;
  final String? titleAbbar;

  const ContetAllTexts(
      {Key? key,
      required this.text,
      required this.translation,
      required this.arabic,
      this.texts,
      this.titleAbbar})
      : super(key: key);

  // double _fontSize = 16.0;
  // int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TextScreenController controller = Get.put(TextScreenController());
    return GetBuilder<TextScreenController>(
      // dispose: (state) => Get.delete<TextScreenController>(),
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
                SizedBox(
                  width: 200,
                  child: Slider(
                    activeColor: Colors.white,
                    inactiveColor: Colors.blueGrey,
                    value: controller.fontSize,
                    label: controller.fontSize.round().toString(),
                    onChanged: (newSize) {
                      controller.onChangedSliderSize(newSize);
                    },
                    max: 25.0,
                    min: 16.0,
                  ),
                ),
                ExpandablePanel(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.only(right: 30, left: 30, bottom: 20),
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ],
                    gradient: LinearGradient(
                        colors: [bgColor, bgColor],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: ExpandablePanel(
                    header: const Text(''),
                    collapsed: Center(
                      child: SelectableText(
                        arabic,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.amiri(
                          textBaseline: TextBaseline.ideographic,
                          wordSpacing: 0.6,
                          color: listTitleColor,
                          fontSize: controller.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    expanded: SelectableText(
                      arabic,
                      maxLines: 1,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.amaticSc(
                        textBaseline: TextBaseline.ideographic,
                        wordSpacing: 0.5,
                        color: Colors.blueGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        textStyle: const TextStyle(
                            letterSpacing: 0.3,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
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
                    )),
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
