import 'package:avrod/chat/helper/helper_function.dart';
import 'package:avrod/chat/services/database_service.dart';
import 'package:avrod/chat/widgets/text_style.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//! 3:11
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
  String userName = "";
  User? user;

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

  Widget groupTile(
    String userName,
    String groupId,
    String groupName,
    String admin,
  ) {
    return const Text('Assalamualaykum');
  }
}
