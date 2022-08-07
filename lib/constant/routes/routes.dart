import 'package:avrod/booksScreen/selected_books.dart';
import 'package:avrod/booksScreen/show_book_screen.dart';
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
  GetPage(name: AppRouteNames.languge, page: () => const LangugesPage()),
  GetPage(name: AppRouteNames.homepage, page: () => const HomePage()),
  GetPage(name: AppRouteNames.texts, page: () => TextScreen()),
  GetPage(name: AppRouteNames.searchScreen, page: () => const SearchScreen()),
  GetPage(name: AppRouteNames.selectedBooks, page: () => const SelectedBooks()),
  GetPage(name: AppRouteNames.showbook, page: () => const ShowBook()),
  GetPage(
      name: AppRouteNames.favorite, page: () => const FavoriteChaptersSceen()),
];
