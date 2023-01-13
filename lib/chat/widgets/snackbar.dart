import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

snackBar(BuildContext context, Color color, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 2500),
      backgroundColor: color,
      content: Text(
        content,
        style: GoogleFonts.ptSerif(
          color: Colors.white,
          fontSize: 16,
        ),

        // const TextStyle(

        // ),
      ),
    ),
  );
}
