import 'package:avrod/constant/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData tajikTheme = ThemeData(
  textTheme: TextTheme(
    headline1: GoogleFonts.ptSerif(
      textStyle: const TextStyle(
        color: titleColor,
        //fontFamily: 'Cairo',
      ),
      fontSize: 10,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: GoogleFonts.varta(
      textStyle: const TextStyle(color: bodyColor, fontWeight: FontWeight.w600),
      fontSize: 20,
      //fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
    ),
  ),
);
ThemeData englishTheme = ThemeData(
  textTheme: TextTheme(
    headline1: GoogleFonts.andadaPro(
      textStyle: const TextStyle(
        color: titleColor,
      ),
      fontSize: 11,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: GoogleFonts.montserrat(
      textStyle: const TextStyle(
        color: bodyColor,
        fontWeight: FontWeight.w600,
      ),
      fontSize: 20,
      fontStyle: FontStyle.normal,
    ),
  ),
);
