import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/pricing/controller/pricing_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class PricingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));
    Get.lazyPut(() => PricingController(Get.find(), Get.find()));
  }
}
