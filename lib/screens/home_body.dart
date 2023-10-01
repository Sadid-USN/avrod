import 'package:avrod/controller/chaptercontroller.dart';
import 'package:avrod/core/addbunner_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../widgets/path_of_images.dart';
import 'chapter_screen.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  BannerAdHelper bannerAdHelper = BannerAdHelper();

  @override
  void initState() {
    super.initState();

    bannerAdHelper.initializeAdMob(
      onAdLoaded: (ad) {
        setState(() {
          bannerAdHelper.isBannerAd = true;
        });
      },
    );
  }

  @override
  void dispose() {
    bannerAdHelper.bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ChapterController controller = Get.put(ChapterController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GetBuilder<ChapterController>(
        builder: (_) => AnimationLimiter(
          child: SingleChildScrollView(
            child: Column(
              children: [
                bannerAdHelper.isBannerAd
                    ? SizedBox(
                        height: bannerAdHelper.bannerAd.size.height.toDouble(),
                        width: bannerAdHelper.bannerAd.size.width.toDouble(),
                        child: AdWidget(ad: bannerAdHelper.bannerAd),
                      )
                    : const SizedBox(),
                const SizedBox(height: 10,),
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2 * 1.6,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                        chapters: controller
                                            .bookFromFB![index].chapters!,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
