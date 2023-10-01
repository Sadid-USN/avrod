import 'package:avrod/controller/chaptercontroller.dart';
import 'package:avrod/core/addbunner_helper.dart';
import 'package:avrod/models/chapter_model.dart';
import 'package:avrod/screens/text_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:like_button/like_button.dart';

import '../constant/colors/colors.dart';
import '../constant/colors/gradient_class.dart';
import '../main.dart';
import '../models/book.dart';

class FavoriteChaptersScreen extends StatefulWidget {
  const FavoriteChaptersScreen({Key? key}) : super(key: key);

  static String routName = '/favoriteChaptersScreen';

  @override
  _FavoriteChaptersScreenState createState() => _FavoriteChaptersScreenState();
}

class _FavoriteChaptersScreenState extends State<FavoriteChaptersScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideAnimationController;
  late AnimationController _rotationAnimationController;
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

    _slideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _rotationAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    bannerAdHelper.bannerAd.dispose();
    _slideAnimationController.dispose();
    _rotationAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ChapterController controller = Get.put(ChapterController());
    final books = controller.bookFromFB!;

    return Scaffold(
      backgroundColor: bgColor,
      // appBar: AppBar(
      //   elevation: 3.0,
      //   backgroundColor: appBabgColor,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: Radius.circular(12),
      //       bottomRight: Radius.circular(12),
      //     ),
      //   ),
      //   leading: IconButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      //     icon: const Icon(Icons.arrow_back_ios),
      //   ),
      //   centerTitle: true,
      //   title: Text(
      //     'favorite'.tr,
      //     style: TextStyle(fontSize: 18, color: calendarAppbar),
      //   ),
      // ),
      body: Column(
        //  mainAxisAlignment: MainAxisAlignment.center,
        children: [
          bannerAdHelper.isBannerAd
              ? SizedBox(
                  height: bannerAdHelper.bannerAd.size.height.toDouble(),
                  width: bannerAdHelper.bannerAd.size.width.toDouble(),
                  child: AdWidget(ad: bannerAdHelper.bannerAd),
                )
              : const SizedBox(),
          const Spacer(),
          Container(
            decoration: favoriteGradient,
            child: ValueListenableBuilder(
              valueListenable: Hive.box(FAVORITES_BOX).listenable(),
              builder: (context, Box box, child) {
                List<ChaptersModel> chapters = [];
                for (Book book in books) {
                  chapters.addAll(book.chapters!);
                }
                final List<dynamic> likedChapterIds = box.keys.toList();

                final likedChapters = chapters
                    .where((ChaptersModel chapter) =>
                        likedChapterIds.contains(chapter.id))
                    .toList();
                return likedChapters.isNotEmpty
                    ? AnimationLimiter(
                        child: ListView.separated(
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: Colors.blueGrey[800],
                            );
                          },
                          scrollDirection: Axis.vertical,
                          padding: const EdgeInsets.only(top: 10.0),
                          physics: const BouncingScrollPhysics(),
                          itemCount: likedChapters.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 500),
                              columnCount: likedChapters.length,
                              child: ScaleAnimation(
                                child: Container(
                                  color: bgColor,
                                  padding: const EdgeInsets.all(5.0),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return TextScreen(
                                              chapterID:
                                                  likedChapters[index].id! + 1,
                                              texts: likedChapters[index].texts,
                                              titleAbbar:
                                                  likedChapters[index].name,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    trailing: CircleAvatar(
                                      backgroundColor: bgColor,
                                      child: LikeButton(
                                        onTap: (isLiked) async {
                                          controller.likesBox!
                                              .delete(likedChapters[index].id!);
                                          return !isLiked;
                                        },
                                        isLiked: controller.isChapterLiked(
                                            likedChapters[index].id!),
                                        size: 25,
                                        circleColor: const CircleColor(
                                          start: Color(0xffFF0000),
                                          end: Color(0xffFF0000),
                                        ),
                                        bubblesColor: const BubblesColor(
                                          dotPrimaryColor: Color(0xffffffff),
                                          dotSecondaryColor: Color(0xffBF40BF),
                                        ),
                                      ),
                                    ),
                                    title: Row(
                                      children: [
                                        SizedBox(
                                          height: 65,
                                          width: 65,
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                right: 0,
                                                bottom: 0,
                                                child: Text(
                                                  "${likedChapters[index].id! + 1}",
                                                  maxLines: 3,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    color: listTitleColor,
                                                  ),
                                                ),
                                              ),
                                              CachedNetworkImage(
                                                imageUrl: likedChapters[index]
                                                        .listimage ??
                                                    '',
                                                placeholder:
                                                    (context, imageProvider) {
                                                  return ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            90),
                                                    child: Image.asset(
                                                      'assets/icons/iconavrod.png',
                                                      height: 50,
                                                    ),
                                                  );
                                                },
                                                imageBuilder:
                                                    (context, imageProvider) {
                                                  return CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        imageProvider,
                                                  );
                                                },
                                                errorWidget:
                                                    (context, url, error) {
                                                  return const CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage: AssetImage(
                                                        'assets/images/noimage.png'),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Text(
                                            likedChapters[index].name ?? "null",
                                            maxLines: 3,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                              fontSize: 12,
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w600,
                                              color: listTitleColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : _HeartAnimation(
                        slideAnimationController: _slideAnimationController,
                        rotationAnimationController:
                            _rotationAnimationController,
                      );
              },
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _HeartAnimation extends StatelessWidget {
  final AnimationController slideAnimationController;
  final AnimationController rotationAnimationController;
  const _HeartAnimation(
      {Key? key,
      required this.rotationAnimationController,
      required this.slideAnimationController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Фаслҳои маҳбуби шумо дар инҷо намоиш дода мешавад",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, height: 1.6),
            ),
          ),
          ScaleTransition(
            scale: Tween<double>(
              begin: 0.8, // Zoom out scale factor
              end: 0.5, // Zoom in scale factor
            ).animate(slideAnimationController),
            child: const Text(
              "❤️",
              style: TextStyle(fontSize: 80),
            ),
          ),
        ],
      ),
    );
  }
}
