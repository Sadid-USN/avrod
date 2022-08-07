import 'package:flutter/material.dart';

import '../constant/colors/colors.dart';

class BookReading extends StatefulWidget {
  List<dynamic>? content;
  final int? data;
  final String? title;
  final String? author;
  // final String? source;
  BookReading({Key? key, this.title, this.author, this.data, this.content
      // this.source,
      })
      : super(
          key: key,
        );

  @override
  State<BookReading> createState() => _BookReadingState();
}

class _BookReadingState extends State<BookReading> {
  int currentPage = 0;
  PageController? pageController;
  nextPage() {
    currentPage++;
    if (currentPage > widget.content!.length - 1) {
      // Get.offNamed(AppRouteNames.login);
    } else {
      pageController?.animateToPage(currentPage,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  onPageChanged(index) {
    currentPage = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        extendBodyBehindAppBar: true,
        body: PageView.builder(
            controller: nextPage(),
            onPageChanged: (index) {
              onPageChanged(index);
            },
            itemCount: widget.content!.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return BookInfo(
                  title: widget.title,
                  author: widget.author,
                );
              } else {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BookInfo(
                            subtitle: widget.content![index - 1]['subtitle']),
                        BookInfo(
                          title: widget.content![index - 1]['title'],
                        ),
                        BookInfo(
                          text: widget.content![index - 1]['text'],
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));

    // Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //       child: Text(
    //         widget.title!,
    //         textAlign: TextAlign.center,
    //         style: const TextStyle(
    //             fontWeight: FontWeight.bold, letterSpacing: 1.5),
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 20,
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //       child: Text(
    //         widget.author!,
    //         textAlign: TextAlign.center,
    //         style: const TextStyle(
    //             fontWeight: FontWeight.normal, letterSpacing: 1.5),
    //       ),
    //     ),
    //   ],
    // )
    // );
  }
}

class BookInfo extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? text;

  final String? author;
  final Border? border;
  final double? height;

  const BookInfo(
      {Key? key,
      this.title,
      this.author,
      this.border,
      this.height,
      this.subtitle,
      this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: Column(
          children: [
            Text(
              subtitle ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
            Text(
              title ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(letterSpacing: 1.5, color: Colors.blueGrey[900]),
            ),
            Text(
              text ?? '',
              textAlign: TextAlign.start,
              style: TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.blueGrey[900],
                  fontSize: 18),
            ),
            Text(
              author ?? '',
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
