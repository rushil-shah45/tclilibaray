import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/bookDetails/controller/book_details_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';

class BookDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(
        () => BookDetailsController(Get.find(), Get.find(), Get.find()));
  }
}
