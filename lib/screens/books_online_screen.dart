import 'package:avrod/colors/colors.dart';
import 'package:flutter/material.dart';

class BooksFromNet extends StatefulWidget {
  const BooksFromNet({Key? key}) : super(key: key);

  @override
  _BooksFromNetState createState() => _BooksFromNetState();
}

class _BooksFromNetState extends State<BooksFromNet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gradientStartColor,
        title: const Text('Китобхона', style: TextStyle(fontSize: 22)),
        centerTitle: true,
      ),
    );
  }
}
