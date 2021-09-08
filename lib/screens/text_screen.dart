import 'package:animate_icons/animate_icons.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avrod/colors/colors.dart';
import 'package:avrod/data/book_class.dart';
import 'package:avrod/data/book_map.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class TextScreen extends StatefulWidget {
  final List<Texts>? texts;
  final Chapter? chapter;

  const TextScreen({Key? key, this.texts, this.chapter}) : super(key: key);

  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  AnimateIconController controller = AnimateIconController();
  @override
  void initState() {
    super.initState();
    controller = AnimateIconController();
  }

  Widget _contentItem(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimateIcons(
          startIcon: Icons.copy,
          endIcon: Icons.check,
          controller: controller,
          size: 35.0,
          onStartIconPress: () {
            FlutterClipboard.copy(text);

            return true;
          },
          onEndIconPress: () {
            return false;
          },
          duration: const Duration(milliseconds: 500),
          startIconColor: Colors.white,
          endIconColor: Colors.white,
          clockwise: false,
        ),

    

        Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: SelectableText(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
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
                    colors: [Colors.white24, Colors.white38],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            padding: const EdgeInsets.all(30.0),
            child: SelectableText(
              arabic,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: ArabicFonts.Reem_Kufi,
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
            child: SelectableText(
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
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(
          height: 20.0,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Тоҷики:',
            style: TextStyle(color: Colors.white),
          ),
        ),
        _contentItem(texts.text!),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Араби:',
            style: TextStyle(color: Colors.white),
          ),
        ),
        _contentArabic(texts.arabic!),
        const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Тарҷума:',
              style: TextStyle(color: Colors.white),
            )),
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
              .map(
                (e) => Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [gradientStartColor, gradientEndColor],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.3, 0.7])),
                  child: Builder(builder: (context) {
                    return buildBook(e);
                  }),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
