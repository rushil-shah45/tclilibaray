import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/club/club_post/controllers/post_details_controller.dart';

class PostDetailsBinding implements Bindings {
  @override
  void dependencies() {
    // //
    Get.lazyPut(() => PostDetailsController(Get.find(), Get.find()));
  }
}
