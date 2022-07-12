import 'dart:io';

import 'package:animate_icons/animate_icons.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:clipboard/clipboard.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import '../constant/colors/colors.dart';
import '../style/my_text_style.dart';

class TextScreen extends StatefulWidget {
  final String titleAbbar;

  final int? textsIndex;

  final List<dynamic>? texts;

  const TextScreen({
    Key? key,
    this.textsIndex,
    this.texts,
    required this.titleAbbar,
  }) : super(key: key);
  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  AnimateIconController _controller = AnimateIconController();
  AnimateIconController _buttonController = AnimateIconController();
  Duration duration = const Duration();
  Duration position = const Duration();
  double sliderPosition = 0.0;
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

  bool isPlaying = false;
  int currentIndex = 0;
  void stopPlaying(String url) async {
    if (isPlaying) {
      var reslult = await audioPlayer.pause();
      if (reslult == 1) {
        setState(() {
          isPlaying = false;
          audioPlayer.stop();
        });
      }
    }
  }

  playSound(String url) async {
    if (isPlaying) {
      var result = await audioPlayer.pause();

      if (result == 1) {
        setState(() {
          isPlaying = false;
        });
      }
    } else if (!isPlaying) {
      var result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = true;
        });
      }
    }
    // audioPlayer.onPlayerCompletion.listen((event) {
    //   setState(() {
    // duration = const Duration(seconds: 0);
    //     isPlaying = false;
    //   });
    // });
    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  void seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }

  Widget buildBook(
    var text,
    int index,
  ) {
    currentIndex = index;
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ContetAllTexts(
          text: text['text'],
          arabic: text['arabic'],
          translation: text['translation'],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller = AnimateIconController();
    _buttonController = AnimateIconController();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.texts![0]);
    return DefaultTabController(
      length: widget.texts!.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Theme.of(context).primaryColor,
          title: SizedBox(
            height: 20,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  widget.titleAbbar,
                  style: TextStyle(
                      color: listTitleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                )),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          bottom: TabBar(
            indicatorColor: Colors.white,
            isScrollable: true,
            tabs: widget.texts!.map((e) => Tab(text: e['id'])).toList(),
          ),
        ),
        body: TabBarView(
          children: widget.texts!
              .map(
                (e) => Container(
                  color: bgColor,
                  child: Builder(builder: (context) {
                    return buildBook(
                      e,
                      widget.texts!.indexOf(e),
                    );
                  }),
                ),
              )
              .toList(),
        ),
        bottomSheet: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 5),
          height: Platform.isIOS ? 70 : 60,
          decoration: const BoxDecoration(
            color: audiplayerColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.black87,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0),
            ],
          ),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AnimateIcons(
                startIcon: Icons.play_circle,
                endIcon: Icons.pause,
                controller: _buttonController,
                size: 30.0,
                onStartIconPress: () {
                  playSound(widget.texts![currentIndex]['url']);

                  return true;
                },
                onEndIconPress: () {
                  playSound(widget.texts![currentIndex]['url']);
                  return true;
                },
                duration: const Duration(milliseconds: 250),
                startIconColor: Colors.white,
                endIconColor: Colors.white,
                clockwise: false,
              ),
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 180.0,
                      child: Slider(
                        onChanged: (double newPosition) {
                          setState(() {
                            seekAudio(Duration(seconds: newPosition.round()));
                          });
                        },
                        onChangeEnd: ((value) {}),
                        activeColor: Colors.white,
                        inactiveColor: Colors.blueGrey,
                        min: 0.0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      position.toString().split('.').first,
                      style: const TextStyle(fontSize: 10, color: Colors.white),
                    )),
                    AnimateIcons(
                      startIcon: Icons.copy,
                      endIcon: Icons.check_circle_outline,
                      controller: _controller,
                      size: 25.0,
                      onStartIconPress: () {
                        if (Platform.isIOS) {
                          FlutterClipboard.copy(
                              '**${widget.titleAbbar}**\n\nТалаффуз:\n${widget.texts![currentIndex]['text']}\n\nАраби:\n${widget.texts![currentIndex]['arabic']}\n\nТарҷума:\n${widget.texts![currentIndex]['translation']}\n\nСадо 🎵:\n${widget.texts![currentIndex]['url']}\n\nБарномаи *Avrod* дар App Store\n👇👇👇👇\nhttps://apple.co/3GNRT3D');
                        } else {
                          FlutterClipboard.copy(
                              '**${widget.titleAbbar}**\n\nТалаффуз:\n${widget.texts![currentIndex]['text']}\n\nАраби:\n${widget.texts![currentIndex]['arabic']}\n\nТарҷума:\n${widget.texts![currentIndex]['translation']}\n\nСадо 🎵:\n${widget.texts![currentIndex]['url']}\n\nБарномаи *Avrod* дар Google Play\n👇👇👇👇\nhttps://bit.ly/3mdiwFw');
                        }

                        return true;
                      },
                      onEndIconPress: () {
                        return true;
                      },
                      duration: const Duration(milliseconds: 250),
                      startIconColor: Colors.white,
                      endIconColor: Colors.white,
                      clockwise: false,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Platform.isIOS) {
                          Share.share(
                              '**${widget.titleAbbar}**\n\nТалаффуз:\n${widget.texts![currentIndex]['text']}\n\nАраби:\n${widget.texts![currentIndex]['arabic']}\n\nТарҷума:\n${widget.texts![currentIndex]['translation']}\n\nAudio 🎵:\n${widget.texts![currentIndex]['url']}\n\nБарномаи *Avrod* дар App Store\n👇👇👇👇\nhttps://apple.co/3GNRT3D');
                        } else {
                          Share.share(
                              '**${widget.titleAbbar}**\n\nТалаффуз:\n${widget.texts![currentIndex]['text']}\n\nАраби:\n${widget.texts![currentIndex]['arabic']}\n\nТарҷума:\n${widget.texts![currentIndex]['translation']}\n\nAudio 🎵:\n${widget.texts![currentIndex]['url']}\n\nБарномаи *Avrod* дар Google Play\n👇👇👇👇\nhttps://bit.ly/3mdiwFw');
                        }
                      },
                      child: const Icon(Icons.share,
                          size: 25.0, color: Colors.white),
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContetAllTexts extends StatefulWidget {
  final String text, arabic, translation;

  final int? index;
  const ContetAllTexts({
    Key? key,
    this.index,
    required this.text,
    required this.translation,
    required this.arabic,
  }) : super(key: key);

  @override
  State<ContetAllTexts> createState() => _ContetAllTextsState();
}

