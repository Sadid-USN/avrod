// ignore_for_file: sized_box_for_whitespace

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avrod/colors/colors.dart';
import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:flutter/material.dart';

class TextScreen extends StatefulWidget {
  final List<Texts>? texts;

  const TextScreen({Key? key, this.texts}) : super(key: key);

  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
 
  Widget _contentItem(String text) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _contentArabic(String arabic) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.white10,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0)
                ],
                gradient: LinearGradient(
                    colors: [Colors.white30, secondaryTextColor],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            padding: const EdgeInsets.all(30.0),
            child: Text(
              arabic,
              textAlign: TextAlign.center,
              style: const TextStyle(
                wordSpacing: 1.0,
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentTranslation(String text) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24.0,
            color: Colors.white,
          ),
        )));
  }

  Widget buildBook(Texts texts) {
    return ListView(
      children: [
        const SizedBox(
          height: 20.0,
        ),
       const Padding(
         padding: EdgeInsets.only(left: 10),
         child: Text('Тоҷикӣ:', style: TextStyle(color: Colors.white),),
       ),
        _contentItem(texts.text!),
        const Padding(
            padding: EdgeInsets.only(left: 10),
           child: Text('Арабӣ:', style: TextStyle(color: Colors.white),),
         ),
        _contentArabic(texts.arabic!),
       const  Padding(
            padding: EdgeInsets.only(left: 10),
           child: Text('Тарҷума:', style: TextStyle(color: Colors.white),)),
        _contentTranslation(texts.translation!),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.texts!.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: const Text('Талаффузи дуо'),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.3, 0.7],
              ),
            ),
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: widget.texts!
                .map(
                  (Texts e) => Tab(text: e.id),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          children: widget.texts!
              .map((e) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [gradientStartColor, gradientEndColor],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.3, 0.7],
                      ),
                    ),
                    child: Builder(builder: (context) {
                      return buildBook(e);
                    }),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
