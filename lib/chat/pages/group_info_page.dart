import 'package:avrod/chat/helper/rout_navigator.dart';
import 'package:avrod/chat/pages/groups_home_page.dart';
import 'package:avrod/chat/services/database_service.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Stream? members;
  @override
  void initState() {
    getMembers();
    super.initState();
  }

  String getGroupId(String id) {
    return id.split('_').first;
  }

  String getAdmin(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  getMembers() async {
    DtabaseService().groupMembers(widget.groupId).then((value) {
      setState(() {
        members = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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
        actions: [
          IconButton(
            onPressed: () async {
              controller.exitDialog(
                'Таъкидан мехоҳед аз гурӯҳи «${widget.groupName}» бароед?',
                () {
                  DtabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                      .toggleGroupJoin(
                    widget.groupName,
                    widget.groupId,
                    getAdmin(widget.adminName),
                  )
                      .whenComplete(() {
                    nextScreen(context, const GroupsHomePage());
                  });
                },
              );
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: skipColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 100,
              decoration: BoxDecoration(
                  color: audiplayerColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(28.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: audiplayerColor.withOpacity(0.8),
                        radius: 30,
                        child: Text(
                          widget.groupName.substring(0, 1).toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Гурӯҳи:  ${widget.groupName}",
                            style: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Корфармон:  ${getAdmin(widget.adminName)}",
                            style: const TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Spacer(
                        flex: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Text(
            'Иштирокчиёни гурӯҳ',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          memberList(),
        ],
      ),
    );
  }

  memberList() {
    return StreamBuilder(
        stream: members,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['members'] != null) {
              if (snapshot.data['members'].length != 0) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data['members'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 16.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: skipColor.withOpacity(0.5),
                            radius: 30,
                            child: Text(
                              getAdmin(snapshot.data['members'][index])
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            getAdmin(snapshot.data['members'][index])
                                .split("_")
                                .last,
                            style: const TextStyle(
                              color: skipColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle:
                              Text(getGroupId(snapshot.data['members'][index])),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text('Айни ҳол ҳеҷ иштирокчи вуҷуд надорад'),
                );
              }
            } else {
              return const Center(
                child: Text('Айни ҳол ҳеҷ иштирокчи вуҷуд надорад'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
