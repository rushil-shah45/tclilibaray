import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';
import 'package:tcllibraryapp_develop/screens/transaction/controller/transaction_controller.dart';

class TransactionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransactionController(Get.find(), Get.find()));
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));
  }
}
