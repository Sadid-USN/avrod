import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:avrod/chat/helper/rout_navigator.dart';
import 'package:avrod/chat/pages/group_info_page.dart';
import 'package:avrod/chat/widgets/text_style.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/homepage_controller.dart';

//! 2:37
class ChatPage extends GetView<HomePageController> {
  final String groupId;
  final String groupName;
  final String userName;
  static String routName = '/chatPage';
  const ChatPage({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.userName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: appBabgColor,
        elevation: 3.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        title: CustomText(
          maxLines: 1,
          title: controller.groupName,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              nextScreen(
                context,
                GroupInfoPage(
                  groupId: groupId,
                  groupName: groupName,
                  adminName: userName,
                ),
              );
            },
            icon: const Icon(
              Icons.info_outline,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: CustomText(
              title: groupName,
              fontSize: 22,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start,
            ),
          ),
          CustomText(
            title: groupId,
            fontSize: 22,
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
