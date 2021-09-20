import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearcScreen extends StatelessWidget {
  const SearcScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          // ignore: avoid_unnecessary_containers
          Center(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CupertinoSearchTextField(
              backgroundColor: Colors.cyan.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10.0),
              // decoration: BoxDecoration(),
              autofocus: true,
            )),
      ),
    );
  }
}
