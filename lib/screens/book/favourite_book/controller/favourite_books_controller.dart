import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/models/favorite_model.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';

import '../../../../global_widgets/custom_dialog.dart';

class FavouriteBooksController extends GetxController {
  final LoginController loginController;
  final MainController mainController;
  final BookRepository bookRepository;

  FavouriteBooksController(
      this.bookRepository, this.loginController, this.mainController);

  Rx<List<Datum>> favouriteBooksModel = Rx<List<Datum>>([]);
  RxBool isLoading = false.obs;
  RxBool isDeclinedLoading = false.obs;
  RxInt popupMenuItemIndex = 0.obs;
  RxBool isPaging = true.obs;
  RxBool gettingMoreData = false.obs;
  RxInt page = 1.obs;
  BooksModel? booksModel;
  var token;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getFavouriteBooks();
    getDeclineBook();
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  changeType(val) {
    page.value = 1;
    getFavouriteBooks();
  }

  changePage() {
    page.value = 1;
    getFavouriteBooks();
  }

  loadMoreFiles() {
    if (isPaging.value) {
      page.value++;
      getFavouriteBooksPage();
    }
  }

  void getFavouriteBooksPage() async {
    gettingMoreData(true);
    final result = await bookRepository.getFavouriteBooksData(
        loginController.userInfo?.accessToken ?? token, page.value);
    if (page.value == 1) {
      favouriteBooksModel.value = [];
    }
    result.fold((error) {
      print(error.message);
      gettingMoreData.value = false;
    }, (data) async {
      if (data.books.data == []) {
        isPaging(false);
        gettingMoreData.value = false;
      } else {
        favouriteBooksModel.value.addAll(data.books.data);
        gettingMoreData.value = false;
      }
    });
  }

  Future<void> getFavouriteBooks() async {
    isLoading.value = true;
    final result = await bookRepository.getFavouriteBooksData(
        loginController.userInfo?.accessToken ?? token, page.value);
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      favouriteBooksModel.value = data.books.data;
      isPaging.value = true;
      isLoading.value = false;
    });
  }

  Future<void> getDeclineBook() async {
    isDeclinedLoading.value = true;
    final result = await bookRepository
        .getDeclineBook(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      isDeclinedLoading.value = false;
      print(error.message);
    }, (data) async {
      isDeclinedLoading.value = false;
      booksModel = data;
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
      getDeclineBook();
    });
  }

  onMenuItemSelected(int value, int id, BuildContext context) {
    popupMenuItemIndex.value = value;

    if (value == Options.view.index) {
      Get.toNamed(Routes.bookDetailsScreen, arguments: [id, ""]);
    } else {
      customDialog(context, 'Are you sure to delete the book?', 'No', 'Yes',
              () {
        Navigator.pop(context);
            deleteBook(id.toString()).then((value) {
              booksModel!.books.removeWhere((element) => element.id == id);

              getDeclineBook();
            });
          }, () {
            Navigator.pop(context);
          });
    }
  }



  Future<void> favouriteMark() async {
    final result = await bookRepository.getFavouriteBooksData(
        loginController.userInfo?.accessToken ?? token, page.value);
    result.fold((error) {
      print(error.message);
    }, (data) async {
      favouriteBooksModel.value = data.books.data;
     // dashboardController.getDashboardData();
      isPaging.value = true;
    });
  }

  Future<void> storeFavouriteBook(int id) async {
    final result = await bookRepository.storeFavouriteBook(
        loginController.userInfo?.accessToken ?? token, id);
    result.fold((error) {
      print(error.message);
      Get.snackbar("Success", error.message);
    }, (data) async {
      Get.snackbar("Success", data);
      getFavouriteBooks();
    });
  }

  Future<void> storeBorrowBook(int id) async {
    final result = await bookRepository.storeBorrowBook(
        loginController.userInfo?.accessToken ?? token, id);
    result.fold((error) {
      print(error.message);
      Get.snackbar("Success", error.message);
    }, (data) async {
      Get.snackbar("Success", data);
      getFavouriteBooks();
    });
  }
}

enum Options { view, delete }
