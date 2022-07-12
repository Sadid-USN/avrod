import 'dart:async';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:intl/intl.dart';

class WatchController extends GetxController {
  double fontSize = 20;
  Timer? timer;
  String? timeString;

  @override
  void onInit() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.onInit();
  }

  void _getTime() {
    final String formattedDateTime =
        DateFormat('kk:mm:ss').format(DateTime.now()).toString();
    timeString = formattedDateTime;
    update();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }
}
