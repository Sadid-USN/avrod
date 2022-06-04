import 'package:avrod/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SelectedBooks extends StatefulWidget {
  const SelectedBooks({
    Key? key,
  }) : super(key: key);
  @override
  State<SelectedBooks> createState() => _SelectedBooksState();
}

class _SelectedBooksState extends State<SelectedBooks> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,

        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: bgColor,
          title: Text(
            'Китобхона',
            style: TextStyle(fontSize: 18, color: Colors.blueGrey.shade800),
          ),
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: listTitleColor,
            ),
          ),
        ),
        // backgroundColor: bgColor.withOpacity(0.0),
        // appBar: AppBar(
        //   elevation: 0.0,
        //   backgroundColor: bgColor,
        //   title: Text(
        //     'Китобхона',
        //     style: TextStyle(fontSize: 18, color: listTitleColor),
        //   ),
        //   centerTitle: true,
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: Icon(
        //       Icons.arrow_back_ios,
        //       color: listTitleColor,
        //     ),
        //   ),
        // ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Китобхона айни замон дар марҳилаи эҷод аст, агар шумо барои нусхабардории китобҳо ба мо кумаки худро расондани бошед, лутфан бо мо тамос гиред:\n',
                  style:
                      TextStyle(color: Colors.blueGrey.shade800, fontSize: 16),
                ),
                Row(
                  children: const [
                    SelectableText(
                      '📨 tajikplus@gmail.com',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Image.asset(
                      'images/telegram.png',
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const SelectableText(
                      '@Official_najottv',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
                Expanded(
                  child: Lottie.network(
                      'https://assets7.lottiefiles.com/packages/lf20_yg29hewu.json',
                      repeat: false),
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
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
