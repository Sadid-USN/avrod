import 'package:avrod/constant/routes/route_names.dart';
import 'package:avrod/middleware/middleware.dart';
import 'package:avrod/screens/home_page.dart';
import 'package:avrod/screens/languge.page.dart';

import 'package:get/get_navigation/src/routes/get_route.dart';

List<GetPage<dynamic>>? getPages = [
  GetPage(name: '/', page: () => const LangugesPage(), middlewares: [
    MyMiddleware(),
  ]),
  GetPage(name: AppRouteNames.languge, page: () => const LangugesPage()),
  GetPage(name: AppRouteNames.homepage, page: () => const HomePage()),
];
