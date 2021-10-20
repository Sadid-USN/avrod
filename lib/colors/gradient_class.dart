import 'package:flutter/material.dart';

BoxDecoration mainScreenGradient = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.green,
        Color(0xff00CCCC),
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

BoxDecoration searchScreenGradient =   const BoxDecoration(
    boxShadow:  [
      BoxShadow(
          color: Colors.black38, offset: Offset(0.0, 2.0), blurRadius: 6.0)
    ],
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.blueGrey,
        Colors.cyan,
      ],
    ));


BoxDecoration calendarGradient =   const BoxDecoration(
    boxShadow:  [
      BoxShadow(
          color: Colors.black38, offset: Offset(0.0, 2.0), blurRadius: 6.0)
    ],
    //borderRadius: BorderRadius.all(Radius.circular(16.0)),
    gradient: LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Colors.blueGrey,
        Colors.cyan,
      ],
    ));