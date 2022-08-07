import 'package:avrod/booksScreen/selected_books.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowBook extends StatefulWidget {
  const ShowBook({Key? key}) : super(key: key);

  @override
  State<ShowBook> createState() => _ShowBookState();
}

class _ShowBookState extends State<ShowBook> {
  // final user = FirebaseAuth.instance.currentUser;

  List<String> userIDs = [];

  Future getUserIDs() async {
    await FirebaseFirestore.instance
        .collection('odob')
        .orderBy('id', descending: false)
        .get()
        .then((snapshot) => snapshot.docs.forEach((document) {
              // print(document.reference);
              userIDs.add(document.reference.id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          // FirebaseAuth.instance.signOut();
        }),
        child: const Icon(
          Icons.exit_to_app,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder(
                  future: getUserIDs(),
                  builder: (BuildContext context, snapshot) {
                    return ListView.builder(
                        itemCount: userIDs.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: const [
                              //  SelectedBooks(documentId: userIDs[index]),
                            ],
                          );
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
