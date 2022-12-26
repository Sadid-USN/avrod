import 'package:avrod/controller/favorite_controller.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../constant/colors/colors.dart';
import '../constant/colors/gradient_class.dart';

class FavoriteChaptersSceen extends StatelessWidget {
  const FavoriteChaptersSceen({
    Key? key,
  }) : super(
          key: key,
        );

  static String routName = '/favoriteChaptersSceen';

  @override
  Widget build(BuildContext context) {
    FavoriteScreenController controller = Get.put(FavoriteScreenController());
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
      body: controller.likesBox!.isEmpty
          ? Center(
              child: Lottie.asset('assets/animations/heart.json', height: 200),
            )
          : GetBuilder<FavoriteScreenController>(
              builder: (controller) => Container(
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
                      itemCount: controller.likesBox!.values.length,
                      itemBuilder: (context, index) {
                        //  final Chapter chapter = book.chapters[index];

                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          columnCount: controller.likesBox!.values.length,
                          child: ScaleAnimation(
                            child: Container(
                                color: bgColor,
                                padding: const EdgeInsets.all(5.0),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return TextScreen(
                                            textsIndex: index,
                                            texts: controller.likesBox!.values
                                                .toList()[index]['texts'],
                                            titleAbbar: controller
                                                .likesBox!.values
                                                .toList()[index]['name'],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  trailing: CircleAvatar(
                                    backgroundColor: bgColor,
                                    child: LikeButton(
                                      isLiked: controller.isChapterLiked(
                                          controller.likesBox!.keys
                                              .toList()[index]),
                                      onTap: (isLiked) async {
                                        controller.setLike(
                                            controller.likesBox!.keys
                                                .toList()[index],
                                            isLiked,
                                            controller.likesBox!.values
                                                .toList()[index]);
                                        return null;
                                      },
                                      size: 25,
                                      circleColor: const CircleColor(
                                          start: Color(0xffFF0000),
                                          end: Color(0xffFF0000)),
                                      bubblesColor: const BubblesColor(
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
                                        CachedNetworkImage(
                                            imageUrl: controller
                                                .likesBox!.values
                                                .toList()[index]['listimage'],
                                            placeholder:
                                                (context, imageProvider) {
                                              return JumpingText(
                                                '❤️❤️❤️',
                                                end: const Offset(0.0, -0.5),
                                                style: const TextStyle(
                                                    fontSize: 8,
                                                    color: Colors.white),
                                              );
                                            },
                                            imageBuilder:
                                                (context, imageProvider) {
                                              return CircleAvatar(
                                                radius: 25,
                                                backgroundImage: imageProvider,
                                              );
                                            }),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Text(
                                            "${controller.likesBox!.values.toList()[index]['id'] + 1}",
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
                                    "${controller.likesBox!.values.toList()[index]['name']}",
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
              ),
            ),
    );
  }
}
