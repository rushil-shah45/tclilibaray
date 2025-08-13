import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/controller/favourite_books_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';

class FavouriteBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => FavouriteController(Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => DashboardController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
