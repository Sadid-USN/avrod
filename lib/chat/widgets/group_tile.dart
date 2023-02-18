import 'package:avrod/chat/helper/rout_navigator.dart';
import 'package:avrod/chat/pages/chat_page.dart';
import 'package:avrod/chat/services/database_service.dart';
import 'package:avrod/chat/widgets/snackbar.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//! 3:31
class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  final String subtitle;
  final double margin;
  final void Function()? onTap;
  const GroupTile({
    Key? key,
    required this.userName,
    required this.groupId,
    required this.groupName,
    required this.onTap,
    this.margin = 0.0,
    this.subtitle = '',
  }) : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  QuerySnapshot? searchSnapshot;
  bool hasUserSearch = false;
  bool isLoading = false;
  bool isJoin = false;
  User? user;

  String getGroupId(String id) {
    return id.split('_').first;
  }

  String getAdmin(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        margin: EdgeInsets.all(widget.margin > 0 ? widget.margin : 0),
        alignment: Alignment.center,
        height: 100,
        decoration: BoxDecoration(
            color: widget.margin > 0
                ? audiplayerColor.withOpacity(0.2)
                : audiplayerColor.withOpacity(0.0),
            borderRadius: BorderRadius.circular(28.0)),
        child: ListTile(
          onTap: widget.onTap,
          leading: CircleAvatar(
            backgroundColor: audiplayerColor.withOpacity(0.8),
            radius: 30,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
          title: Text(
            widget.groupName,
            style: const TextStyle(
                color: Colors.black45, fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            widget.margin > 0
                ? "${widget.subtitle} ${widget.userName}"
                : 'Чат дар гурӯҳи ${widget.userName}',
            textAlign: TextAlign.start,
            style: widget.margin > 0
                ? const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  )
                : const TextStyle(
                    color: Colors.black45,
                  ),
          ),
        ),
      ),
    );
  }

  joinOerNot(
    String userName,
    String groupId,
    String groupName,
  ) async {
    await DtabaseService(uid: user!.uid)
        .isUserJoined(groupName, groupId, userName)
        .then((value) {
      setState(() {
        isJoin = value;
      });
    });
  }

  Widget groupTile() {
    // function to check user alredy exists in group

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: audiplayerColor.withOpacity(0.7),
        child: Text(
          widget.groupName.substring(0, 1).toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        "Гурӯҳи: ${widget.groupName}",
        style: const TextStyle(
          color: skipColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      // subtitle: Text(
      //   'Корфармон: ${getAdmin(admin)}',
      //   style: const TextStyle(
      //     fontSize: 12,
      //     fontWeight: FontWeight.w600,
      //   ),
      // ),
      trailing: InkWell(
        onTap: () async {
          await DtabaseService(uid: user!.uid).toggleGroupJoin(
              widget.groupName, widget.groupId, widget.userName);

          if (isJoin) {
            setState(() {
              isJoin = !isJoin;
            });
            if (!mounted) return;
            snackBar(context, Colors.green.shade400,
                'Шумо ба гурӯҳи ${widget.groupName} пайваст шудед!');
            Future.delayed(const Duration(seconds: 2));
            nextScreen(
                context,
                ChatPage(
                    groupId: widget.groupId,
                    groupName: widget.groupName,
                    userName: widget.userName));
          } else {
            if (!mounted) return;
            snackBar(context, Colors.red.shade500,
                'Шумо аз гурӯҳи ${widget.groupName} хориҷ шудед!');
          }
        },
        child: isJoin
            ? Container(
                alignment: Alignment.center,
                width: 105,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green.shade400,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: const Text(
                  "Пайваст шудед!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : Container(
                alignment: Alignment.center,
                width: 105,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.8),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: const Text(
                  "Пайвастан",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
      ),
    );
  }
}
