import 'package:avrod/chat/services/database_service.dart';
import 'package:avrod/chat/widgets/message_tile.dart';
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
  TextEditingController messageController = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    getChatAndAdmin();
  }

  void scrollDown() {
    if (chats != null) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(microseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
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
              color: skipColor,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // chat messages here
          chatMessages(),
          Container(
            alignment: Alignment.bottomCenter,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              color: Colors.grey[700],
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Чат...',
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendMwssage();
                    },
                    child: SizedBox(
                      height: 45,
                      width: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: ColoredBox(
                          color: audiplayerColor.withOpacity(0.7),
                          child: const Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  chatMessages() {
    return StreamBuilder(
        stream: chats,
        builder: (context, AsyncSnapshot snapshot) {
          if (chats != null && scrollController.hasClients) {
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              duration: const Duration(microseconds: 100),
              curve: Curves.easeOut,
            );
          }
          return snapshot.hasData
              ? ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.only(bottom: 116.0),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      message: snapshot.data.docs[index]['message'],
                      sender: snapshot.data.docs[index]['sender'],
                      sendByMe: widget.userName ==
                          snapshot.data.docs[index]['sender'],
                    );
                  })
              : const SizedBox();
        });
  }

  sendMwssage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessage = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DtabaseService().sendMessage(widget.groupId, chatMessage);

      setState(() {
        messageController.clear();
      });
    }
  }
}
