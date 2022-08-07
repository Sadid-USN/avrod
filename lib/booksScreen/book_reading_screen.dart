import 'package:avrod/constant/routes/route_names.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/colors/colors.dart';

class BookReading extends StatefulWidget {
  final String? title;
  final String? author;
  // final String? source;
  const BookReading({
    Key? key,
    this.title,
    this.author,
    // this.source,
  }) : super(
          key: key,
        );

  @override
  State<BookReading> createState() => _BookReadingState();
}

class _BookReadingState extends State<BookReading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: bgColor,
          title: Text(
            'library'.tr,
            style: TextStyle(
              fontSize: 18,
              color: Colors.blueGrey.shade800,
            ),
          ),
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Get.offAllNamed(AppRouteNames.homepage);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: listTitleColor,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.author!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, letterSpacing: 1.5),
              ),
            ),
          ],
        ));
  }
}
