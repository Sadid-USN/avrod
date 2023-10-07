import 'package:arabic_font/arabic_font.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/text_screen_controller.dart';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ArabicText extends StatelessWidget {
  final String arabic;
  const ArabicText({Key? key, required this.arabic}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextScreenController controller = Get.put(TextScreenController());
    return Container(
      padding: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black26, offset: Offset(0.0, 2.0), blurRadius: 6.0)
        ],
        gradient: LinearGradient(
            colors: [bgColor, bgColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            
            
            ),
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: ExpandablePanel(
        header: const Text(''),
        collapsed: Center(
          child: SelectableText(
            arabic,
            textAlign: TextAlign.justify,
            style: ArabicTextStyle(
               arabicFont: ArabicFont.scheherazade,
          
              wordSpacing: 0.6,
              color: listTitleColor,
              fontSize: 28,
              fontWeight: FontWeight.w500,
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
                letterSpacing: 0.3, overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}
