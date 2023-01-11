import 'package:avrod/booksScreen/book_reading_screen.dart';
import 'package:avrod/controller/homepage_controller.dart';

import 'package:avrod/screens/home_page.dart';
import 'package:avrod/utility/skelton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/colors/colors.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({
    Key? key,
  }) : super(key: key);

  static String routName = '/libraryScreen';

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());
    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 3.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        backgroundColor: appBabgColor,
        title: Text(
          'library'.tr,
          style: TextStyle(
            fontSize: 18,
            color: Colors.blueGrey.shade800,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(HomePage.routName);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
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
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
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