class _ContetAllTextsState extends State<ContetAllTexts> {
  double _fontSize = 16.0;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        // ignore: sized_box_for_whitespace
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              child: Slider(
                activeColor: Colors.white,
                inactiveColor: Colors.blueGrey,
                value: _fontSize,
                label: _fontSize.round().toString(),
                onChanged: (double newSize) {
                  setState(() {
                    _fontSize = newSize;
                  });
                },
                max: 25.0,
                min: 16.0,
              ),
            ),
            ExpandablePanel(
              header: Text(
                "Талаффуз:",
                textAlign: TextAlign.start,
                style: expandableTextStyle,
              ),
              collapsed: SelectableText(
                widget.text,
                style: TextStyle(
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.w600,
                  fontSize: _fontSize,
                  color: listTitleColor,
                ),
              ),
              expanded: SelectableText(
                widget.text,
                maxLines: 2,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Colors.blueGrey,
                    overflow: TextOverflow.ellipsis),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(right: 30, left: 30, bottom: 20),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0)
                ],
                gradient: LinearGradient(
                    colors: [bgColor, bgColor],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: ExpandablePanel(
                header: const Text(''),
                collapsed: Center(
                  child: SelectableText(
                    widget.arabic,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.amiri(
                      textBaseline: TextBaseline.ideographic,
                      wordSpacing: 0.6,
                      color: listTitleColor,
                      fontSize: _fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                expanded: SelectableText(
                  widget.arabic,
                  maxLines: 1,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.amaticSc(
                    textBaseline: TextBaseline.ideographic,
                    wordSpacing: 0.5,
                    color: Colors.blueGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    textStyle: const TextStyle(
                        letterSpacing: 0.3, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: ExpandablePanel(
                    header: Text(
                      "Тарҷума:",
                      textAlign: TextAlign.start,
                      style: expandableTextStyle,
                    ),
                    collapsed: SelectableText(
                      widget.translation,
                      style: TextStyle(
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w600,
                        fontSize: _fontSize,
                        color: listTitleColor,
                      ),
                    ),
                    expanded: SelectableText(
                      widget.translation,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: Colors.blueGrey,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                )),
            const SizedBox(
              height: 80,
            )
          ],
        ),
      ),
    );
  }
}



// import 'package:animate_icons/animate_icons.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:avrod/colors/gradient_class.dart';
// import 'package:avrod/data/book_map.dart';
// import 'package:avrod/models/scrolling_text.dart';
// import 'package:avrod/style/my_text_style.dart';
// import 'package:clay_containers/widgets/clay_container.dart';
// import 'package:clipboard/clipboard.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:share/share.dart';
// import 'package:sizer/sizer.dart';

// class TextScreen extends StatefulWidget {
//   final List<Texts>? texts;
//   final Chapter? chapter;

//   const TextScreen({
//     Key? key,
//     this.texts,
//     this.chapter,
//   }) : super(key: key);

//   @override
//   _TextScreenState createState() => _TextScreenState();
// }

// class _TextScreenState extends State<TextScreen> {
//   int currentIndex = 0;

//   AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

//   bool isPlaying = false;

//   void stopPlaying(String url) async {
//     if (isPlaying) {
//       var reslult = await audioPlayer.pause();
//       if (reslult == 1) {
//         setState(() {
//           isPlaying = false;
//         });
//       }
//     }
//   }

//   void playSound(String url) async {
//     if (isPlaying) {
//       var result = await audioPlayer.pause();

//       if (result == 1) {
//         setState(() {
//           isPlaying = false;
//         });
//       }
//     } else if (!isPlaying) {
//       var result = await audioPlayer.play(url);
//       if (result == 1) {
//         setState(() {
//           isPlaying = true;
//         });
//       }
//     }
//     audioPlayer.onDurationChanged.listen((event) {
//       setState(() {
//         duration = event;
//       });
//     });
//     audioPlayer.onAudioPositionChanged.listen((event) {
//       setState(() {
//         position = event;
//       });
//     });
//   }

//   void seekAudio(Duration durationToSeek) {
//     audioPlayer.seek(durationToSeek);
//   }

//   double _fontSize = 16.sp;
//   String? creepingLine;
//   IconData btnIcon = Icons.play_arrow;

//   AnimateIconController _controller = AnimateIconController();
//   AnimateIconController _buttonController = AnimateIconController();
//   Duration duration = const Duration();
//   Duration position = const Duration();
//   double sliderPosition = 0.0;

//   @override
//   void dispose() {
//     _controller = AnimateIconController();
//     _buttonController = AnimateIconController();
//     audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     _controller = AnimateIconController();

//     super.initState();
//   }

//   Color clayColor = Colors.green.shade600;

//   Widget _contenAllTexts(
//     String text,
//     String arabic,
//     String translation,
//     String url,
//   ) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Slider(
//           activeColor: Colors.white,
//           inactiveColor: Colors.blueGrey,
//           value: _fontSize,
//           onChanged: (double newSize) {
//             setState(() {
//               _fontSize = newSize;
//             });
//           },
//           max: 30.sp,
//           min: 16.sp,
//         ),
//         Container(
//             padding: const EdgeInsets.all(8),
//             child: Column(
//               children: [
//                 ExpandablePanel(
//                   header: Text(
//                     "Талаффуз:",
//                     textAlign: TextAlign.start,
//                     style: expandableTextStyle,
//                   ),
//                   collapsed: SelectableText(
//                     text,
//                     style: TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: _fontSize,
//                       color: Colors.white,
//                     ),
//                   ),
//                   expanded: SelectableText(
//                     text,
//                     maxLines: 1,
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 14,
//                         color: Colors.white,
//                         overflow: TextOverflow.fade),
//                   ),
//                 ),
//               ],
//             )),
//         Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Column(
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                     boxShadow: [
//                       BoxShadow(
//                           color: Colors.black26,
//                           offset: Offset(0.0, 2.0),
//                           blurRadius: 6.0)
//                     ],
//                     gradient: LinearGradient(
//                         colors: [Colors.white24, Colors.white38],
//                         begin: Alignment.centerLeft,
//                         end: Alignment.centerRight),
//                     borderRadius: BorderRadius.all(Radius.circular(10.0))),
//                 padding: const EdgeInsets.all(40),
//                 child: ExpandablePanel(
//                   header: const Text(''),
//                   collapsed: SelectableText(
//                     arabic,
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.amiri(
//                       textBaseline: TextBaseline.ideographic,
//                       wordSpacing: 0.5,
//                       color: Colors.white,
//                       fontSize: _fontSize,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   expanded: SelectableText(
//                     arabic,
//                     maxLines: 1,
//                     textAlign: TextAlign.justify,
//                     style: GoogleFonts.amaticSc(
//                       textBaseline: TextBaseline.ideographic,
//                       wordSpacing: 0.5,
//                       color: Colors.white,
//                       fontSize: _fontSize,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Container(
//             padding: const EdgeInsets.all(8),
//             child: Center(
//               child: ExpandablePanel(
//                 header: Text(
//                   "Тарҷума:",
//                   textAlign: TextAlign.start,
//                   style: expandableTextStyle,
//                 ),
//                 collapsed: SelectableText(
//                   translation,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: _fontSize,
//                     color: Colors.white,
//                   ),
//                 ),
//                 expanded: SelectableText(
//                   translation,
//                   maxLines: 1,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 14,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             )),
//         const SizedBox(
//           height: 80,
//         )
//       ],
//     );
//   }

//   Widget buildBook(
//     Texts text,
//     int index,
//   ) {
//     currentIndex = index;
//     return ListView(
//       physics: const BouncingScrollPhysics(),
//       children: [
//         _contenAllTexts(text.text!, text.arabic!, text.translation!, text.url!),
//       ],
//     );
//   }

//   final GlobalKey _key = GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: widget.texts!.length,
//       child: Scaffold(
//         backgroundColor: Colors.green,
//         bottomSheet: ClayContainer(
//           height: 60,
//           width: MediaQuery.of(context).size.width,
//           depth: 40,
//           color: Colors.green[500],
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               AnimateIcons(
//                 startIcon: Icons.play_circle,
//                 endIcon: Icons.pause,
//                 controller: _buttonController,
//                 size: 40.0,
//                 onStartIconPress: () {
//                   playSound(widget.texts![currentIndex].url!);

//                   return true;
//                 },
//                 onEndIconPress: () {
//                   return true;
//                 },
//                 duration: const Duration(milliseconds: 250),
//                 startIconColor: Colors.white,
//                 endIconColor: Colors.white,
//                 clockwise: false,
//               ),
//               Expanded(
//                 child: Row(
//                   children: [
//                     Slider(
//                         onChangeEnd: ((value) {
//                           seekAudio(Duration(seconds: value.toInt()));
//                         }),
//                         activeColor: Colors.white,
//                         inactiveColor: Colors.blueGrey,
//                         min: 0.0,
//                         max: duration.inSeconds.toDouble(),
//                         value: position.inSeconds.toDouble(),
//                         onChanged: (double newPosition) {
//                           setState(() {});
//                         }),
//                     Expanded(
//                         child: Text(
//                       position.toString().split('.').
//
//
// first,
//                       style: const TextStyle(fontSize: 10, color: Colors.white),
//                     )),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   AnimateIcons(
//                     startIcon: Icons.copy,
//                     endIcon: Icons.check_circle_outline,
//                     controller: _controller,
//                     size: 33.0,
//                     onStartIconPress: () {
//                       FlutterClipboard.copy(
//                           '**${widget.chapter?.name}*\n${widget.texts![0].text}\n☘️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️☘️\n\n${widget.texts![0].arabic}\n\n${widget.texts![0].translation}\n\n☘️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️☘️\n\nБарномаи *Avrod* дар Playsore\n👇👇👇👇\nhttps://play.google.com/store/apps/details?id=com.darulasar.avrod');

//                       return true;
//                     },
//                     onEndIconPress: () {
//                       return false;
//                     },
//                     duration: const Duration(milliseconds: 250),
//                     startIconColor: Colors.white,
//                     endIconColor: Colors.white,
//                     clockwise: false,
//                   ),
//                   IconButton(
//                       onPressed: () {
//                         Share.share(
//                             '*${widget.chapter?.name}*\n${widget.texts![0].text}\n☘️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️☘️\n\n${widget.texts![0].arabic}\n\n${widget.texts![0].translation}\n\n☘️⭐️⭐️⭐️⭐️⭐️⭐️⭐️⭐️☘️\n\nБарномаи *Avrod* дар Playsore\n👇👇👇👇\nhttps://play.google.com/store/apps/details?id=com.darulasar.avrod');
//                       },
//                       icon: const Icon(Icons.share,
//                           size: 33.0, color: Colors.white)),
//                   const SizedBox(
//                     width: 5,
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//         appBar: AppBar(
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.arrow_back_ios),
//           ),
//           elevation: 0.0,
//           title: Column(
//             children: [
//                ignore: sized_box_for_whitespace
//               Container(
//                 key: _key,
//                 padding: const EdgeInsets.only(top: 5),
//                 height: 40.0,
//                 child: ScrollingText(
//                   text: '${widget.chapter?.name}',
//                   textStyle: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           centerTitle: true,
//           flexibleSpace: Container(
//             decoration: favoriteGradient,
//           ),
// bottom: TabBar(
//   indicatorColor: Colors.white,
//   isScrollable: true,
//   tabs: widget.texts!.map((Texts e) => Tab(text: e.id)).toList(),
// ),
//         ),
//         body: TabBarView(
//           children: widget.texts!
//               .map(
//                 (e) => Container(
//                   decoration: favoriteGradient,
//                   child: Builder(builder: (context) {
//                     return buildBook(e, widget.texts!.indexOf(e));
//                   }),
//                 ),
//               )
//               .toList(),
//         ),
//       ),
//     );
//   }
// }


