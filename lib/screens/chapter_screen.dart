// @dart=2.9
import 'package:avrod/colors/colors.dart';
import 'package:avrod/colors/gradient_class.dart';
import 'package:hive/hive.dart';
import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:sizer/sizer.dart';

import '../main.dart';

// ignore: constant_identifier_names

class ChapterScreen extends StatefulWidget {
  const ChapterScreen(this.bookIndex, {Key key}) : super(key: key);
  final int bookIndex;

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  Box likesBox;

  @override
  void initState() {
    initHive();

    super.initState();
  }

  void initHive() async {
    likesBox = await Hive.openBox(FAVORITES_BOX);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Рӯйхати фаслҳо',
          style: TextStyle(fontSize: 18.sp),
        ),
        centerTitle: true,
        flexibleSpace: Container(decoration: favoriteGradient),
      ),

      // ignore: avoid_unnecessary_containers
      body: Container(
        decoration: favoriteGradient,
        child: FutureBuilder<List<Book>>(
          future: BookMap.getBookLocally(context),
          builder: (contex, snapshot) {
            final book = snapshot.data;
            if (snapshot.hasData) {
              return buildBook(book[widget.bookIndex]);
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Some erro occured'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  Widget buildBook(Book book) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 0.2.h,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3,
          crossAxisCount: 2,
        ),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(top: 5),
        physics: const BouncingScrollPhysics(),
        itemCount: book.chapters?.length ?? 0,
        itemBuilder: (context, index) {
          final Chapter chapter = book.chapters[index];

          // ignore: sized_box_for_whitespace
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TextScreen(
                    texts: chapter.texts,
                    chapter: chapter,
                  );
                }));
              },
              child: CachedNetworkImage(
                  imageUrl: chapter.listimage,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black38,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0)
                          ],
                          gradient: const LinearGradient(
                              colors: [Colors.white54, secondaryTextColor],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16.0))),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.0))),
                            ),
                          ),
                          ListTile(
                            title: Center(
                              child: Text(
                                chapter.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    color: titleTextColor),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 15,
                            right: 10,
                            child: LikeButton(
                              isLiked: isChapterLiked(chapter.id),
                              onTap: (isLiked) async {
                                return setLike(chapter.id, isLiked);
                              },
                              size: 30.sp,
                              circleColor: const CircleColor(
                                  start: Color(0xffFF0000),
                                  end: Color(0xffFF0000)),
                              bubblesColor: const BubblesColor(
                                dotPrimaryColor: Color(0xffffffff),
                                dotSecondaryColor: Color(0xffBF40BF),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            ),
          );
        });
  }

  Future<bool> setLike(int chapterID, bool isLiked) async {
    if (!isLiked) {
      await likesBox.put(chapterID, (true).toString());
    } else {
      await likesBox.delete(chapterID);
    }

    return !isLiked;
  }

  bool isChapterLiked(int chapterID) {
    bool isLiked = likesBox.containsKey(chapterID);
    return isLiked;
  }
}
