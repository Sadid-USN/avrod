import 'dart:convert';

import 'package:avrod/controller/chaptercontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'package:like_button/like_button.dart';

import '../constant/colors/colors.dart';
import '../constant/colors/gradient_class.dart';
import '../models/chapter_model.dart';

class FavoriteChaptersSceen extends StatelessWidget {
  const FavoriteChaptersSceen({
    Key? key,
  }) : super(
          key: key,
        );

  static String routName = '/favoriteChaptersSceen';

  @override
  Widget build(BuildContext context) {
    ChapterController controller = Get.put(ChapterController());

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 3.0,
          backgroundColor: appBabgColor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12))),
          leading: IconButton(
            onPressed: () {
              controller.goToHomePage();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Text(
            'favorite'.tr,
            style: TextStyle(fontSize: 18, color: calendarAppbar),
          ),
        ),
        // ignore: avoid_unnecessary_containers
        body: GetBuilder<ChapterController>(
          builder: (controller) {
            List keys = controller.likes.getKeys().toList();
            List<ChaptersModel> chaptersList = [];

            for (int i = 0; i < keys.length; i++) {
              try {
                Map<String, dynamic> data = json.decode(keys[i]);
                ChaptersModel chapter = ChaptersModel.fromJson(data);
                chaptersList.add(chapter);
              } catch (e) {
                print('Error decoding chapter data: $e');
              }
            }

            return Container(
              decoration: favoriteGradient,
              child: AnimationLimiter(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.blueGrey[800],
                      );
                    },
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(top: 10.0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: chaptersList.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        columnCount: controller.likes.getKeys().length,
                        child: ScaleAnimation(
                          child: Container(
                              color: bgColor,
                              padding: const EdgeInsets.all(5.0),
                              child: ListTile(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) {
                                  //       return TextScreen(
                                  //         textsIndex: index,
                                  //         texts: controller.likesBox!.values
                                  //             .toList()[index],
                                  //         titleAbbar: controller
                                  //             .likesBox!.values
                                  //             .toList()
                                  //             .toString(),
                                  //       );
                                  //     },
                                  //   ),
                                  // );
                                },
                                trailing: const CircleAvatar(
                                  backgroundColor: bgColor,
                                  child: LikeButton(
                                    size: 25,
                                    circleColor: CircleColor(
                                      start: Color(0xffFF0000),
                                      end: Color(0xffFF0000),
                                    ),
                                    bubblesColor: BubblesColor(
                                      dotPrimaryColor: Color(0xffffffff),
                                      dotSecondaryColor: Color(0xffBF40BF),
                                    ),
                                  ),
                                ),
                                leading: SizedBox(
                                  height: 70,
                                  width: 70,
                                  child: Stack(
                                    children: [
                                      // CachedNetworkImage(
                                      //     imageUrl: controller.likes
                                      //         .getValues()
                                      //         .toList()[index]['listimage'],
                                      //     placeholder: (context, imageProvider) {
                                      //       return JumpingText(
                                      //         '❤️❤️❤️',
                                      //         end: const Offset(0.0, -0.5),
                                      //         style: const TextStyle(
                                      //             fontSize: 8,
                                      //             color: Colors.white),
                                      //       );
                                      //     },
                                      //     imageBuilder: (context, imageProvider) {
                                      //       return CircleAvatar(
                                      //         radius: 25,
                                      //         backgroundImage: imageProvider,
                                      //       );
                                      //     }),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Text(
                                          chaptersList[index].id.toString(),
                                          maxLines: 2,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 12,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w600,
                                              color: listTitleColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                title: Text(
                                  chaptersList[index].name!,
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 12,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w600,
                                      color: listTitleColor),
                                ),
                              )),
                        ),
                      );
                    }),
              ),
            );
          },
        )
        // : Center(
        //     child: Lottie.asset(
        //       'assets/animations/heart.json',
        //       height: 200,
        //     ),
        //   ),
        );
  }
}
