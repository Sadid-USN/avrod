

import 'package:avrod/data/book_map.dart';
import 'package:avrod/data/book_class.dart';
import 'package:flutter/material.dart';

class SubchapterScreen extends StatefulWidget {
  const SubchapterScreen({Key? key}) : super(key: key);

  @override
  State<SubchapterScreen> createState() => _SubchapterScreenState();
}

class _SubchapterScreenState extends State<SubchapterScreen> {
  final data = Book();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Рӯйхати бобҳо'), centerTitle: true),
      body: FutureBuilder<List<Book>>(
        future: BookMap.getBookLocally(context),
        builder: (contex, snapshot) {
          final books = snapshot.data;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return const Center(child: Text('Some error occured'));
              } else {
                return buildBook(books!);
              }
          }
        },
      ),
    );
  }

  Widget buildBook(List<Book> books) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return  ListTile(
          title: Text(book.name!),
        );
      });
}
