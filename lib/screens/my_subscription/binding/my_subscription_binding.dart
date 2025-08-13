import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/controller/my_subscription_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class MySubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MySubscriptionController(
        Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => SettingsController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));
  }
}
