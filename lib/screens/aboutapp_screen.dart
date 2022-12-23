import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/colors/colors.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({
    Key? key,
  }) : super(key: key);
  static String routNaem = '/aboutAppScree';
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
          'aboutapp'.tr,
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
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const Text(
                        '﷽',
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Color.fromARGB(255, 245, 255, 245)),
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text:
                                    'Ба номи Аллоҳи бахшояндаю бениҳоят меҳрубон, Ӯро барои неъматхои бешуморе, ки бар мо ато кардааст, ситоиш мекунем. Ҳама ситоиш аз они Ӯст! Ситоиши Аллоҳ, ки ҳарчи дар осмонҳову ҳар чӣ дар замин аст аз они Ӯст ва Ӯ ҳакиму доност! Дар ин барнома кучак мо қадри имкон зикрҳои гуногунро ҷойгир кардем, то ҳар мусалмон дар мурури ҳайёти хеш ба он муроҷиат карда тавонад. Пас аз таҳлили дақиқ бо кумаки Парвардигор дар барномаи Avrod танҳо дуоҳои саҳеҳи набави ҷамъовари карда масдари онро бо қадри имкон зери ҳар дуо ишора намудаем. Дар баъзе маврид исноди ҳадисро бо ду сабаб ишора накердем:\n1) Агар ҳадис аз аҳодиси саҳеҳайн бошад ва матни он алакай миёни мардум маъруф ва машҳур гашта бошад.\n2) Барои ихтисори навиштаҷоти асли китоб, чун ишораи масдари ҳадис ва баҳси исноди он аз мақосиди асосии нест, мақсади асоси дуоҳои саҳеҳи набавиро ба мардум бо роҳи осон таълим додан аст, аммо зикри ихтилофи олимон дар атрофи рови ва зикри истилоҳот эшон, хонандаро парокандаю парешон мекунад.\nИнчун таашккуру сипос ба ҳар нафареки барои пешрафти барнома кумаку саҳми худро гузоштааст, паёмбари Аллоҳ (ﷺ) гуфтааст: «Шукргузори накардааст Аллоҳро ҳарки мардумро шукргузори накунад».\n(Ривояти Ахмад).\nБа назардошти он ки банда ҳамеша эҳтиёҷ ба ислоҳу таҳлил ва иодаи назар аст, аз хонандаи азиз талабгори онем, ки агар хатогиеро дар матни китоб мушоҳида кардед, лутфан онро ба мо равон кунед, то аз паи ислоҳи он шавем, ва за боби такмил хатоҳоро бо шакли скриншот ба мо ирсол кунед, бариди электрони:',
                                style: GoogleFonts.ptSerif(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    const Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 2.0,
                                      color: Colors.black,
                                    ),
                                    const Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 8.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                )),
                            TextSpan(
                                text: ' ulamuyaman@gmail.com',
                                style: GoogleFonts.alice(
                                    color: Colors.blue[900],
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
