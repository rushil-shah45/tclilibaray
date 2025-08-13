import 'dart:developer';

import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/data/SettingsDataController.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';

class BookSummaryController extends GetxController {
  final BookRepository bookRepository;
  final LoginController loginController;
  final MainController mainController;
  final SettingsDataController settingsDataController;

  BookSummaryController(this.bookRepository, this.loginController, this.mainController, this.settingsDataController);

  RxBool isLoading = false.obs;
  var token;
  Rxn<Book> bookSummaryDetail = Rxn<Book>();


  @override
  void onInit() {
    super.onInit();
    getToken();
    bookSummaryDetail.value = Get.arguments[0];
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  Future<void> storeBorrowBook(int id) async {
    final result = await bookRepository.storeBorrowBook(
        loginController.userInfo?.accessToken ?? token, id);
    result.fold((error) {
      log(error.message);
      Get.snackbar("Success", error.message);
    }, (data) async {
      Get.snackbar("Success", data);
    });
  }
}