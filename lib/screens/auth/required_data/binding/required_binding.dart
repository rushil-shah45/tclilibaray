import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/auth/required_data/controller/required_controller.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class RequiredBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RequiredController(Get.find()));
    Get.lazyPut(() => MainController(Get.find(), Get.find()));
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));
  }
}
