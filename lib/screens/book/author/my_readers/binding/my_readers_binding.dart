import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import '../controller/my_readers_controller.dart';

class MyReadersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => MyReadersController(Get.find(), Get.find()));
  }
}
