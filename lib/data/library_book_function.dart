import 'dart:convert';
import 'package:flutter/material.dart';
import 'library_books_map.dart';

class LibraryBookFunction
 {
  static Future<List<LibraryBooks>> getLibBook(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('lib/data/library_books.json');
    final List<dynamic> body = json.decode(data);
    return body.map((e) => LibraryBooks.fromJson(e)).toList();
  }
}
