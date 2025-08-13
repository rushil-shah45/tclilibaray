import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/no_internet/controller/no_internet_controller.dart';

class NoInternetBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut(() => LoginController(Get.find()));
    Get.lazyPut(() => NoInternetController());
  }
}