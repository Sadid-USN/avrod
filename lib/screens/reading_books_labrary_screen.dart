
import 'package:avrod/data/library_books_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ReadingBooksOnline extends StatelessWidget {
  final Books? url;
  const ReadingBooksOnline({Key? key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
         
      child: PDF(
        nightMode: false,
        onError: (error) => Center(child: Text(error.toString())),
        swipeHorizontal: true,
      ).cachedFromUrl(
        url!.url!,
      ),
    ));
  }
}
