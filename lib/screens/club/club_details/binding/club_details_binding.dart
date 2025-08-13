import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/controller/club_details_controller.dart';

class ClubDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => ClubDetailsController(Get.find(), Get.find(), Get.find()));
  }
}
