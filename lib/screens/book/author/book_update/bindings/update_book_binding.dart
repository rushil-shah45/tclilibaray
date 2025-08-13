import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/data/preferences/storage_service.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import '../../mybooks/controller/my_book_controller.dart';
import '../controller/update_book_controller.dart';

class UpdateBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpdateBookController(Get.find(), Get.find()));
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => MyBookController(Get.find(), Get.find()));
    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
  }
}
