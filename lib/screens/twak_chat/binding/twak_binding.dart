import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/twak_chat/controller/twak_controller.dart';

class TwakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TwakController());
  }
}
