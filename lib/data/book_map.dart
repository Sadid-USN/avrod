import 'dart:convert';
import 'package:flutter/material.dart';
import 'book_class.dart';

class BookMap {
  static Future<List<Book>> getBookLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('lib/data/book.json');
    final List<dynamic> body = json.decode(data);
    return body.map((e) => Book.fromJson(e)).toList();
  }
}

class TextsMap {
  static Future<List<Texts>> getTextsLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('lib/data/book.json');
    final List<dynamic> body = json.decode(data);
    return body.map((e) => Texts.fromJson(e)).toList();
  }
}

