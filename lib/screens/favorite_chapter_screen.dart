import 'package:avrod/controller/chaptercontroller.dart';
import 'package:avrod/models/chapter_model.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:like_button/like_button.dart';

import '../constant/colors/colors.dart';
import '../constant/colors/gradient_class.dart';
import '../main.dart';
import '../models/book.dart';

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
    final books = controller.bookFromFB!;
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
        body: Container(
          decoration: favoriteGradient,
          child: ValueListenableBuilder(
            valueListenable: Hive.box(FAVORITES_BOX).listenable(),
            builder: (context, Box box, child) {
              List<ChaptersModel> chapters = [];
              for (Book book in books) {
                chapters.addAll(book.chapters!);
              }
              final List<dynamic> likedChapterIds = box.keys.toList();

              final likedChapters = chapters
                  .where((ChaptersModel chapter) =>
                      likedChapterIds.contains(chapter.id))
                  .toList();
              return AnimationLimiter(
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.blueGrey[800],
                      );
                    },
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(top: 10.0),
                    physics: const BouncingScrollPhysics(),
                    itemCount: likedChapters.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        columnCount: likedChapters.length,
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
                                           chapterID: likedChapters[index].id! +1,
                                          texts: likedChapters[index].texts,
                                          titleAbbar: likedChapters[index].name,
                                        );
                                      },
                                    ),
                                  );
                                },
                                trailing: const CircleAvatar(
                                  backgroundColor: bgColor,
                                  child: LikeButton(
                                    // isLiked: controller.isChapterLiked(chapterID![index].id!),
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
                                title: Row(
                                  children: [
                                    SizedBox(
                                      height: 65,
                                      width: 65,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                        
                                            right: 0,
                                            bottom: 0,

                                          
                                            child: Text(
                                                "${likedChapters[index].id! +1}",
                                                maxLines: 3,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    overflow: TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    color: listTitleColor),
                                              ),
                                          ),
                                          CachedNetworkImage(
                                            imageUrl:
                                                likedChapters[index].listimage ?? '',
                                            placeholder: (context, imageProvider) {
                                              return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(90),
                                                  child: Image.asset(
                                                    'assets/icons/iconavrod.png',
                                                    height: 50,
                                                  ));
                                            },
                                            imageBuilder: (context, imageProvider) {
                                              return CircleAvatar(
                                                radius: 25,
                                                backgroundImage: imageProvider,
                                              );
                                            },
                                            errorWidget: (context, url, error) {
                                              return const CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: AssetImage(
                                                      'assets/images/noimage.png'));
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 14,
                                    ),
                                     Expanded(
                                       child: Text(
                                            likedChapters[index].name ?? "null",
                                            maxLines: 3,
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
                              )),
                        ),
                      );
                    }),
              );
            },
          ),
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
