import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/controllers/club_controller.dart';

class ClubBinding implements Bindings {
  @override
  void dependencies() {
    // //
    Get.lazyPut(() => ClubController(Get.find(), Get.find(), Get.find()));
  }
}
