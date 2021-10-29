import 'package:avrod/colors/colors.dart';
import 'package:avrod/colors/gradient_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:avrod/data/book_functions.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';

class SearcScreen extends StatefulWidget {
  final int? bookIndex;

  const SearcScreen({
    Key? key,
    this.bookIndex,
  }) : super(key: key);

  @override
  State<SearcScreen> createState() => _SearcScreenState();
}

class _SearcScreenState extends State<SearcScreen> {
  _SearcScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: gradientStartColor,
        appBar: AppBar(
          elevation: 0.0,
          flexibleSpace: Container(
            decoration: favoriteGradient,
          ),
          title: Text(
            'Саҳифаи ҷустуҷӯ',
            style: TextStyle(fontSize: 18.sp),
          ),
          centerTitle: true,
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          decoration: favoriteGradient,
          child: FutureBuilder<List<Book>>(
            future: BookFunctions.getBookLocally(context),
            builder: (contex, snapshot) {
              final book = snapshot.data;
              if (snapshot.hasData) {
                return buildBook(book![widget.bookIndex ?? 0]);
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text('Some erro occured'),
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ));
  }
}

Widget buildBook(Book book) {
  return AnimationLimiter(
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        physics: const BouncingScrollPhysics(),
        itemCount: book.chapters!.length,
        itemBuilder: (context, index) {
          final Chapter chapter = book.chapters![index];
  
          // ignore: sized_box_for_whitespace
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration:  const Duration(milliseconds: 600),
            columnCount: book.chapters!.length,
            child: ScaleAnimation(

              child: Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return TextScreen(
                        texts: chapter.texts,
                        chapter: chapter,
                      );
                    }));
                  },
                  child:
              
                      // ignore: sized_box_for_whitespace
                      Container(
                          decoration: searchScreenGradient,
                          height: 12.h,
                          child: Center(
                            child: ListTile(
                              title: Center(
                                child: Text(
                                  chapter.name!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                              // leading: Padding(
                              //   padding: const EdgeInsets.only(right: 15),
                              //   child: Text(chapter.id.toString(),
                              //       style: const TextStyle(color: Colors.white)),
                              // ),
                            ),
                          )),
                ),
              ),
            ),
          );
        }),
  );
}
