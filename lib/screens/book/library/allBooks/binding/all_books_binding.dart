import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/controller/all_books_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';

class AllBooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => AllBooksController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
