import 'package:avrod/constant/colors/colors.dart';
import 'package:avrod/controller/chaptercontroller.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:avrod/widgets/path_of_images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ChapterScreen extends StatelessWidget {
  final int indexChapter;
  const ChapterScreen({
    Key? key,
    required this.indexChapter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChapterController controller = Get.put(ChapterController());

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.goToHomePage();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        elevation: 0.0,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            images[indexChapter].name.tr,
            style: TextStyle(fontSize: 16.0, color: listTitleColor),
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          color: bgColor,
        ),
      ),
      body: GetBuilder<ChapterController>(
        builder: (controller) => AnimationLimiter(
          child: ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.blueGrey[800],
                );
              },
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(top: 5),
              physics: const BouncingScrollPhysics(),
              itemCount: controller.bookFromFB == null
                  ? 0
                  : controller.bookFromFB![indexChapter]['chapters'].length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredGrid(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  columnCount: controller
                      .bookFromFB![indexChapter]['chapters'][index]['listimage']
                      .length,
                  child: ScaleAnimation(
                    child: Container(
                      color: bgColor,
                      padding: const EdgeInsets.all(5.0),
                      child: ListTile(
                        //  key: ValueKey(index),
                        onTap: () {
                          Get.to(TextScreen(
                            textsIndex: index,
                            texts: controller.bookFromFB![indexChapter]
                                ['chapters'][index]['texts'],
                            titleAbbar: controller.bookFromFB![indexChapter]
                                ['chapters'][index]['name'],
                          ));
                        },
                        trailing: CircleAvatar(
                          backgroundColor: bgColor,
                          child: LikeButton(
                            isLiked: controller.isChapterLiked(
                                controller.bookFromFB![indexChapter]['chapters']
                                    [index]['id']),
                            onTap: (isLiked) async {
                              return controller.setLike(
                                  "$indexChapter $index",
                                  isLiked,
                                  controller.bookFromFB![indexChapter]
                                      ['chapters'][index]);
                            },
                            size: 25,
                            circleColor: const CircleColor(
                                start: Color(0xffFF0000),
                                end: Color.fromARGB(255, 220, 46, 46)),
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
                                  imageUrl: controller.bookFromFB![indexChapter]
                                      ['chapters'][index]['listimage'],
                                  placeholder: (context, imageProvider) {
                                    return JumpingText(
                                      '❤️❤️❤️',
                                      end: const Offset(0.0, -0.5),
                                      style: const TextStyle(
                                          fontSize: 8, color: Colors.white),
                                    );
                                  },
                                  imageBuilder: (context, imageProvider) {
                                    return CircleAvatar(
                                      radius: 25,
                                      backgroundImage: imageProvider,
                                    );
                                  }),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Text(
                                  "${controller.bookFromFB![indexChapter]['chapters'][index]['id'] + 1}",
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
                          "${controller.bookFromFB![indexChapter]['chapters'][index]['name']}",
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 0.7,
                              fontSize: 12,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                              color: listTitleColor),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  // Future<bool> setLike(String chapterID, bool isLiked, Map content) async {
  //   if (!isLiked) {
  //     await likesBox!.put(chapterID, content);
  //   } else {
  //     await likesBox!.delete(chapterID);
  //   }

  //   return !isLiked;
  // }

  // bool isChapterLiked(int chapterID) {
  //   bool isLiked = likesBox!.containsKey(chapterID);
  //   return isLiked;
  // }
}

  // Widget buildBook(Book book) {
  //   return AnimationLimiter(
  //     child: GridView.builder(
  //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //           childAspectRatio: 1 / 0.2.h,
  //           crossAxisSpacing: 3,
  //           mainAxisSpacing: 3,
  //           crossAxisCount: 2,
  //         ),
  //         scrollDirection: Axis.vertical,
  //         padding: const EdgeInsets.only(top: 5),
  //         physics: const BouncingScrollPhysics(),
  //         itemCount: book.chapters?.length ?? 0,
  //         itemBuilder: (context, index) {
  //           final Chapter chapter = book.chapters[index];

  //           return AnimationConfiguration.staggeredGrid(
  //             position: index,
  //             duration: const Duration(milliseconds: 500),
  //             columnCount: chapter.listimage.length,
  //             child: ScaleAnimation(
  //               child: Padding(
  //                 padding: const EdgeInsets.all(5.0),
  //                 child: InkWell(
  //                   onTap: () {
  //                     Navigator.push(context,
  //                         MaterialPageRoute(builder: (context) {
  //                       return TextScreen(
  //                         texts: chapter.texts,
  //                         chapter: chapter,
  //                       );
  //                     }));
  //                   },
  //                   child: CachedNetworkImage(
  //                       imageUrl: chapter.listimage ?? '',
  //                       placeholder: (context, imageProvider) {
  //                         return Center(
  //                           child: JumpingText(
  //                             '...',
  //                             end: const Offset(0.0, -0.5),
  //                             style: const TextStyle(
  //                                 fontSize: 40, color: Colors.white),
  //                           ),
  //                         );
  //                       },
  //                       imageBuilder: (context, imageProvider) {
  //                         return Container(
  //                           decoration: BoxDecoration(
  //                               image: DecorationImage(
  //                                 image: imageProvider,
  //                                 fit: BoxFit.cover,
  //                                 colorFilter: const ColorFilter.mode(
  //                                   Colors.black26,
  //                                   BlendMode.srcOver,
  //                                 ),
  //                               ),
  //                               boxShadow: const [
  //                                 BoxShadow(
  //                                     color: Colors.black38,
  //                                     offset: Offset(0.0, 2.0),
  //                                     blurRadius: 6.0)
  //                               ],
  //                               gradient: const LinearGradient(
  //                                   colors: [
  //                                     Colors.white54,
  //                                     secondaryTextColor
  //                                   ],
  //                                   begin: Alignment.centerLeft,
  //                                   end: Alignment.centerRight),
  //                               borderRadius: const BorderRadius.all(
  //                                   Radius.circular(16.0))),
  //                           child: Stack(
  //                             children: [
  //                               ListTile(
  //                                 title: Center(
  //                                   child: Text(
  //                                     chapter.name,
  //                                     textAlign: TextAlign.center,
  //                                     style: TextStyle(
  //                                         fontSize: 17.sp,
  //                                         fontWeight: FontWeight.w600,
  //                                         color: titleTextColor),
  //                                   ),
  //                                 ),
  //                               ),
  //                               Positioned(
  //                                 top: 15,
  //                                 right: 10,
  //                                 child: LikeButton(
  //                                   isLiked: isChapterLiked(chapter.id),
  //                                   onTap: (isLiked) async {
  //                                     return setLike(chapter.id ?? 0, isLiked);
  //                                   },
  //                                   size: 30.sp,
  //                                   circleColor: const CircleColor(
  //                                       start: Color(0xffFF0000),
  //                                       end: Color(0xffFF0000)),
  //                                   bubblesColor: const BubblesColor(
  //                                     dotPrimaryColor: Color(0xffffffff),
  //                                     dotSecondaryColor: Color(0xffBF40BF),
  //                                   ),
  //                                 ),
  //                               )
  //                             ],
  //                           ),
  //                         );
  //                       }),
  //                 ),
  //               ),
  //             ),
  //           );
  //         }),
  //   );
  // }


