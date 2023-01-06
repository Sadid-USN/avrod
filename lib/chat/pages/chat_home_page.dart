import 'package:avrod/chat/helper/text_style.dart';
import 'package:avrod/chat/widgets/chat_drawer.dart';
import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//! 2:20
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
      body: StreamBuilder(
        stream: controller.groups,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != 0) {
              if (snapshot.data['groups'].length != 0) {
                return const Center(
                    child: CustomText(
                  title: 'Хуш омадед!',
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                ));
              } else {
                return NoGroups(
                  onTap: () {},
                );
              }
            } else {
              return NoGroups(
                onTap: () {},
              );
            }
            // return Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Center(
            //       child: Opacity(
            //         opacity: 0.5,
            //         child: SizedBox(
            //           height: 200,
            //           child: Image.asset(
            //             'assets/icons/chat.png',
            //             fit: BoxFit.cover,
            //           ),
            //         ),
            //       ),
            //     ),

            //     // LoginButton(
            //     //   buttonTitle: 'Баромад',
            //     //   onPressed: () async {},
            //     // )
            //   ],
            // );
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
              () {},
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
              GestureDetector(
                onTap: onTap,
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
              const Positioned(
                right: 0,
                left: 0,
                top: 60,
                child: Center(
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Colors.blueGrey,
                    size: 75,
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
