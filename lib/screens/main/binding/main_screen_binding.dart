import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/authorBook/controller/author_book_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/favourite_book/controller/favourite_books_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';
import 'package:tcllibraryapp_develop/screens/ticket/controller/ticket_controller.dart';
import 'package:tcllibraryapp_develop/screens/ticket/repository/ticket_repository.dart';

class MainScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController(Get.find(), Get.find()));

    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));

    Get.lazyPut(() => SettingsController(Get.find(), Get.find(), Get.find()));

    Get.lazyPut<TicketRepository>(
        () => TicketRepositoryImpl(remoteDataSource: Get.find()));

    Get.lazyPut(() => TicketController(Get.find(), Get.find()));

    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));

    Get.lazyPut(() => AuthorBookController(Get.find(), Get.find(), Get.find(),
        Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() =>
        DashboardController(Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(
        () => FavouriteBooksController(Get.find(), Get.find(), Get.find()));
  }
}
