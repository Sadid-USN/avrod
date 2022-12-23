import 'package:avrod/Calendars/calendar_tabbar.dart';
import 'package:avrod/booksScreen/library_screen.dart';
import 'package:avrod/middleware/middleware.dart';
import 'package:avrod/screens/aboutapp_screen.dart';
import 'package:avrod/screens/favorite_chapter_screen.dart';

import 'package:avrod/screens/home_page.dart';
import 'package:avrod/screens/languge.page.dart';
import 'package:avrod/screens/search_screen.dart';
import 'package:avrod/screens/suppotr_screen.dart';
import 'package:avrod/screens/text_screen.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(name: '/', page: () => const LangugesPage(), middlewares: [
    MyMiddleware(),
  ]),
  GetPage(
    name: LangugesPage.routName,
    page: () => const LangugesPage(),
  ),
  GetPage(name: HomePage.routName, page: () => const HomePage()),
  GetPage(name: TextScreen.routName, page: () => const TextScreen()),
  GetPage(name: SearchScreen.routName, page: () => const SearchScreen()),
  GetPage(name: LibraryScreen.routName, page: () => const LibraryScreen()),
  GetPage(name: AboutAppScreen.routNaem, page: () => const AboutAppScreen()),
  GetPage(name: SupportScreen.routNaem, page: () => const SupportScreen()),
  // GetPage(
  //     name: AppRouteNames.chapters,
  //     page: () => ChapterScreen(
  //           indexChapter: ,
  //         )),
  GetPage(
    name: FavoriteChaptersSceen.routName,
    page: () => const FavoriteChaptersSceen(),
  ),
  GetPage(
    name: CalendarTabBarView.routName,
    page: () => const CalendarTabBarView(),
  ),
];
