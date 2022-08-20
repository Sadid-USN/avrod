import 'package:avrod/booksScreen/book_list_controller.dart';
import 'package:avrod/booksScreen/book_reading_screen.dart';

import 'package:avrod/constant/routes/route_names.dart';
import 'package:avrod/utility/skelton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/colors/colors.dart';

class BookList extends StatelessWidget {
  const BookList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BookListController controller = Get.put(BookListController());
    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: bgColor,
        title: Text(
          'library'.tr,
          style: TextStyle(
            fontSize: 18,
            color: Colors.blueGrey.shade800,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(AppRouteNames.homepage);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: listTitleColor,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: controller.books,
        builder:
            ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Somthing went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GridView.builder(
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 2.7,
                ),
                itemBuilder: ((context, index) {
                  return const Skelton();
                }));
          }
          final data = snapshot.requireData;
          return GridView.builder(
              itemCount: data.size,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 2.8,
              ),
              itemBuilder: ((context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return BookReading(
                        data: data.docs.length,
                        title: data.docs[index]['title'],
                        author: data.docs[index]['author'],
                        content: data.docs[index]['content'],
                        image: data.docs[index]['image'],

                        //source: data.docs[index]['source'],
                      );
                    })));
                  },
                  child: Hero(
                    tag: data.docs[index]['image'],
                    child: Container(
                      margin:
                          const EdgeInsets.only(left: 16, top: 10, right: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(data.docs[index]['image']),
                            fit: BoxFit.cover),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(4.0, 4.0),
                              blurRadius: 6.0)
                        ],
                      ),
                    ),
                  ),
                );
              }));
        }),
      ),
    );
  }
}


// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:sizer/sizer.dart';

// import '../colors/gradient_class.dart';
// import '../screens/pdf_api_class.dart';
// import '../widgets/books_ditails.dart';
// import 'list_of_all_books.dart';

// class SelectedBooks extends StatelessWidget {
//   const SelectedBooks({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back_ios)),
//         elevation: 0.0,
//         flexibleSpace: Container(
//           decoration: favoriteGradient,
//         ),
//         title: Text('Китобхона', style: TextStyle(fontSize: 18.sp)),
//         centerTitle: true,
//       ),
//       body: Container(
//         decoration: favoriteGradient,
//         child: AnimationLimiter(
//           child: GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3,
//               childAspectRatio: 2 / 3.0,
//             ),
//             itemCount: booksRu.name!.length,
//             itemBuilder: (context, index) {
//               return AnimationConfiguration.staggeredList(
//                 position: index,
//                 duration: const Duration(milliseconds: 500),
//                 child: ScaleAnimation(
//                   child: InkWell(
//                     onTap: () async {
//                       final file =
//                           await PDFApi.loadNetwork(booksRu.path![index]);
//                       openPDF(context, file);
//                     },
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 15, vertical: 10),
//                           child: CachedNetworkImage(
//                             imageUrl: booksRu.urlImage![index],
//                             imageBuilder: (context, imageProvider) {
//                               return Container(
//                                 decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: imageProvider, fit: BoxFit.cover),
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(16.0)),
//                                 ),
//                                 height: 20.h,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(10.0),
//                                   child: Center(
//                                     child: Text(
//                                       booksRu.name![index],
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           fontSize: 12.sp,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }