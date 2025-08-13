import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/global_widgets/custom_dialog.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';

class MyBookController extends GetxController {
  final LoginController loginController;
  final BookRepository bookRepository;

  MyBookController(this.bookRepository, this.loginController);

  RxInt popupMenuItemIndex = 0.obs;
  RxBool isLoading = false.obs;
  BooksModel? booksModel;
  var token;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getMyBook();
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  Future<void> getMyBook() async {
    isLoading.value = true;
    final result = await bookRepository
        .getMyBook(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      booksModel = data;
      isLoading.value = false;
    });
  }

  Future<void> deleteBook(String id) async {
    final result = await bookRepository.deleteBook(
        loginController.userInfo?.accessToken ?? token, id);
    result.fold((error) {
      print(error.message);
      Get.snackbar("Warning", error.message);
    }, (data) async {
      Get.snackbar("Success", data);
    });
  }

  onMenuItemSelected(int value, int id, index, context) {
    popupMenuItemIndex.value = value;

    if (value == Options.analytics.index) {
      Get.toNamed(Routes.analyticsScreen,
          arguments: {'id': id, 'booksModel': index});
    } else if (value == Options.edit.index) {
      Get.toNamed(Routes.updateBookScreen, arguments: index)!.then((value) {
        getMyBook();
      });
    } else {
      customDialog(context, 'Are you sure to delete the book?', 'No', 'Yes',
          () {
            Navigator.pop(context);
            deleteBook(id.toString()).then((value) {
          booksModel!.books.removeWhere((element) => element.id == id);
          getMyBook();
        });
      }, () {
        Navigator.pop(context);
      });
    }
  }
}

enum Options { analytics, edit, delete }
