import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/author/analytics/controller/analytics_controller.dart';

class AnalyticsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AnalyticsController(Get.find(), Get.find()));
  }
}
