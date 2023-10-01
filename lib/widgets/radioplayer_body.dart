import 'dart:math';

import 'package:animate_icons/animate_icons.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:avrod/core/addbunner_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../controller/audio_controller.dart';
import '../screens/text_screen.dart';

class RadioPlayerBody extends StatefulWidget {
  const RadioPlayerBody({
    Key? key,
  }) : super(key: key);

  @override
  State<RadioPlayerBody> createState() => _RadioPlayerBodyState();
}

class _RadioPlayerBodyState extends State<RadioPlayerBody> {
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
    final PageController pageController = PageController();

    return AnimationLimiter(
      child: GetBuilder<AudioController>(
        builder: (audioController) => Column(
          children: [
            bannerAdHelper.isBannerAd
                ? SizedBox(
                    height: bannerAdHelper.bannerAd.size.height.toDouble(),
                    width: bannerAdHelper.bannerAd.size.width.toDouble(),
                    child: AdWidget(ad: bannerAdHelper.bannerAd),
                  )
                : const SizedBox(),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2 * 1.5,
              child: PageView.builder(
                controller: pageController,
                itemCount: audioController.listInfo.length,
                onPageChanged: (value) {
                  audioController.audioPlayer.stop();
                },
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 400),
                    columnCount: audioController.listInfo.length,
                    child: ScaleAnimation(
                      child: AudiPlyerCard(
                        index: index,
                        audioUrl: audioController.listInfo[index].audioUrl,
                        image: audioController.listInfo[index].image,
                        name: audioController.listInfo[index].name,
                        subtitle: audioController.listInfo[index].subtitle,
                        pageController: pageController,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AudiPlyerCard extends StatelessWidget {
  final String audioUrl;
  final String image;
  final String name;
  final String subtitle;
  final PageController pageController;
  final int index;

  const AudiPlyerCard({
    Key? key,
    required this.audioUrl,
    required this.image,
    required this.name,
    required this.subtitle,
    required this.pageController,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AudioController controller = Get.put(AudioController());
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),

        Center(
            child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              height: MediaQuery.sizeOf(context).height / 3,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage(
                    "assets/icons/iconavrod.png",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            controller.audioPlayer.playing
                ? Positioned(
                    left: 110,
                    bottom: 70,
                    child: SizedBox(
                        height: 40, width: 200, child: _MusicVisualizer()),
                  )
                : const SizedBox()
          ],
        )),

        const Spacer(),
        // GetBuilder<AudioController>(
        //   builder: (controller) =>
        // Container(
        //     alignment: Alignment.center,
        //     height: MediaQuery.sizeOf(context).height / 2,
        //     margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        //     decoration: BoxDecoration(
        //       image: DecorationImage(
        //           image: AssetImage(controller.listInfo[index].image),
        //           fit: BoxFit.cover),
        //       borderRadius: BorderRadius.circular(8),
        //     ),

        //   ),
        // ),

        Container(
          height: 200,
          margin: const EdgeInsets.only(
            top: 16,
          ),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment(-0.2, -0.5),
              stops: [-1.0, 0.1, 0.1, 0.2],
              colors: [
                Color.fromARGB(255, 72, 69, 66),
                Color.fromARGB(255, 72, 69, 66),
                Color.fromARGB(255, 72, 69, 66),
                Color.fromARGB(255, 72, 69, 66),
              ],
              tileMode: TileMode.clamp,
            ),
            color: Color.fromARGB(255, 92, 109, 110),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                      ),
                      child: Text(
                        "$name  $subtitle",
                        style: const TextStyle(
                            height: 1.5,
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    subtitle: index == 0
                        ? const SizedBox()
                        : GetBuilder<AudioController>(
                            builder: (controller) {
                              return StreamBuilder<PositioneData>(
                                  stream: controller.positioneDataStream,
                                  builder: (context, snapshot) {
                                    final positionData = snapshot.data;

                                    return ProgressBar(
                                      barHeight: 4,
                                      baseBarColor: Colors.grey.shade400,
                                      bufferedBarColor: Colors.white,
                                      progressBarColor: Colors.blueGrey,
                                      thumbColor: Colors.blueGrey,
                                      thumbRadius: 6,
                                      timeLabelTextStyle: const TextStyle(
                                          height: 1.2,
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      progress: positionData?.positione ??
                                          Duration.zero,
                                      buffered:
                                          positionData?.bufferedPosition ??
                                              Duration.zero,
                                      total: positionData?.duration ??
                                          Duration.zero,
                                      onSeek: controller.audioPlayer.seek,
                                    );
                                  });
                            },
                          ),
                    // trailing: Container(
                    //   decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     border: Border.all(
                    //       color: Colors.white,
                    //       width: 2.0,
                    //     ),
                    //   ),
                    //   child: CircleAvatar(
                    //     radius: 25,
                    //     backgroundImage: NetworkImage(image),
                    //   ),
                    // ),
                  ),
                  NextPreviousButton(
                    pageController: pageController,
                    index: index,
                  ),
                ],
              ),
              index == 0 ? const SizedBox() : const RefreshButton(),
            ],
          ),
        ),
        // const SizedBox(
        //   height: 25,
        // ),
      ],
    );
  }
}

