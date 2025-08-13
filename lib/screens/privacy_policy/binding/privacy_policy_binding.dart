import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/privacy_policy/controller/privacy_policy_controller.dart';

class PrivacyPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyPolicyController(Get.find()));
  }
}
