import 'package:avrod/controller/chaptercontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import '../widgets/path_of_images.dart';
import 'chapter_screen.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ChapterController controller = Get.put(ChapterController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GetBuilder<ChapterController>(
        builder: (_) => AnimationLimiter(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1 / 1.3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              crossAxisCount: 3,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.bookFromFB?.length ?? 0,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 400),
                      columnCount: controller.bookFromFB!.length,
                      child: FlipAnimation(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                              () => ChapterScreen(
                                indexChapter: index,
                                chapters:
                                    controller.bookFromFB![index].chapters!,
                              ),
                            );
                          },
                          child: Image.asset(
                            images[index].pathImages,
                          height: 110,
                            width: 110,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      controller.bookFromFB?[index].name!.tr ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.blueGrey[800],
                          fontSize: 10,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
