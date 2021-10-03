import 'package:avrod/colors/colors.dart';
import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearcScreen extends StatefulWidget {
  final int? bookIndex;
  const SearcScreen({Key? key, this.bookIndex}) : super(key: key);

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
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [gradientStartColor, gradientEndColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 0.7])),
          ),
          title: const Text(
            'Саҳифаи ҷустуҷӯ',
            style: TextStyle(fontSize: 22),
          ),
          centerTitle: true,
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          color: Colors.white,
          child: FutureBuilder<List<Book>>(
            future: BookMap.getBookLocally(context),
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
  return ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(top: 5),
      physics: const BouncingScrollPhysics(),
      itemCount: book.chapters!.length,
      itemBuilder: (context, index) {
        final Chapter chapter = book.chapters![index];

        // ignore: sized_box_for_whitespace
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TextScreen(texts: chapter.texts);
                }));
              },
              child: Column(
                children: [
                  // ignore: sized_box_for_whitespace
                  Container(
                      
                      height: 14.h,
                      child: Center(
                        child: ListTile(
                          title: Center(
                            child: Text(
                              chapter.name!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                          leading: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Text(chapter.id.toString(),
                                style: const TextStyle(color: Colors.white)),
                          ),
                        ),
                      )),
                ],
              )),
        );
      });
}
