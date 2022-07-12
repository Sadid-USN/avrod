import 'package:avrod/widgets/watch/watchcontroller.dart';
import 'package:get/get.dart';

class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WatchController(), fenix: true);
  }
}
