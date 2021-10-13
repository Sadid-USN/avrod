import 'package:flutter/material.dart';

BoxDecoration mygGradient = const BoxDecoration(
    gradient: LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Colors.green,
    Colors.cyan,
  ],
));

BoxDecoration favoriteGradient = const BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.topRight,
        colors: [
     Colors.green,
    Colors.cyan,
    ]));

