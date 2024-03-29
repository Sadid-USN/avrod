// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:avrod/controller/chaptercontroller.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constant/colors/colors.dart';
import '../models/book.dart';

class SearchScreen extends StatelessWidget {
  final int? indexChapter;

  const SearchScreen({
    Key? key,
    this.indexChapter,
  }) : super(key: key);

  static String routName = '/searchScreen';

  @override
  Widget build(BuildContext context) {
    ChapterController controller = Get.put(ChapterController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: appBabgColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            controller.goToHomePage();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          'hintText'.tr,
          style: const TextStyle(
            fontSize: 18,
            color: titleColor,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Book>>(
        future: controller.bookInit(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final books = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.blueGrey[800],
                      );
                    },
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(top: 5),
                    physics: const BouncingScrollPhysics(),
                    itemCount: books.fold<int>(
                        0, (count, book) => count + book.chapters!.length),
                    itemBuilder: (context, index) {
                      int chapterIndex = 0;
                      for (final book in books) {
                        final chapters = book.chapters!;
                        for (final chapter in chapters) {
                          if (chapterIndex == index) {
                            final name = chapter.name;
                            final id = chapter.id;
                            return ListTile(
                              leading: Text('${id! + 1}'),
                              title: Text(name ?? 'oops'),
                              onTap: () {
                                Get.to(
                                  () => TextScreen(
                                    texts: chapter.texts,
                                    titleAbbar: name!,
                                    chapterID: id + 1,
                                  ),
                                );
                              },
                            );
                          }
                          chapterIndex++;
                        }
                      }
                      return null;
                    },
                  ),
                ),
                GetBuilder<ChapterController>(
                  builder: (_) => Container(
                    margin: const EdgeInsets.only(right: 16, left: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: TextFormField(
                        controller: controller.textEditingController,
                        onChanged: (value) {
                          controller.searchChapters(value);
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Icons.search),
                          border: InputBorder.none,
                          hintText: 'hintText'.tr,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}





// import 'package:avrod/colors/colors.dart';
// import 'package:avrod/colors/gradient_class.dart';
// import 'package:avrod/data/book_map.dart';
// import 'package:avrod/data/book_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:provider/provider.dart';
// import 'package:sizer/sizer.dart';

// class SearcScreen extends StatefulWidget {
//   final int? bookIndex;
//   final List<Book>? books;

//   const SearcScreen({
//     Key? key,
//     this.bookIndex,
//     this.books,
//   }) : super(key: key);

//   @override
//   State<SearcScreen> createState() => _SearcScreenState();
// }

// class _SearcScreenState extends State<SearcScreen> {
  // var listSearch = [];
  // Future getData() async {
  //   var url = 'https://jsonplaceholder.typicode.com/users';
  //   var response = await http.get(Uri.parse(url));
  //   var responseBody = jsonDecode(response.body);
  //   for (int i = 0; i < responseBody.length; i++) {
  //     listSearch.add(responseBody[i]);
  //   }

  //   print(listSearch.toList());
  // }

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

//   @override
//   Widget build(BuildContext context) {
//     final books = Provider.of<List<Book>>(context);
//     return Scaffold(
//         backgroundColor: gradientStartColor,
//         appBar: AppBar(
//             elevation: 0.0,
//             flexibleSpace: Container(
//               decoration: favoriteGradient,
//             ),
//             leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon: const Icon(Icons.arrow_back_ios)),
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     showSearch(
//                         context: context,
//                         delegate: SearchBar(list: widget.books ?? []));
//                   },
//                   icon: const Icon(Icons.search)),
//             ]),

//         // ignore: avoid_unnecessary_containers
//         body: Container(
//           decoration: favoriteGradient,
//           child: FutureBuilder<List<Book>>(
//             future: BookFunctions.getBookLocally(context),
//             builder: (contex, snapshot) {
//               final book = snapshot.data;
//               if (snapshot.hasData) {
//                 return buildBook(book![widget.bookIndex ?? 0]);
//               } else if (snapshot.hasError) {
//                 return const Center(
//                   child: Text('Some erro occured'),
//                 );
//               } else {
//                 return const CircularProgressIndicator();
//               }
//             },
//           ),
//         ));
//   }
// }

// Widget buildBook(Book book) {
//   return AnimationLimiter(
//     child: ListView.builder(
//         scrollDirection: Axis.vertical,
//         padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
//         physics: const BouncingScrollPhysics(),
//         itemCount: book.chapters?.length ?? 0,
//         itemBuilder: (context, index) {
//           final Chapter chapter = book.chapters![index];

//           // ignore: sized_box_for_whitespace
//           return AnimationConfiguration.staggeredGrid(
//             position: index,
//             duration: const Duration(milliseconds: 600),
//             columnCount: book.chapters!.length,
//             child: ScaleAnimation(
//               child: Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: InkWell(
//                   onTap: () {
//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (context) {
//                     //   return TextScreen(
//                     //     textsIndex: chapter.texts,
//                     //     chapter: chapter,
//                     //   );
//                     // }));
//                   },
//                   child:

//                       // ignore: sized_box_for_whitespace
//                       Container(
//                           //   decoration: searchScreenGradient,
//                           height: 12.h,
//                           child: Center(
//                             child: ListTile(
//                               title: Center(
//                                 child: Text(
//                                   book.chapters![index].name!,
//                                   textAlign: TextAlign.center,
//                                   style: TextStyle(
//                                       fontSize: 16.sp,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.white),
//                                 ),
//                               ),
//                               // leading: Padding(
//                               //   padding: const EdgeInsets.only(right: 15),
//                               //   child: Text(chapter.id.toString(),
//                               //       style: const TextStyle(color: Colors.white)),
//                               // ),
//                             ),
//                           )),
//                 ),
//               ),
//             ),
//           );
//         }),
//   );
// }

// class SearchBar extends SearchDelegate<String> {
//   List<Book>? list;
//   SearchBar({this.list});
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {},
//           icon: const Icon(
//             Icons.clear,
//           ))
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         icon: const Icon(
//           Icons.arrow_back_ios,
//           size: 22,
//         ));
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     return Container();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return ListView.builder(
//         itemCount: list!.length,
//         itemBuilder: (context, index) {
//           return Text(list![index].chapters![index].name ?? '');
//         });
//   }
// }
