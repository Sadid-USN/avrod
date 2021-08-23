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

  static Future<List<Chapters>> getSubchaptersLocally(
    BuildContext context,
    int book,
  ) async {
    final List<Book> books = await getBookLocally(context);
    return books[book].chapters!;
  }

  static Future<List<Texts>> getTextsLocally(
    BuildContext context,
    int book,
    int chapter,
  ) async {
    List<Chapters> chapters = await getSubchaptersLocally(context, book);
    return chapters[chapter].texts!;
  }
}
