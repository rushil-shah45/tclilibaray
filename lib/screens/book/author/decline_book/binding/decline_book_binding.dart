import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import '../controller/decline_book_controller.dart';

class DeclineBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => DeclineBookController(Get.find(), Get.find()));
  }
}
