import 'package:animate_icons/animate_icons.dart';
import 'package:avrod/colors/gradient_class.dart';
import 'package:avrod/data/book_class.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

class TextScreen extends StatefulWidget {
  final List<Texts>? texts;
  final Chapter? chapter;

  const TextScreen({
    Key? key,
    this.texts,
    this.chapter,
  }) : super(key: key);

  @override
  _TextScreenState createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  String ? creepingLine;
   
  int? index;

  AnimateIconController _controller = AnimateIconController();

  // @override
  // void dispose() {
  //   _controller = AnimateIconController();
  //   super.dispose();
  // }

  @override
  void initState() {
    _controller = AnimateIconController();

    super.initState();
  }

  Widget _contenAllTexts(
    String text,
    String arabic,
    String translation,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Тоҷики:',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AnimateIcons(
              startIcon: Icons.copy,
              endIcon: Icons.check_circle_outline,
              controller: _controller,
              size: 35.0,
              onStartIconPress: () {
                FlutterClipboard.copy(
                    '*${widget.chapter?.name}*\n$text\n$arabic\n$translation\n☘️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️☘️\nБо воситаи барномаи *Avrod* насх шуд\n👇👇👇👇\nhttps://play.google.com/store/apps/details?id=com.darulasar.avrod');

                return true;
              },
              onEndIconPress: () {
                return false;
              },
              duration: const Duration(milliseconds: 250),
              startIconColor: Colors.white,
              endIconColor: Colors.white,
              clockwise: false,
            ),
            IconButton(
                onPressed: () {
                  Share.share(
                      'Таллафузи дуо\n$text\n$arabic\n$translation\nБо воситаи барномаи *Avrod* ирсол шуд.\n👇👇👇👇\nhttps://play.google.com/store/apps/details?id=com.darulasar.avrod');
                },
                icon: const Icon(Icons.share, size: 35.0, color: Colors.white))
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: SelectableText(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Араби:',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ],
                    gradient: LinearGradient(
                        colors: [Colors.white24, Colors.white38],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight),
                    borderRadius: BorderRadius.all(Radius.circular(6.0))),
                padding: const EdgeInsets.all(35),
                child: SelectableText(
                  arabic,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.amaticSc(
                    textBaseline: TextBaseline.ideographic,
                    wordSpacing: 0.5,
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Тарҷума:',
              style: TextStyle(color: Colors.white),
            )),
        Container(
            padding: const EdgeInsets.all(8),
            child: Center(
                child: SelectableText(
              translation,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                color: Colors.white,
              ),
            ))),
      ],
    );
  }

  Widget buildBook(
    Texts text,
  ) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        SizedBox(
          height: 2.h,
        ),
        _contenAllTexts(text.text!, text.arabic!, text.translation!),
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
          title: Column(
          
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                padding: const EdgeInsets.only(top: 5),
                height: 40.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Text('${widget.chapter?.name}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold))
                  ],
                ),
              ),
            ],
          ),
  
          centerTitle: true,
          flexibleSpace: Container(
            decoration: favoriteGradient,
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
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
                  decoration: favoriteGradient,
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

  // _updateProgress() {
  //   const oneSec = Duration(seconds: 1);
  //   Timer.periodic(oneSec, (Timer t) {
  //     setState(() {
  //       _progressLoading = 0.20;
  //       if (_progressLoading!.toStringAsFixed(1) == '1.00') {
  //         _loading = false;
  //         t.cancel();
  //         _progressLoading = 0.0;
  //         return;
  //       }
  //     });
  //   });
  // }
}
