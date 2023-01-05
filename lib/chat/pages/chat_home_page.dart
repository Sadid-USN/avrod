import 'package:avrod/chat/helper/text_style.dart';
import 'package:avrod/chat/widgets/chat_drawer.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatHomePage extends GetView<HomePageController> {
  const ChatHomePage({Key? key}) : super(key: key);

  static String routName = '/chatHomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ChatDrawer(
        userEmail: controller.emailLogin,
        userName: controller.fullName,
        column: Column(children: [
          ListTile(
            onTap: () {},
            title: const CustomText(
              title: 'Гурӯҳҳо',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
            ),
            leading: const Icon(
              Icons.group,
              color: audiplayerColor,
            ),
          ),
          ListTile(
            onTap: () {
              controller.goToProfilePage();
            },
            title: const CustomText(
              title: 'Ҳисоб',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
            ),
            leading: const Icon(
              Icons.account_circle_outlined,
              color: audiplayerColor,
            ),
          ),
          ListTile(
            onTap: () {
              controller.getdefaultDialog(
                  'Таъкидан мехоҳед аз ҳисоб худ берун шавед?', () {
                controller.signOut().whenComplete(() {
                  controller.goToLogin();
                });
              });
            },
            title: const CustomText(
              title: 'Берун',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.start,
            ),
            leading: const Icon(
              Icons.exit_to_app,
              color: audiplayerColor,
            ),
          ),
        ]),
      ),
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
          title: 'Чат',
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Opacity(
              opacity: 0.5,
              child: SizedBox(
                height: 200,
                child: Image.asset(
                  'assets/icons/chat.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // LoginButton(
          //   buttonTitle: 'Баромад',
          //   onPressed: () async {},
          // )
        ],
      ),
    );
  }
}
