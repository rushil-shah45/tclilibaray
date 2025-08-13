import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/payment/controller/payment_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController(
        Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => SettingsController(Get.find(), Get.find(), Get.find()));
  }
}
