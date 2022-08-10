import 'package:avrod/constant/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constant/colors/colors.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'aboutapp'.tr,
          style: TextStyle(
            fontSize: 18,
            color: Colors.blueGrey.shade800,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Get.offNamed(AppRouteNames.homepage);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: listTitleColor,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.orange.withOpacity(0.2), BlendMode.dstATop),
              image: const AssetImage('assets/images/iconavrod.png'),
              fit: BoxFit.cover),
          // borderRadius: BorderRadius.all(
          //   Radius.circular(16.0),
          // ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const Text(
                  '﷽',
                  style: TextStyle(
                      fontSize: 40.0, color: Color.fromARGB(255, 13, 72, 16)),
                ),
                RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(children: [
                      TextSpan(
                          text:
                              'Ба номи Аллоҳи бахшояндаю бениҳоят меҳрубон, Ӯро барои неъматхои бешуморе, ки бар мо ато кардааст, ситоиш мекунем. Ҳама ситоиш аз они Ӯст! Ситоиши Аллоҳ, ки ҳарчи дар осмонҳову ҳар чӣ дар замин аст аз они Ӯст ва Ӯ ҳакиму доност! Дар ин барнома кучак мо қадри имкон зикрҳои гуногунро ҷойгир кардем, то ҳар мусалмон дар мурури ҳайёти хеш ба он муроҷиат карда тавонад. Пас аз таҳлили дақиқ бо кумаки Парвардигор дар барномаи Avrod танҳо дуоҳои саҳеҳи набави ҷамъовари карда масдари онро зери ҳар дуо ишора намудаем',
                          style: GoogleFonts.ptSerif(
                              color: Colors.blueGrey[900],
                              fontSize: 18,
                              fontWeight: FontWeight.bold))
                    ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
