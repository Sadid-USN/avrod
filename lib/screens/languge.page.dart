import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/localization/local_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LangugesPage extends GetView<LocalController> {
  const LangugesPage({Key? key}) : super(key: key);

  static String routName = '/langugesPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: bgColor,
        title: Text(
          'lang'.tr,
          style: const TextStyle(color: skipColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ListTile(
              title: const Text(
                '🇺🇸  English',
              ),
              onTap: () {
              
                controller.onLanguageTapped('en', 'US');
              }),
          ListTile(
              title: Text(
                '🇹🇯  Тоҷики',
                style: GoogleFonts.ptSerif(),
              ),
              onTap: () {
              
                controller.onLanguageTapped('ru', "RU");
              }),
        ],
      ),
    );
  }
}
