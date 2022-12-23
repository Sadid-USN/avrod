import 'package:avrod/widgets/support_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/colors/colors.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({
    Key? key,
  }) : super(key: key);
  static String routNaem = '/supportScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 201, 177, 150),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 3.0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        backgroundColor: appBabgColor,
        title: Text(
          'support'.tr,
          style: const TextStyle(
            fontSize: 18,
            color: titleColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: whiteColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 16,
            ),
            SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2 * 0.6,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: listCard.length,
                    itemBuilder: (context, index) {
                      return SupportCard(
                        initials: listCard[index].initials,
                        cardNumbers: listCard[index].cardNumbers,
                        icon: listCard[index].icon,
                        gradient: listCard[index].gradient,
                      );
                    }),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Расули  Аллоҳ (ﷺ) фармудаанд: «Аллоҳ (ҳамеша) ёвари бандааш аст, модоме ки банда ба бародараш кӯмак медиҳад». Аҳмад (2/202), Муслим (2699), Абу Довуд (4946), Тирмизӣ (1930), ан-Насоӣ дар Сунанул-Кубро (7284, 7285),\n\nАз Абуҳурайра ривоят аст, ки Расули Аллоҳ (ﷺ) фармуд: «Чун инсон мемирад, (ҳама) аъмоли ӯ қатъ мегардад ба ҷуз се чиз: садақаи ҷория, донише, ки (дигарон) аз он истифода мекунанд ё фарзандони солеҳе, ки ба сӯи Аллоҳ рӯй оварда дар ҳақи ӯ дуо мекунанд". Ин ҳадисро Аҳмад (2/372), Бухорӣ дар “Адабул-муфрад” (38), Муслим (1631), Абу Довуд (2880), Тирмизӣ (1376) ривоят кардаанд.\n\nАз Абу Кабшӣ Умар ибни Саъди Анмарӣ  ривоят аст, ки аз Расули Худо (ﷺ)  шунид, ки мефармуд: «Оиди се аъмол (ба шумо дар шаъни он) савганд мехӯрам, ба шумо сухан мекунам, шумо онро ҳифз кунед!  (Савганд мехӯрам, ки) садақа моли бандаи (Аллоҳ-ро) кам намекунад ва агар ба банда (Аллоҳ) ситам карда шавад ва ӯ сабр кунад, ҳатман Худованд иззати ӯро афзун мекунад ва агар бандаи (Аллоҳ) дарҳои пурсишро ба худ кушояд, ҳатман Худованд дарҳои фақрро назди рӯяш боз мекунад! Ривояти Аҳмад (4/231) Тирмизӣ (2325), ва Ибни Моҷа (4228)',
                style: GoogleFonts.ptSerif(
                    color: Colors.grey[800],
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
