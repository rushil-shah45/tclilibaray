import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/auth/registration/controllers/registration_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class RegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));
    Get.lazyPut(() => RegistrationController(Get.find(), Get.find()));
  }
}
