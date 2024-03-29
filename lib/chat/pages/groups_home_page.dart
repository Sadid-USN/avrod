import 'package:avrod/chat/helper/rout_navigator.dart';
import 'package:avrod/chat/pages/chat_page.dart';
import 'package:avrod/chat/widgets/group_tile.dart';
import 'package:avrod/chat/widgets/text_style.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class GroupsHomePage extends StatelessWidget {
  const GroupsHomePage({Key? key}) : super(key: key);

  static String routName = '/chatHomePage';
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomePageController());
    return Scaffold(
      
   
    
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
           controller
                  .exitDialog('Таъкидан мехоҳед аз ҳисоб худ берун шавед?', () {
                controller.signOut();
                controller.goToHomePage();
              });

        }, icon: const Icon(Icons.exit_to_app_outlined)),
        iconTheme: const IconThemeData(color: Colors.blueGrey),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        elevation: 0.0,
        backgroundColor: bgColor,
        title: const CustomText(
          title: 'Гурӯҳҳо',
          fontSize: 22,
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
      body: StreamBuilder<dynamic>(
        stream: controller.groups?.handleError((error) {
          print('Error occurred: $error');
          // show an error message to the user
          return Text('An error occurred: $error');
        }),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != 0) {
              if (snapshot.data['groups'].length != 0) {
                return  ListView.builder(
                    itemCount: snapshot.data['groups'].length,
                    itemBuilder: (context, index) {
                      int reverseIndex =
                          snapshot.data['groups'].length - index - 1;
                      return 
                      
                      GroupTile(
                        onTap: () {
                          nextScreen(
                            context,
                            ChatPage(
                              groupId: controller.getGroupId(
                                snapshot.data['groups'][reverseIndex],
                              ),
                              groupName: controller.getGroupName(
                                snapshot.data['groups'][reverseIndex],
                              ),
                              userName: snapshot.data['fullName'],
                            ),
                          );
                        },
                        groupId: controller.getGroupId(
                          snapshot.data['groups'][reverseIndex],
                        ),
                        userName: snapshot.data['fullName'],
                        groupName: controller.getGroupName(
                          snapshot.data['groups'][reverseIndex],
                        ),
                      );
                    },
                  );
                
              } else {
                return NoGroups(
                  onTap: () {
                    controller.popUpDialog('Гурӯҳи нав');
                  },
                );
              }
            } else {
              return NoGroups(
                onTap: () {},
              );
            }
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: audiplayerColor,
            ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.popUpDialog(
              'Гурӯҳи нав',
            );
          },
          backgroundColor: audiplayerColor,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          )),
    );
  }
}

class NoGroups extends StatelessWidget {
  final Function()? onTap;
  const NoGroups({Key? key, required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Opacity(
                opacity: 0.5,
                child: SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/icons/chat.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                left: 0,
                top: 60,
                child: Center(
                  child: GestureDetector(
                    onTap: onTap,
                    child: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.blueGrey,
                      size: 75,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Айни ҳол шумо гурӯҳ надоред, барои изофа кардани гурӯҳ тугмаро пахш кунед ё аз боло ягон гурӯҳеро ҷустуҷӯ намоед',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
