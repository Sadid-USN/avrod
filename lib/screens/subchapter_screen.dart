import 'package:avrod/colors/colors.dart';

import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';


class SubchapterScreen extends StatefulWidget {
  const SubchapterScreen(this.bookIndex, {Key? key}) : super(key: key);
  final int bookIndex;

  @override
  State<SubchapterScreen> createState() => _SubchapterScreenState();
}

class _SubchapterScreenState extends State<SubchapterScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.0,
          backgroundColor: gradientStartColor,
          title: const Text('Рӯйхати бобҳо'),
          centerTitle: true),
      // ignore: avoid_unnecessary_containers
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [ gradientStartColor, gradientEndColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: FutureBuilder<List<Book>>(
          future: BookMap.getBookLocally(context),
          builder: (contex, snapshot) {
            final books = snapshot.data;
            if (snapshot.hasData) {
              return buildBook(books![widget.bookIndex]);
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

  Widget buildBook(Book books) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 1 / 1.4,
            crossAxisSpacing: 3,
            mainAxisSpacing: 3,
            crossAxisCount: 2),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(top: 5),
        physics: const BouncingScrollPhysics(),
        itemCount: books.chapters?.length ?? 0,
        itemBuilder: (context, index) {
          final chapters = books.chapters![index];
         

          // ignore: sized_box_for_whitespace
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: InkWell(
              onTap: () {
              
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                 return const TextScreen();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(chapters.listimage!),
                        fit: BoxFit.cover),
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
                        height: 250,
                        width: 170,
                      ),
                    ),
                    ListTile(
                      title: Center(
                        child: Text(
                          chapters.name!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                              color: titleTextColor),
                        ),
                      ),
                    ),
                    const Positioned(
                      top: 15,
                      right: 10,
                      child: LikeButton(
                        size: 40,
                        circleColor: CircleColor(
                            start: Color(0xffDC143C), end: Color(0xffFF0000)),
                        bubblesColor: BubblesColor(
                          dotPrimaryColor: Color(0xffFF0000),
                          dotSecondaryColor: Color(0xffFF0000),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
