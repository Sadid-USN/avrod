// @dart=2.9
import 'dart:io';
import 'package:avrod/colors/gradient_class.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class LibraryFromNet extends StatefulWidget {
  const LibraryFromNet({Key key}) : super(key: key);

  @override
  _LibraryFromNetState createState() => _LibraryFromNetState();
}

class _LibraryFromNetState extends State<LibraryFromNet> {
  File file;
  var imagePicker = ImagePicker();

  uploadImage() async {
    var imagePicked = await imagePicker.pickImage(source: ImageSource.camera);
    if (imagePicked != null) {
      file = File(imagePicked.path);
      var nameImage = basename(imagePicked.path);
      print('===============================');
      // Start upload
      var refStorge =  FirebaseStorage.instance.ref('images/$nameImage');
      await refStorge.putFile(file);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await uploadImage();
                },
                child: const SizedBox(
                  height: 60,
                  width: 100,
                  child: Center(
                    child: Text(
                      'Пахш',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
