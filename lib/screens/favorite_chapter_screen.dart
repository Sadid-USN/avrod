import 'package:avrod/colors/colors.dart';
import 'package:avrod/colors/gradient_class.dart';
import 'package:avrod/main.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:progress_indicators/progress_indicators.dart';

class FavoriteChaptersSceen extends StatefulWidget {
  const FavoriteChaptersSceen({
    Key? key,
  }) : super(
          key: key,
        );
  //final Chapter? chapter;

  @override
  State<FavoriteChaptersSceen> createState() => _FavoriteChaptersSceenState();
}

class _FavoriteChaptersSceenState extends State<FavoriteChaptersSceen> {
  Box? likesBox;
  Future<void> setLike(String chapterID, bool isLiked, Map content) async {
    // if (!isLiked) {
    //   await likesBox!.put(chapterID, content);
    // } else {
    setState(() {});
    await likesBox!.delete(chapterID);
    // }

    // return !isLiked;
  }

  bool isChapterLiked(String chapterID) {
    bool isLiked = likesBox!.containsKey(chapterID);
    return isLiked;
  }

  @override
  void initState() {
    likesBox = Hive.box(FAVORITES_BOX);
    super.initState();
  }

  // void initHive() async {

  //   likesBox = await Hive.openBox(FAVORITES_BOX);
  // }

  @override
  Widget build(BuildContext context) {
    // final books = Provider.of<List<Book>>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: favoriteGradient,
          ),
          centerTitle: true,
          title: Text(
            'Фаслҳои маҳбуб',
            style: TextStyle(fontSize: 18, color: calendarAppbar),
          ),
        ),
        // ignore: avoid_unnecessary_containers
        body: likesBox!.isEmpty
            ? Container(
                decoration: favoriteGradient,
                child: Center(
                  child: GlowingProgressIndicator(
                    duration: const Duration(seconds: 1),
                    child: const Text(
                      '❤️',
                      style: TextStyle(fontSize: 60),
                    ),
                  ),
                ),
              )
            : Container(
                decoration: favoriteGradient,
                child: AnimationLimiter(
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Colors.blueGrey[800],
                        );
                      },
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(top: 5),
                      physics: const BouncingScrollPhysics(),
                      itemCount: likesBox!.values.length,
                      itemBuilder: (context, index) {
                        //  final Chapter chapter = book.chapters[index];

                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 500),
                          columnCount: likesBox!.values.length,
                          // bookFromFB![widget.indexChapter]
                          //         ['chapters'][index]['listimage']
                          //     .length,
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
                                            texts: likesBox!.values
                                                .toList()[index]['texts'],
                                            titleAbbar: likesBox!.values
                                                .toList()[index]['name'],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  trailing: CircleAvatar(
                                    backgroundColor: bgColor,
                                    child: LikeButton(
                                      isLiked: isChapterLiked(
                                          likesBox!.keys.toList()[index]),
                                      onTap: (isLiked) async {
                                        setLike(
                                            likesBox!.keys.toList()[index],

                                            // bookFromFB![widget.indexChapter]
                                            //         ['chapters'][index]['id'] ??
                                            //     0,
                                            isLiked,
                                            likesBox!.values.toList()[index]);
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
                                  leading: CachedNetworkImage(
                                      imageUrl: likesBox!.values.toList()[index]
                                          ['listimage'],
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
                                  title: Text(
                                    "${likesBox!.values.toList()[index]['name']}",
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
              ));
  }
}
