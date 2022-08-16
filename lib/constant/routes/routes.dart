import 'package:avrod/Calendars/calendar_tabbar.dart';
import 'package:avrod/booksScreen/book_list_screen.dart';
import 'package:avrod/constant/routes/route_names.dart';
import 'package:avrod/middleware/middleware.dart';
import 'package:avrod/screens/favorite_chapter_screen.dart';

import 'package:avrod/screens/home_page.dart';
import 'package:avrod/screens/languge.page.dart';
import 'package:avrod/screens/search_screen.dart';
import 'package:avrod/screens/text_screen.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(name: '/', page: () => const LangugesPage(), middlewares: [
    MyMiddleware(),
  ]),
  GetPage(
    name: AppRouteNames.languge,
    page: () => const LangugesPage(),
  ),
  GetPage(name: AppRouteNames.homepage, page: () => const HomePage()),
  GetPage(name: AppRouteNames.textsScreen, page: () => const TextScreen()),
  GetPage(name: AppRouteNames.searchScreen, page: () => const SearchScreen()),
  GetPage(name: AppRouteNames.bookList, page: () => const BookList()),
  // GetPage(
  //     name: AppRouteNames.chapters,
  //     page: () => ChapterScreen(
  //           indexChapter: ,
  //         )),
  GetPage(
    name: AppRouteNames.favorite,
    page: () => const FavoriteChaptersSceen(),
  ),
  GetPage(
    name: AppRouteNames.calendarTabBarView,
    page: () => const CalendarTabBarView(),
  ),
];
