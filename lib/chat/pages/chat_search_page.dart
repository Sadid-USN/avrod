import 'package:avrod/chat/helper/rout_navigator.dart';
import 'package:avrod/chat/pages/chat_page.dart';
import 'package:avrod/chat/widgets/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:avrod/chat/helper/helper_function.dart';
import 'package:avrod/chat/services/database_service.dart';
import 'package:avrod/chat/widgets/text_style.dart';
import 'package:avrod/constant/colors/colors.dart';

class ChatSearchPage extends StatefulWidget {
  const ChatSearchPage({Key? key}) : super(key: key);
  static String routName = '/chatSearchPage';

  @override
  State<ChatSearchPage> createState() => _ChatSearchPageState();
}

class _ChatSearchPageState extends State<ChatSearchPage> {
  TextEditingController searchController = TextEditingController();
  QuerySnapshot? searchSnapshot;
  bool hasUserSearch = false;
  bool isLoading = false;
  bool isJoin = false;
  User? user;
  String userName = "";

  @override
  void initState() {
    super.initState();
    getCurrentUserIdAndName();
  }

  getCurrentUserIdAndName() async {
    await HelperFunction.getUserNameFromSF().then((value) {
      setState(() {
        userName = value!;
      });
    });

    user = FirebaseAuth.instance.currentUser;
  }

  String getGroupId(String id) {
    return id.split('_').first;
  }

  String getAdmin(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBabgColor,
        elevation: 0.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        title: const CustomText(
          maxLines: 1,
          title: 'Ҷустуҷӯ',
          fontSize: 22,
          fontWeight: FontWeight.w600,
          textAlign: TextAlign.start,
        ),
        centerTitle: true,
        actions: const [],
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: [
          Container(
            color: appBabgColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Ҷустуҷӯи гурӯҳ...',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: skipColor.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    initSearchMethod();
                  },
                  child: CircleAvatar(
                    backgroundColor: audiplayerColor.withOpacity(0.2),
                    radius: 20,
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(
                      color: audiplayerColor.withOpacity(0.9)))
              : groupList(),
        ],
      ),
    );
  }

  initSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DtabaseService()
          .searchGroupByName(searchController.text)
          .then((snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          isLoading = false;
          hasUserSearch = true;
        });
      });
    }
  }

  Widget groupList() {
    return hasUserSearch != true
        ? const SizedBox()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              return groupTile(
                userName,
                searchSnapshot!.docs[index]['groupId'],
                searchSnapshot!.docs[index]['groupName'],
                searchSnapshot!.docs[index]['admin'],
              );
            });
  }

  joinOerNot(
      String userName, String groupId, String groupName, String admin) async {
    await DtabaseService(uid: user!.uid)
        .isUserJoined(groupName, groupId, userName)
        .then((value) {
      setState(() {
        isJoin = value;
      });
    });
  }

  Widget groupTile(
      String userName, String groupId, String groupName, String admin) {
    // function to check user alredy exists in group
    joinOerNot(userName, groupId, groupName, admin);
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: audiplayerColor.withOpacity(0.7),
        child: Text(
          groupName.substring(0, 1).toUpperCase(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        "Гурӯҳи: $groupName",
        style: const TextStyle(
          color: skipColor,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'Корфармон: ${getAdmin(admin)}',
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: InkWell(
        onTap: () async {
          await DtabaseService(uid: user!.uid)
              .toggleGroupJoin(groupName, groupId, userName);

          if (isJoin) {
            setState(() {
              isJoin = !isJoin;
            });
            if (!mounted) return;
            snackBar(context, Colors.green.shade400,
                'Шумо ба гурӯҳи $groupName пайваст шудед!');
            Future.delayed(const Duration(seconds: 2));
            nextScreen(
                context,
                ChatPage(
                    groupId: groupId,
                    groupName: groupName,
                    userName: userName));
          } else {
            if (!mounted) return;
            snackBar(context, Colors.red.shade500,
                'Шумо аз гурӯҳи $groupName хориҷ шудед!');
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

// class GroupList extends StatelessWidget {
//   final String groupId;
//   final String groupName;
//   final String admin;
//   const GroupList({
//     Key? key,
//     required this.groupId,
//     required this.groupName,
//     required this.admin,
//   }) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         shrinkWrap: true,
//         itemCount: 5, //searchSnapshot!.docs.length,
//         itemBuilder: (context, index) {
//           return Column(
//             children: const [
//               Text(''),
//               Text(''),
//               Text(''),
//             ],
//           );
//         });
//   }
// }
