import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/authorBook/controller/author_book_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import '../../../setting/repository/setting_repository.dart';

class BookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));

    Get.lazyPut(() => SettingsController(Get.find(), Get.find(), Get.find()));

    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => MainController(Get.find(), Get.find()));
   // Get.lazyPut(() => AuthorBookController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => DashboardController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
