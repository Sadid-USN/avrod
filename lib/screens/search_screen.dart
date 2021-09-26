import 'package:avrod/colors/colors.dart';
import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearcScreen extends StatefulWidget {
  final int? bookIndex;
  const SearcScreen({Key? key, this.bookIndex}) : super(key: key);

  @override
  State<SearcScreen> createState() => _SearcScreenState();
}

class _SearcScreenState extends State<SearcScreen> {
  Book? book;
  _SearcScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [gradientStartColor, gradientEndColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 0.7])),
        ),
        title: const Text('Саҳифаи ҷустуҷӯ'),
        centerTitle: true,
      ),
      body: // ignore: avoid_unnecessary_containers

          Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: CupertinoSearchTextField(
            backgroundColor: Colors.cyan.withOpacity(0.3),
            // borderRadius: BorderRadius.circular(10.0),
            autofocus: true,
          ),
        ),
      ),
      // ListView.builder(
      //   itemCount: book!.chapters!.length,
      //   itemBuilder: (context, index) {

      // ignore: avoid_unnecessary_containers
      //   return Container(child: Text(book!.chapters![index].name ?? ''),);
      // })
    );
  }
}
