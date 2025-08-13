import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import '../controller/my_book_controller.dart';

class MyBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => MyBookController(Get.find(), Get.find()));
  }
}
