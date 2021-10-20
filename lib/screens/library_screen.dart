import 'package:avrod/colors/gradient_class.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LibraryFromNet extends StatefulWidget {
  const LibraryFromNet({Key? key}) : super(key: key);

  @override
  _LibraryFromNetState createState() => _LibraryFromNetState();
}

class _LibraryFromNetState extends State<LibraryFromNet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: favoriteGradient,
        ),
        title:  Text('Китобхона', style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: Container(
        decoration: favoriteGradient,
      ),
    );
  }
}
