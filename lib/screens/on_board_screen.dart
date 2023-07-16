import 'package:avrod/controller/homepage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chat/pages/auth/login_page.dart';
import '../chat/pages/groups_home_page.dart';

class OnBoard extends StatelessWidget {
  static const ONBOARD = '/onboard';
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomePageController());

    if (controller.isSignIn) {
      return const GroupsHomePage();
    } else {
      return const LoginPage();
    }
  }
}
