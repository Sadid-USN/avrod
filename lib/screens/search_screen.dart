import 'package:avrod/colors/colors.dart';
import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearcScreen extends StatefulWidget {
  final int? bookIndex;
  const SearcScreen({Key? key, this.bookIndex}) : super(key: key);

  @override
  State<SearcScreen> createState() => _SearcScreenState();
}

class _SearcScreenState extends State<SearcScreen> {
  GlobalKey<FormState> formstate1 = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
 
  _SearcScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [gradientStartColor, gradientEndColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.3, 0.7])),
        ),
        title: const Text(
          'Саҳифаи ҷустуҷӯ',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: // ignore: avoid_unnecessary_containers

          Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              // ignore: sized_box_for_whitespace
              child: Container(
                height: 50,
                width: 320,
                child: Form(
                  key: formstate1,
                  child: Center(
                    child: TextFormField(
                      autofocus: true,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (number1) {
                        if (number1!.length > 20) {
                          return ' На бештар аз 20 аломат';
                        }
                        return null;
                      },
                      // maxLength: 4,
                      controller: _heightController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w300,
                      ),
                      keyboardType: TextInputType.text,

                      decoration: InputDecoration(
                        suffixIcon: _heightController.text.isEmpty
                            ? Container(
                                width: 0,
                              )
                            : IconButton(
                                onPressed: () {
                                  _heightController.clear();
                                },
                                icon: const Icon(Icons.close)),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 27,
                          color: Colors.blueGrey,
                        ),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(32.0)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.white, width: 2),
                            borderRadius: BorderRadius.circular(32.0)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              style: BorderStyle.solid,
                              width: 2,
                              color: Colors.green),
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        labelText: 'Ҷустуҷӯ',
                        labelStyle: const TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ignore: avoid_unnecessary_containers
            // Container(
            //   child: FutureBuilder<List<Book>> (
            //     future: BookMap.getBookLocally(context),
            //     builder: (contex, snapshot) {
            //       final book = snapshot.data;
            //       if (snapshot.hasData) {
            //         return buildBook(book![widget.bookIndex!]);
            //       } else if (snapshot.hasError) {
            //         return const Center(
            //           child: Text('Some erro occured'),
            //         );
            //       } else {
            //         return const CircularProgressIndicator();
            //       }
            //     },
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

Widget buildBook(Book book) {
  return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1 / 1.4,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        crossAxisCount: 2,
      ),
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(top: 5),
      physics: const BouncingScrollPhysics(),
      itemCount: book.chapters?.length ?? 0,
      itemBuilder: (context, index) {
        final Chapter chapter = book.chapters![index];

        // ignore: sized_box_for_whitespace
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TextScreen(texts: chapter.texts);
                }));
              },
              child: Container(
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ],
                    gradient: LinearGradient(
                        colors: [Colors.white54, secondaryTextColor],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.black26,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0))),
                      ),
                    ),
                    ListTile(
                      title: Center(
                        child: Text(
                          chapter.name!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                              color: titleTextColor),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      });
}
