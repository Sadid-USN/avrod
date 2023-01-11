import 'package:avrod/chat/widgets/text_style.dart';
import 'package:avrod/constant/animated_text.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends GetView<HomePageController> {
  const ProfilePage({
    Key? key,
  }) : super(key: key);
  static String routName = '/profilePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        elevation: 3.0,
        backgroundColor: appBabgColor,
        title: const CustomText(
          title: 'Ҳисоб',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.goToChatSearcPage();
            },
            icon: const Icon(
              Icons.search,
              color: skipColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Image.asset(
                'assets/icons/profile.png',
                height: 150,
              ),
            ),
            MyanimetedText(
              title: controller.fullName.toUpperCase(),
              fontSize: 40,
            ),
            Text(
              controller.emailLogin,
              style: const TextStyle(color: Colors.black54, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
