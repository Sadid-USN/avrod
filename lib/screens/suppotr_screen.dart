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
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            // SafeArea(
            //   child: SizedBox(
            //     height: MediaQuery.of(context).size.height / 2 * 0.6,
            //     child: ListView.builder(
            //         physics: const BouncingScrollPhysics(),
            //         shrinkWrap: true,
            //         scrollDirection: Axis.horizontal,
            //         itemCount: listCard.length,
            //         itemBuilder: (context, index) {
            //           return SupportCard(
            //             initials: listCard[index].initials,
            //             cardNumbers: listCard[index].cardNumbers,
            //             icon: listCard[index].icon,
            //             gradient: listCard[index].gradient,
            //           );
            //         }),
            //   ),
            // ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                    text:
                        'Саҳми шумо барои рушди барнома. Кӯмаки шумо на танҳо ба таввасути мол, балки бо дуо ва нашри пайванди барномаи Avrod мебошад, бигзор Аллоҳи меҳрубон ҳамаи моро якояк аз зумраи парҳезгорону шитобандагони роҳи хайр қарор диҳад, ҳамчуноне ки дар китобаш ба мо хабар дода гуфтааст:\n',
                    style: GoogleFonts.ptSerif(
                        color: const Color.fromARGB(255, 75, 65, 65),
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text:
                        '«Ва ба сӯйи омурзиши Парвардигоратон ва биҳишт бишитобед, ки паҳно-и он [ба андозаи] осмонҳо ва замин аст [ва] барои парҳезгорон муҳайё шудааст».\n',
                    style: GoogleFonts.ptSerif(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text:
                        '(Оли Имрон 133)\nИнчунин Аз Абуҳурайра ривоят аст, ки Расули Аллоҳ (ﷺ) фармуд: \n',
                    style: GoogleFonts.ptSerif(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text:
                        '«Чун инсон мемирад, (ҳама) аъмоли ӯ қатъ мегардад ба ҷуз се чиз: садақаи ҷория, донише, ки (дигарон) аз он истифода мекунанд ё фарзандони солеҳе, ки ба сӯи Аллоҳ рӯй оварда дар ҳақи ӯ дуо мекунанд.\n',
                    style: GoogleFonts.ptSerif(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Ҳамеша аз дастгирии шумо самимона миннатдорем!\n',
                    style: GoogleFonts.ptSerif(
                        color: Colors.grey[800],
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ])),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SelectableText(
                'Барои маълумоти пурра оиди куммаки моли, шумо метавонед бо мо тавассути бариди электрони муроҷиат кунед\nulamuyaman@gmail.com',
                style: GoogleFonts.ptSerif(
                    color: Colors.green[900],
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
