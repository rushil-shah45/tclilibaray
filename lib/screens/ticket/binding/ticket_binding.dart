import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/ticket/controller/ticket_controller.dart';
import 'package:tcllibraryapp_develop/screens/ticket/repository/ticket_repository.dart';
import '../../setting/controllers/settings_controller.dart';
import '../../setting/repository/setting_repository.dart';

class AddTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));

    Get.lazyPut(() => SettingsController(Get.find(), Get.find(), Get.find()));

    Get.lazyPut(() => TicketController(Get.find(), Get.find()));
    Get.lazyPut<TicketRepository>(
        () => TicketRepositoryImpl(remoteDataSource: Get.find()));
  }
}
