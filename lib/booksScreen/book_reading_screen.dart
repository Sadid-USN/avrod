import 'package:animate_icons/animate_icons.dart';
import 'package:avrod/main.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../constant/colors/colors.dart';

class BookReading extends StatefulWidget {
  List<dynamic>? content;
  final int? data;
  final String? title;
  final String? author;
  // final String? source;
  BookReading({
    Key? key,
    this.title,
    this.author,
    this.data,
    this.content,
    // this.source,
  }) : super(
          key: key,
        );

  @override
  State<BookReading> createState() => _BookReadingState();
}

class _BookReadingState extends State<BookReading> {
  int currentPage = 0;

  Box? savePageBox;

  void initHive() async {
    savePageBox = await Hive.openBox(FAVORITES_BOX);
  }

  bool isOntap = false;

  @override
  void initState() {
    initHive();

    super.initState();
  }

  AnimateIconController controller = AnimateIconController();
  @override
  void dispose() {
    controller;
    super.dispose();
  }

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

  Future<bool> saveLastVisitPage(bool onTap, int id, content) async {
    if (!onTap) {
      await savePageBox!.put(id, content);
    } else {
      await savePageBox!.delete(id);
    }

    return !onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title!,
          style: TextStyle(color: listTitleColor, fontSize: 16.0),
        ),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: const Color.fromARGB(255, 231, 208, 180),
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        actions: [
          AnimateIcons(
            startIcon: Icons.book_outlined,
            endIcon: Icons.book,
            controller: controller,
            size: 25.0,
            onStartIconPress: () {
              return true;
            },
            onEndIconPress: () {
              return true;
            },
            duration: const Duration(milliseconds: 250),
            startIconColor: listTitleColor,
            endIconColor: Colors.blueGrey,
            clockwise: false,
          ),
        ],
        // leading: IconButton(
        //     onPressed: () {
        //  Get.toNamed(AppRouteNames.bookList);
        //     },
        //     icon: Icon(
        //       Icons.arrow_back_ios,
        //       color: listTitleColor,
        //     )),
      ),
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
            return AuthorInfo(
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
                      id: widget.content![index - 1]['id'],
                      title: widget.content![index - 1]['title'],
                      subtitle: widget.content![index - 1]['subtitle'],
                      text: widget.content![index - 1]['text'],
                      sources: widget.content![index - 1]['sources'],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //     backgroundColor: listTitleColor,
      //     child: Icon(
      //       isOntap ? Icons.book : Icons.book_outlined,
      //       size: 25.0,
      //     ),
      //     onPressed: () {
      //       setState(() {
      //         isOntap = !isOntap;
      //       });
      //     }),
    );
  }
}

class AuthorInfo extends StatelessWidget {
  final String? author;
  final String? title;
  const AuthorInfo({
    Key? key,
    this.author,
    this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 198, 176),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(
              title ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.black,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16.0,
            ),
            SelectableText(
              author ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                letterSpacing: 1.0,
                color: Colors.black,
                fontSize: 13.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BookInfo extends StatelessWidget {
  final String? id;
  final String? title;
  final String? subtitle;
  final String? text;
  final List<dynamic>? sources;

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
      this.id,
      this.text,
      this.sources})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            SelectableText(
              id ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 16.0),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SelectableText(
              subtitle ?? '',
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 14.0),
            ),
            const SizedBox(
              height: 8.0,
            ),
            SelectableText(
              text ?? '',
              textAlign: TextAlign.start,
              style: TextStyle(
                  letterSpacing: 0.7,
                  color: Colors.blueGrey[900],
                  fontSize: 16),
            ),
            const SizedBox(
              height: 12.0,
            ),
            SelectableText(
              sources!.map((e) => e['source']).toString(),
              textAlign: TextAlign.start,
              style: TextStyle(
                  letterSpacing: 1.0,
                  color: Colors.blueGrey[900],
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}
