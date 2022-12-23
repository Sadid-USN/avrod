import 'package:animate_icons/animate_icons.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportCard extends StatelessWidget {
  final String cardNumbers;
  final String icon;
  final String initials;
  final LinearGradient? gradient;
  SupportCard({
    Key? key,
    required this.cardNumbers,
    required this.icon,
    required this.initials,
    this.gradient,
  }) : super(key: key);

  AnimateIconController animateIconController = AnimateIconController();
  @override
  Widget build(BuildContext context) {
    return FlipCard(
      fill: Fill.fillBack,
      direction: FlipDirection.HORIZONTAL,
      front: Container(
        width: MediaQuery.of(context).size.width / 2 * 1.9,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: const DecorationImage(
              opacity: 0.4,
              image: AssetImage('assets/icons/iconavrod.png'),
              fit: BoxFit.cover),
          gradient: gradient,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 2.0),
                blurRadius: 6.0)
          ],
        ),
        child: Stack(
          children: [
            const Positioned(
              right: 0.0,
              child: AvatarGlow(
                endRadius: 30.0,
                child: Material(
                  // Replace this child with your own
                  elevation: 8.0,
                  shape: CircleBorder(),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 10),
                  child: Image.asset(
                    icon,
                    height: 45,
                    width: 45,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SelectableText(
                      cardNumbers,
                      //
                      style: GoogleFonts.ptSerif(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600),
                    ),
                    AnimateIcons(
                      startIcon: Icons.copy,
                      endIcon: Icons.check_circle_outline,
                      controller: animateIconController,
                      size: 25.0,
                      onStartIconPress: () {
                        FlutterClipboard.copy(
                          cardNumbers,
                        );

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
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        initials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      const Text(
                        '/Avrod',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      //! BACK
      back: Container(
        width: MediaQuery.of(context).size.width / 2 * 1.9,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: const DecorationImage(
              opacity: 0.3,
              image: AssetImage('assets/icons/iconavrod.png'),
              fit: BoxFit.cover),
          gradient: gradient,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 2.0),
                blurRadius: 6.0)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ٱلَّذِینَ یَذۡكُرُونَ ٱللَّهَ قِیَـٰمࣰا وَقُعُودࣰا وَعَلَىٰ جُنُوبِهِمۡ وَیَتَفَكَّرُونَ فِی خَلۡقِ ٱلسَّمَـٰوَ ٰ⁠تِ وَٱلۡأَرۡضِ رَبَّنَا مَا خَلَقۡتَ هَـٰذَا بَـٰطِلࣰا سُبۡحَـٰنَكَ فَقِنَا عَذَابَ ٱلنَّارِ',
                textAlign: TextAlign.center,
                style: GoogleFonts.amiri(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Avrod',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<SupportCard> listCard = [
  SupportCard(
    cardNumbers: '4274   3200   7851   2616',
    initials: 'Sadid Idibekov',
    icon: 'assets/libraryimsges/icon_sber.png',
    gradient: LinearGradient(colors: [
      Colors.blue.shade900,
      Colors.cyan.shade600,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
  ),
  SupportCard(
    cardNumbers: '2202   20032   4079  2906',
    initials: 'Sadid Idibekov',
    icon: 'assets/libraryimsges/icon_sber.png',
    gradient: LinearGradient(colors: [
      Colors.indigo.shade600,
      Colors.blue.shade300,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
  ),
  SupportCard(
    cardNumbers: 'sadididibekov@gmail.com',
    initials: 'Sadid Idibekov',
    icon: 'assets/libraryimsges/paypal.png',
    gradient: LinearGradient(colors: [
      Colors.blue.shade900,
      Colors.blue,
    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
  ),
];
