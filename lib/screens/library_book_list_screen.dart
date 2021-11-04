
import 'dart:io';
import 'package:avrod/colors/gradient_class.dart';

import 'package:avrod/screens/pdf_api_class.dart';
import 'package:avrod/widgets/title_and_path_of_books.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sizer/sizer.dart';
import 'reading_books_labrary_screen.dart';

class LibraryBookList extends StatefulWidget {
  final int? bookIndex;

  const LibraryBookList({Key? key, this.bookIndex})
      : super(key: key);

  @override
  _LibraryBookListState createState() => _LibraryBookListState();
}

class _LibraryBookListState extends State<LibraryBookList> {
  final List<TiitleAndPath> books = [
    TiitleAndPath(
        imgUrl:
            'https://images.unsplash.com/photo-1542816417-0983c9c9ad53?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        path:
            'http://aqeedeh.com/book_files/pdf/fa/qoran-ra-chegune-bekhanim-PDF.pdf',
     
        name: 'قرآن را چگونه بخوانیم؟'),
          TiitleAndPath(
        imgUrl:
            'https://images.unsplash.com/photo-1627337840960-d55af60bf8e3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=687&q=80',
        path:
            'http://aqeedeh.com/book_files/pdf/fa/lahazatee-ba-sokhanan-delnasheen-payambar-PDF.pdf',
        name: ' (ﷺ) لحظاتی باسخنان دلنشین پیامبر '),
     TiitleAndPath(
        imgUrl:
            'https://images.unsplash.com/photo-1464798429116-8e26f96b2e60?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80',
        path:
            'http://aqeedeh.com/book_files/pdf/fa/semay-sorat-va-seerat-zan-dar-islam-PDF.pdf',
        name: 'سیمای صورت و سیرت زن در اسلام'),
    TiitleAndPath(
        imgUrl:
            'https://images.unsplash.com/photo-1594047543253-43f56592fe1e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
        path:
            'http://aqeedeh.com/book_files/pdf/fa/seerat-akhlaqi-payambar-PDF.pdf',
        name: 'سیرت اخلاقی رسول گرامی (ﷺ) '),
    TiitleAndPath(
        name: 'Слова Единобожия «ля иляха илля Ллах»',
        path:
            'https://static.toislam.ws/files/biblioteka/biblioteka_pdf/01_aqida/32_kalimatu_tauhid.pdf',
        imgUrl:
            'https://images.unsplash.com/photo-1575645513913-c002ea3b2e01?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1073&q=80'),
       TiitleAndPath(
        imgUrl:
            'https://toislam.ws/wp-content/uploads/2013/05/vera_up_down-830x402.jpg',
        name: 'Причины увеличения и уменьшения веры',
        path:
            'https://static.toislam.ws/files/biblioteka/biblioteka_pdf/01_aqida/04_prichini_uvelicheniya_i_umensheniya_imana.pdf'),
   
    TiitleAndPath(
        imgUrl:
            'https://images.unsplash.com/photo-1614989799749-6c1e704dca56?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
        name: 'Ангелы с точки зрения Ислама',
        path:
            'https://static.toislam.ws/files/biblioteka/biblioteka_pdf/01_aqida/25_angeli.pdf'),
    TiitleAndPath(
        imgUrl:
            'https://images.unsplash.com/photo-1535923890939-666b60f4d20c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=765&q=80',
        name: 'О вхождении джинов в тело человека',
        path:
            'https://static.toislam.ws/files/biblioteka/biblioteka_pdf/01_aqida/21_o_vhojdenii_djinov.pdf'),
  
      TiitleAndPath(
        imgUrl:
            'https://images.unsplash.com/photo-1501862700950-18382cd41497?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=819&q=80',
        name: 'Доказательства единобожия',
        path:
            'https://static.toislam.ws/files/biblioteka/biblioteka_pdf/01_aqida/03_dokazat_edinobojiya.pdf'),
    TiitleAndPath(
        imgUrl:
            'https://toislam.ws/wp-content/uploads/2013/05/jenshina_v_rau-520x292.jpg',
        name: 'С кем будет женщина в Раю?',
        path:
            'https://static.toislam.ws/files/biblioteka/biblioteka_pdf/01_aqida/14_s_kem_jenshina_v_rayu.pdf')
  
  
  ];

  bool iosBookPath = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: mainScreenGradient,
        ),
        title: Text('Китобхона', style: TextStyle(fontSize: 18.sp)),
        centerTitle: true,
      ),
      body: Container(
        decoration: mainScreenGradient,
        child: AnimationLimiter(
          child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: ScaleAnimation(
                    child: InkWell(
                      onTap: () async {
                        final file =
                            await PDFApi.loadNetwork(books[index].path!);
                        openPDF(context, file);
                      },
                      child: ListTile(

                          // ignore: avoid_unnecessary_containers
                          title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: CachedNetworkImage(
                              imageUrl: books[index].imgUrl!,
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(16.0)),
                                  ),
                                  height: 12.h,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Center(
                                      child: Text(
                                        books[index].name!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            fontSize: 20.0,
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
              }),
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