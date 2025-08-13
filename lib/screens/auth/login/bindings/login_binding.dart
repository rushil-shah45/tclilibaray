import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/data/preferences/storage_service.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));
    Get.put(() => LoginController(Get.find()));
    Get.put(() => StorageService());
  }
}
