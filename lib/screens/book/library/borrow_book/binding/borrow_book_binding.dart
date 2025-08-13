import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/library/borrow_book/controller/borrowed_book_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';

class BorrowBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => BorrowedBookController(
        Get.find(), Get.find(), Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => DashboardController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