class RefreshButton extends StatelessWidget {
  const RefreshButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      child: GetBuilder<AudioController>(
        builder: (controller) {
          return AnimateIcons(
              duration: const Duration(milliseconds: 250),
              startIconColor: Colors.white,
              endIconColor: Colors.white,
              size: 30,
              startIcon: Icons.refresh,
              endIcon: Icons.refresh,
              onStartIconPress: () {
                controller.refreshAudioUrls();
                controller.audioPlayer.stop();

                return true;
              },
              onEndIconPress: () {
                controller.refreshAudioUrls();
                controller.audioPlayer.stop();
                return true;
              },
              controller: controller.refreshController);
        },
      ),
    );
  }
}

class NextPreviousButton extends StatelessWidget {
  final PageController pageController;
  final int index;

  const NextPreviousButton({
    Key? key,
    required this.pageController,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AudioController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              if (pageController.page != 0) {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              } else {
                pageController.jumpToPage((pageController.page!.toInt() - 1) %
                    controller.listInfo.length);
              }
              controller.audioPlayer.stop();
            },
            icon: const Icon(
              Icons.skip_previous,
              size: 40,
              color: Colors.white,
            ),
          ),
          GetBuilder<AudioController>(
            builder: (controller) => AnimateIcons(
              startIcon: controller.listInfo[index].audioUrl !=
                      controller.listInfo[index].audioUrl
                  ? Icons.pause_circle
                  : Icons.play_circle,
              endIcon: controller.listInfo[index].audioUrl !=
                      controller.listInfo[index].audioUrl
                  ? Icons.play_circle
                  : Icons.pause_circle,
              controller: controller.buttonController,
              size: 65.0,
              onStartIconPress: () {
                controller.playAudio(
                  url: controller.listInfo[index].audioUrl,
                  album: controller.listInfo[index].name,
                  id: controller.listInfo[index].id,
                  title: controller.listInfo[index].subtitle,
                  imgUrl: controller.listInfo[index].image,
                );

                return true;
              },
              onEndIconPress: () {
                controller.audioPlayer.stop();

                return true;
              },
              duration: const Duration(milliseconds: 250),
              startIconColor: Colors.white,
              endIconColor: Colors.white,
              clockwise: false,
            ),
          ),
          GetBuilder<AudioController>(
            builder: (ccontroller) => IconButton(
              onPressed: () {
                if (pageController.page != controller.listInfo.length - 1) {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                } else {
                  pageController.jumpToPage((pageController.page!.toInt() + 1) %
                      controller.listInfo.length);
                }

                controller.audioPlayer.stop();
              },
              icon: const Icon(
                Icons.skip_next,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoData {
  String id;
  String image;
  String audioUrl;
  String name;
  String subtitle;
  InfoData(
      {required this.id,
      required this.image,
      required this.name,
      required this.subtitle,
      required this.audioUrl});
}

class _MusicVisualizer extends StatelessWidget {
  List<Color> colors = [Colors.white, Colors.white, Colors.white, Colors.white];
  List<int> duration = [900, 700, 600, 800, 500];
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List<Widget>.generate(
          8,
          (index) => VisualComponent(
                duration: duration[index % 5],
                color: colors[index % 4],
              )),
    );
  }
}

class VisualComponent extends StatefulWidget {
  final int duration;
  final Color color;
  const VisualComponent({
    Key? key,
    required this.duration,
    required this.color,
  }) : super(key: key);

  @override
  State<VisualComponent> createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController musicVisualizationController;

  @override
  void dispose() {
    musicVisualizationController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final randomCurve = _getRandomCurve();
    musicVisualizationController = AnimationController(
        duration: Duration(
          milliseconds: widget.duration,
        ),
        vsync: this);
    final curveAnimation = CurvedAnimation(
        parent: musicVisualizationController, curve: randomCurve);
    animation = Tween<double>(begin: 0, end: 100).animate(curveAnimation)
      ..addListener(() {
        setState(() {});
      });
    musicVisualizationController.repeat(reverse: true);
  }

  Curve _getRandomCurve() {
    final List<Curve> curves = [
      Curves.easeInCubic,
      Curves.easeInOutCirc,
      Curves.easeInOutQuart,
      Curves.easeOutExpo,
    ];

    final random = Random();
    final randomIndex = random.nextInt(curves.length);
    return curves[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: animation.value,
      width: 4,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
