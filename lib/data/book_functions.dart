import 'dart:convert';
import 'package:avrod/models/book.dart';
import 'package:avrod/models/chapter_model.dart';
import 'package:avrod/models/text_model.dart';
import 'package:flutter/material.dart';

class BookFunctions {
  static Future<List<Book>> getBookLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('lib/data/book.json');
    final List<dynamic> body = json.decode(data);
    return body.map((e) => Book.fromJson(e)).toList();
  }

  static Future<List<ChaptersModel>> getChaptersLocally(
    BuildContext context,
    int book,
  ) async {
    final List<Book> books = await getBookLocally(context);
    return books[book].chapters!;
  }

  static Future<List<TextsModel>> getTextsLocally(
    BuildContext context,
    int book,
    int chapter,
  ) async {
    List<ChaptersModel> chapters = await getChaptersLocally(context, book);
    return chapters[chapter].texts!;
  }
}
