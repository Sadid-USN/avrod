import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors/colors.dart';

ThemeData themeEnglish = ThemeData(
  textTheme: TextTheme(
    headline1: GoogleFonts.ptSerif(
      textStyle: const TextStyle(
        color: titleColor,
        //fontFamily: 'Cairo',
      ),
      fontSize: 22,
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
ThemeData themeArabic = ThemeData(
  textTheme: TextTheme(
    headline1: GoogleFonts.cairo(
      textStyle: const TextStyle(
        color: titleColor,
        fontFamily: 'Cairo',
      ),
      fontSize: 22,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal,
    ),
    bodyText1: GoogleFonts.cairo(
      textStyle: const TextStyle(
        color: bodyColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Cairo',
      ),
      fontSize: 20,
      fontStyle: FontStyle.normal,
    ),
  ),
);
