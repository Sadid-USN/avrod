import 'package:avrod/constant/routes/route_names.dart';
import 'package:avrod/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;
  MyServices myServices = Get.find();
  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences.getString('homepage') == "1") {
      return const RouteSettings(name: AppRouteNames.homepage);
    }
    return null;
  }
}