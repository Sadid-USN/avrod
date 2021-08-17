import 'dart:convert';
import 'package:flutter/material.dart';
import 'book_class.dart';

class BookMap {
  static Future<List<Book>> getBookLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('lib/data/book.json');
    final body = json.decode(data);
    return body.map<Book>(Book.fromJson(body)).toList();
  }
}
