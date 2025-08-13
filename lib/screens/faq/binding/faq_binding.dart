import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/faq/controller/faq_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(remoteDataSource: Get.find(), localDataSource: Get.find()));
    Get.lazyPut(() => FaqController(Get.find()));
    // //
  }
}
