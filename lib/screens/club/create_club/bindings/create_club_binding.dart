import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/club/create_club/controllers/create_club_controller.dart';

class CreateClubBinding implements Bindings {
  @override
  void dependencies() {
    // //
    Get.lazyPut(() => CreateClubController(Get.find(), Get.find()));
  }
}
