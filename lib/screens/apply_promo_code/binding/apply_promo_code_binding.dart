import 'package:get/get.dart';
import '../controller/apply_promo_code_controller.dart';

class ApplyPromoCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApplyPromoCodeController(Get.find(), Get.find()));
  }
}
