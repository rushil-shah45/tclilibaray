import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/bookSummary/controller/book_summary_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';

class BookSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookRepository>(
            () => BookRepositoryImpl(remoteDataSource: Get.find()));
    Get.lazyPut(() => BookSummaryController(Get.find(), Get.find(), Get.find(), Get.find()));
  }
}
