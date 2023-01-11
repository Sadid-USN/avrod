import 'package:avrod/chat/services/database_service.dart';
import 'package:avrod/chat/widgets/group_tile.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:avrod/chat/widgets/text_style.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:get/get.dart';

class GroupInfoPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String adminName;
  static String routName = '/groupInfoPage';

  const GroupInfoPage({
    Key? key,
    required this.groupId,
    required this.groupName,
    required this.adminName,
  }) : super(key: key);

  @override
  State<GroupInfoPage> createState() => _GroupInfoPageState();
}

class _GroupInfoPageState extends State<GroupInfoPage> {
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
    HomePageController controller = Get.put(HomePageController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBabgColor,
        elevation: 3.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        title: const CustomText(
          maxLines: 1,
          title: 'Маълумоти гурӯҳ',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: GroupTile(
        margin: 8,
        onTap: () {},
        userName: 'Корфармон:  ${widget.adminName}',
        groupId: 'ss',
        groupName: widget.groupName,
      ),
    );
  }
}
