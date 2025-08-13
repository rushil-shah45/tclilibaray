import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/data/preferences/storage_service.dart';
import 'package:tcllibraryapp_develop/screens/book/author/add_book/controller/add_book_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';

import '../../../authorBook/controller/author_book_controller.dart';
import '../../mybooks/controller/my_book_controller.dart';

class AddBookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> AuthorBookController(Get.find(), Get.find(), Get.find(),Get.find(), Get.find(), Get.find(),Get.find()));
    Get.lazyPut(() => AddBookController(Get.find(), Get.find(), Get.find()));
    Get.lazyPut(() => StorageService());
    Get.lazyPut(() => MyBookController(Get.find(), Get.find()));
    Get.lazyPut<BookRepository>(
        () => BookRepositoryImpl(remoteDataSource: Get.find()));
  }
}
