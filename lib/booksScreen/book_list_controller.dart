import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BookListController extends GetxController {
  final Stream<QuerySnapshot> books = FirebaseFirestore.instance
      .collection('books')
      .orderBy(
        'author',
      )
      .snapshots();
}
