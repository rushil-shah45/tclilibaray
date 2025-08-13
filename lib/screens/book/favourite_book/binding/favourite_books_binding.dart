import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/favourite_book/controller/favourite_books_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import '../../../setting/repository/setting_repository.dart';

class FavouriteBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));

    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(
        () => FavouriteBooksController(Get.find(), Get.find(), Get.find()));
  }
}
