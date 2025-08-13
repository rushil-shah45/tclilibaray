import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/club/club_new_topic/controllers/club_new_topic_controller.dart';

class ClubNewTopicBinding implements Bindings {
  @override
  void dependencies() {
    // //
    Get.lazyPut(() => ClubNewTopicController(Get.find(), Get.find(), Get.find()));
  }
}
