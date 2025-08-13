import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/terms_condition/controller/terms_condition_controller.dart';

class TermConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermConditionController(Get.find()));
  }
}
