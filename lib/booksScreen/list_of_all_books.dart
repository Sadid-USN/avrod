import 'dart:io';
import 'package:avrod/booksScreen/selected_books.dart';
import 'package:avrod/colors/gradient_class.dart';

import 'package:avrod/screens/pdf_api_class.dart';
import 'package:avrod/widgets/all_book.dart';
import 'package:avrod/widgets/books_ditails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';
import '../screens/reading_books_labrary_screen.dart';

class ListOfAllBooks extends StatefulWidget {
  final int? bookIndex;

  const ListOfAllBooks({Key? key, this.bookIndex}) : super(key: key);

  @override
  _ListOfAllBooksState createState() => _ListOfAllBooksState();
}

class _ListOfAllBooksState extends State<ListOfAllBooks> {
  final allBooks = AllBooks(
    allBooks: [
      'Книги на русском',
      'كتاب هاى فارسى',
    ],
  );

  final List<String> images = [
    'https://images.unsplash.com/photo-1614989799749-6c1e704dca56?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
    'https://images.unsplash.com/photo-1500835176302-48dbd01f6437?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1yZWxhdGVkfDE4fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60',
  ];

  bool iosBookPath = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: favoriteGradient,
        ),
        title: Text('Китобхона', style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: Container(
        decoration: favoriteGradient,
        child: AnimationLimiter(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 2 / 1,
                crossAxisSpacing: 1,
                mainAxisSpacing: 5,
                crossAxisCount: 2),
            itemCount: allBooks.allBooks.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: ScaleAnimation(
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SelectedBooks();
                      }));
                    },
                    child: ListTile(

                        // ignore: avoid_unnecessary_containers
                        title: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: CachedNetworkImage(
                            imageUrl: images[index],
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                ),
                                height: 12.h,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Center(
                                    child: Text(
                                      allBooks.allBooks[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void openPDF(BuildContext context, File file) =>
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ReadingBooksOnline(
              file: file,
            )));
 




// Container(
//         decoration: favoriteGradient,
//         child: FutureBuilder<List<LibraryBooks>>(
//           future: LibraryBookFunction.getLibBook(context),
//           builder: (contex, snapshot) {
//             final books = snapshot.data;
//             if (snapshot.hasData) {
//               return builLibraryBook(books![widget.bookIndex ?? 0]);
//             } else if (snapshot.hasError) {
//               return const Center(
//                 child: Text(
//                   'Some erro occured',
//                   style: TextStyle(color: Colors.red, fontSize: 18.0),
//                 ),
//               );
//             } else {
//               return const CircularProgressIndicator();
//             }
//           },
//         ),
//       ),