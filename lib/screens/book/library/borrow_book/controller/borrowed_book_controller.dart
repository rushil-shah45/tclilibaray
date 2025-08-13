import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/favourite_book/controller/favourite_books_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';

import '../../../model/books_model.dart';

class BorrowedBookController extends GetxController {
  final LoginController loginController;
  final MainController mainController;
  final BookRepository bookRepository;
  final FavouriteBooksController favouriteBooksController;
  final DashboardController dashboardController;

  BorrowedBookController(
      this.loginController,
      this.bookRepository,
      this.mainController,
      this.favouriteBooksController,
      this.dashboardController);

  Rx<List<Book>> borrowedModel = Rx<List<Book>>([]);
  Rx<List<Book>> issuedModel = Rx<List<Book>>([]);
  RxBool isLoading = false.obs;
  var token;
  bool isTablet = Get.width >= 600;

  // RxBool isPaging = true.obs;
  // RxBool gettingMoreData = false.obs;
  // RxInt page = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getBorrowedBooks();
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  // changeType(val) {
  //   page.value = 1;
  //   getBorrowedBooks();
  // }
  //
  // changePage() {
  //   page.value = 1;
  //   getBorrowedBooks();
  // }
  //
  // loadMoreFiles() {
  //   if (isPaging.value) {
  //     page.value++;
  //     getBorrowedBooksPage();
  //   }
  // }

  // void getBorrowedBooksPage() async {
  //   gettingMoreData(true);
  //   final result = await bookRepository.getBorrowedBooksData(
  //       loginController.userInfo?.accessToken??token, page.value);
  //   if (page.value == 1) {
  //     borrowedModel.value = [];
  //   }
  //   result.fold((error) {
  //     print(error.message);
  //     gettingMoreData.value = false;
  //   }, (data) async {
  //     if (data.books == []) {
  //       isPaging(false);
  //       gettingMoreData.value = false;
  //     } else {
  //       borrowedModel.value.addAll(data.books);
  //       gettingMoreData.value = false;
  //     }
  //   });
  // }

  Future<void> getBorrowedBooks() async {
    isLoading.value = true;
    final result = await bookRepository
        .getBorrowedBooksData(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      borrowedModel.value = data.books;
      issuedModel.value = data.books;
      // isPaging.value = true;
      isLoading.value = false;
    });
  }

  Future<void> favouriteMark() async {
    final result = await bookRepository
        .getBorrowedBooksData(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      print(error.message);
    }, (data) async {
      borrowedModel.value = data.books;
      issuedModel.value = data.books;
      dashboardController.getDashboardData();
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
      favouriteBooksController.getFavouriteBooks();
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
    });
  }
}
