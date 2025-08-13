import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/favourite_book/controller/favourite_books_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/models/favorite_model.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';

class FavouriteController extends GetxController {
  final LoginController loginController;
  final MainController mainController;
  final BookRepository bookRepository;
  final FavouriteBooksController favouriteBooksController;
  final DashboardController dashboardController;

  FavouriteController(
      this.loginController,
      this.bookRepository,
      this.mainController,
      this.favouriteBooksController,
      this.dashboardController);

  Rx<List<Datum>> favouriteBooksModel = Rx<List<Datum>>([]);
  RxBool isLoading = false.obs;
  RxBool isPaging = true.obs;
  RxBool gettingMoreData = false.obs;
  RxInt page = 1.obs;
  var token;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getFavouriteBooks();
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

  Future<void> favouriteMark() async {
    final result = await bookRepository.getFavouriteBooksData(
        loginController.userInfo?.accessToken ?? token, page.value);
    result.fold((error) {
      print(error.message);
    }, (data) async {
      favouriteBooksModel.value = data.books.data;
      dashboardController.getDashboardData();
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
      getFavouriteBooks();
    });
  }
}
