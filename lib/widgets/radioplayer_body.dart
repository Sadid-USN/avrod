import 'package:animate_icons/animate_icons.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import '../controller/audio_controller.dart';
import '../screens/text_screen.dart';

class RadioPlayerBody extends StatelessWidget {
  const RadioPlayerBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    return AnimationLimiter(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GetBuilder<AudioController>(
          builder: (audioController) => PageView.builder(
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GetBuilder<AudioController>(
          builder: (controller) => Container(
            height: MediaQuery.sizeOf(context).height / 2,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),

            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(controller.listInfo[index].image),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        Expanded(
          child: Container(
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
                pageController.jumpToPage(
                    (pageController.page!.toInt() - 1) % controller.listInfo.length);
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
