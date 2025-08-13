import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import '../controller/pending_book_controller.dart';

class PendingBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => PendingBookController(Get.find(), Get.find()));
  }
}
