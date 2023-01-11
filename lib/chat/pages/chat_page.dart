import 'package:avrod/chat/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:avrod/chat/helper/rout_navigator.dart';
import 'package:avrod/chat/pages/group_info_page.dart';
import 'package:avrod/chat/widgets/text_style.dart';
import 'package:avrod/constant/colors/colors.dart';

//! 2:37
class ChatPage extends StatefulWidget {
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
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chats;
  String admnin = "";

  @override
  void initState() {
    super.initState();
    getChatAndAdmin();
  }

  getChatAndAdmin() {
    DtabaseService().getChats(widget.groupId).then((val) {
      setState(() {
        chats = val;
      });
    });

    DtabaseService().getGroupAdmin(widget.groupId).then((value) {
      setState(() {
        admnin = value;
      });
    });
  }

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
          title: widget.groupName,
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
                  groupId: widget.groupId,
                  groupName: widget.groupName,
                  adminName: admnin,
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
              title: widget.groupName,
              fontSize: 22,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.start,
            ),
          ),
          // CustomText(
          //   title: groupId,
          //   fontSize: 22,
          //   fontWeight: FontWeight.w400,
          //   textAlign: TextAlign.start,
          // ),
        ],
      ),
    );
  }
}
