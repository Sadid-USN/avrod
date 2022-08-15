import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../constant/colors/colors.dart';

class BookReading extends StatefulWidget {
  List<dynamic>? content;
  final int data;
  final String title;
  final String author;
  final String? image;
  // final String? source;
  BookReading(
      {Key? key,
      required this.title,
      required this.author,
      required this.data,
      this.content,
      this.image
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

  Box? savePageBox;

  void initHive() async {
    savePageBox = await Hive.openBox('pageBox');
  }

  bool isOntap = false;

  AnimateIconController controller = AnimateIconController();
  @override
  void initState() {
    initHive();
    controller = AnimateIconController();
    super.initState();
  }

  @override
  void dispose() {
    controller;
    super.dispose();
  }

  PageController? pageController;
  nextPage() {
    currentPage++;
    if (currentPage > widget.content!.length - 1) {
      savePageBox!.put(widget.data, widget.content);
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
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Text(
            widget.title,
            style: TextStyle(color: listTitleColor, fontSize: 16.0),
          ),
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
              setState(() {
                nextPage();
              });
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
            return Hero(
              tag: widget.image!,
              child: AuthorInfo(
                title: widget.title,
                author: widget.author,
                image: widget.image,
              ),
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
    );
  }
}

class AuthorInfo extends StatelessWidget {
  final String? author;
  final String? title;
  final String? image;
  const AuthorInfo({
    Key? key,
    this.author,
    this.title,
    this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 215, 198, 176),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  height: 200.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(4.0, 4.0),
                          blurRadius: 6.0)
                    ],
                    borderRadius: BorderRadius.circular(12.0),
                    image: DecorationImage(
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(1.0), BlendMode.dstATop),
                        image: NetworkImage(image ?? ''),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
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
                  height: 10.0,
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

  const BookInfo({
    Key? key,
    this.title,
    this.author,
    this.border,
    this.height,
    this.subtitle,
    this.id,
    this.text,
    this.sources,
  }) : super(key: key);

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
