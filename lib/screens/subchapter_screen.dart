import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:flutter/material.dart';

class SubchapterScreen extends StatefulWidget {
  const SubchapterScreen(this.bookIndex, {Key? key}) : super(key: key);
  final int bookIndex;

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
          if (snapshot.hasData) {
            return buildBook(books![widget.bookIndex]);
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Some erro occured'),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Widget buildBook(Book books) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: books.chapters?.length ?? 0,
      itemBuilder: (context, index) {
        final chapters = books.chapters![index];
        return ListTile(
          title: Text(chapters.name!),
        );
      });
}
