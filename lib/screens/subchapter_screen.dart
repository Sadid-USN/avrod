import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:flutter/material.dart';

class SubchapterScreen extends StatefulWidget {
  final int bookIndex;

  const SubchapterScreen(this.bookIndex);

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
                return const Center(
                    child: Text(
                  'Some error occured',
                  style: TextStyle(fontSize: 22.0),
                ));
              } else {
                return buildBook(books![widget.bookIndex]);
              }
          }
        },
      ),
    );
  }

  Widget buildBook(Book book) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: book.chapters?.length ?? 0,
      itemBuilder: (context, index) {
        final chapter = book.chapters![index];
        return ListTile(
          title: Text(chapter.name!),
        );
      });
}
