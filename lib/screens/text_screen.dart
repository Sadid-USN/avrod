import 'package:avrod/colors/colors.dart';
import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  final Book? books;
  final int? textIndex;
  const TextScreen({Key? key, this.books, this.textIndex}) : super(key: key);
  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.3, 0.7])),
        child: FutureBuilder<List<Book>>(
          future: BookMap.getBookLocally(context),
          builder: (contex, snapshot) {
            final books = snapshot.data;

            if (snapshot.hasData) {
              return buildBook(books![widget.textIndex ?? 0]);
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Some erro occured'),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      
    );
    
  }

  Widget buildBook(Book book) {
    
    return ListView.builder(
      
        itemCount: book.chapters!.length,
        itemBuilder: (context, index) {
          final text = book.chapters![index].texts;
          // ignore: avoid_unnecessary_containers
          return Container(child: Center(child: Text(text?[index].id ?? '')));
        });
  }
}
