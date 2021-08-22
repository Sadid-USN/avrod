import 'package:avrod/colors/colors.dart';
import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  final Book? books;
  final int? textIndex;
  const TextScreen({Key? key, this.books, this.textIndex}) : super(key: key);
  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Scaffold(
        appBar: AppBar(
          title: const Text('Лафзи дуо'),
          centerTitle: true,
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          child: const Center(child: Text('Text of book')),
        ));
  }

//   Widget buildBook(Book book) {

//     return
//   }
// }
}
