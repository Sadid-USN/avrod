import 'package:avrod/screens/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:avrod/controller/text_screen_controller.dart';
import '../constant/colors/colors.dart';

class TextScreen extends StatelessWidget {
  final String? titleAbbar;
  final int? textsIndex;
  final int? chapterID;

  final List<dynamic>? texts;

  const TextScreen({
    Key? key,
    this.titleAbbar,
    this.textsIndex,
    this.texts,
    this.chapterID,
  }) : super(key: key);

  static String routName = '/textScreen';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TextScreenController>(
        init: TextScreenController(),
        builder: (controller) => DefaultTabController(
              length: texts!.length,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0.0,
                  backgroundColor: Theme.of(context).primaryColor,
                  title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            '$chapterID',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: listTitleColor,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            titleAbbar!,
                            style: TextStyle(
                                color: listTitleColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      controller.audioPlayer.stop();

                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  bottom: TabBar(
                    indicatorColor: Colors.white,
                    isScrollable: true,
                    tabs: texts!.map((e) => Tab(text: e['id'])).toList(),
                  ),
                ),
                body: TabBarView(
                  children: texts!
                      .map(
                        (e) => Column(
                          children: [
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width,
                            //   child: ColoredBox(
                            //     color: bgColor,
                            //     child: Text(
                            //       chapterID.toString(),
                            //       maxLines: 2,
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //         fontSize: 12,
                            //         overflow: TextOverflow.ellipsis,
                            //         fontWeight: FontWeight.w600,
                            //         color: listTitleColor,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: ColoredBox(
                                color: bgColor,
                                child: Builder(builder: (context) {
                                  return controller.buildBook(
                                    e,
                                    texts!.indexOf(e),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
                bottomSheet: ColoredBox(
                  color: bgColor,
                  child: Audiplayer(
                    texts: texts,
                    titleAbbar: titleAbbar,
                  ),
                ),
              ),
            ));
  }
}
