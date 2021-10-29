import 'dart:io';
import 'package:avrod/colors/gradient_class.dart';
import 'package:avrod/data/library_book_function.dart';
import 'package:avrod/data/library_books_map.dart';
import 'package:avrod/screens/reading_books_labrary_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class LibraryFromNet extends StatefulWidget {
  final int? bookIndex;
  final LibraryBooks? libBook;
  const LibraryFromNet({Key? key, this.bookIndex, this.libBook})
      : super(key: key);

  @override
  _LibraryFromNetState createState() => _LibraryFromNetState();
}

class _LibraryFromNetState extends State<LibraryFromNet> {
  File? file;
  var imagePicker = ImagePicker();

  Future uploadImage() async {
    var imagePicked = await imagePicker.pickImage(source: ImageSource.gallery);

    if (imagePicked != null) {
      file = File(imagePicked.path);

      var nameImage = basename(imagePicked.path);
      // ignore: avoid_print
      print('===============================');
      // ignore: avoid_print
      print(imagePicked.path);
      // Start upload
      var refStorge = FirebaseStorage.instance.ref('images/$nameImage');
      await refStorge.putFile(file!);
      var url = await refStorge.getDownloadURL();
      print('url $url');
      // End upload
    } else {
      print('choose image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: favoriteGradient,
        ),
        title: Text('Китобхона', style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: Container(
        decoration: favoriteGradient,
        child: FutureBuilder<List<LibraryBooks>>(
          future: LibraryBookFunction.getLibBook(context),
          builder: (contex, snapshot) {
            final books = snapshot.data;
            if (snapshot.hasData) {
              return builLibraryBook(books![widget.bookIndex ?? 0]);
            } else if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Some erro occured',
                  style: TextStyle(color: Colors.red, fontSize: 18.0),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

Widget builLibraryBook(LibraryBooks book) {
  return AnimationLimiter(
    child: ListView.builder(
        itemCount: book.books?.length ?? 0,
        itemBuilder: (context, index) {
          final Books name = book.books![index];
          final Books url = book.books![index];

          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: ScaleAnimation(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ReadingBooksOnline(
                      url: url,
                    );
                  }));
                },
                child: ListTile(
            
                    // ignore: avoid_unnecessary_containers
                    title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        decoration: searchScreenGradient,
                        height: 12.h,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Center(
                            child: Text(
                              name.name!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          );
        }),
  );
}
