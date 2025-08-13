import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/favourite_book/controller/favourite_books_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/models/publisher_authors_model.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';

class AllBooksController extends GetxController {
  final LoginController loginController;
  final MainController mainController;
  final BookRepository bookRepository;
  final FavouriteBooksController favouriteBooksController;

  AllBooksController(this.bookRepository, this.loginController,
      this.mainController, this.favouriteBooksController);

  TextEditingController searchController = TextEditingController();
  TextEditingController selectPublisherController = TextEditingController();
  TextEditingController selectAuthorController = TextEditingController();
  TextEditingController searchControllerforBookOfMonth = TextEditingController();
  TextEditingController selectPublisherControllerforBookOfMonth = TextEditingController();
  TextEditingController selectAuthorControllerforBookOfMonth = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool gettingMoreData = false.obs;
  RxBool isPaging = true.obs;
  RxBool isPublisher = false.obs;
  Rx<List<Book>> booksModel = Rx<List<Book>>([]);
  Rx<List<Book>> booksModelForBookOfTheMonth = Rx<List<Book>>([]);
  List<Book> originalBooksList = [];
  Rx<List<CategoryIdModel>> publisherModel = Rx<List<CategoryIdModel>>([]);
  Rx<List<Author>> authorModel = Rx<List<Author>>([]);
  RxInt page = 1.obs;
  RxInt publisherId = 0.obs;
  RxInt authorId = 0.obs;
  var token;
  Timer? _debounce;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getAllBooksData();
    getAllBooksDataPageForBookOfMonth();
    getPublisherData();
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  // void onSearchTextChanged(String text) {
  //   if (_debounce?.isActive ?? false) _debounce!.cancel();
  //   _debounce = Timer(const Duration(milliseconds: 200), () {
  //     searchItem(text);
  //   });
  // }

  // searchItem(val) {
  //   if (val.isEmpty) {
  //     resetFilters();
  //   } else {
  //     booksModel.value = originalBooksList
  //         .where((element) =>
  //             element.author!.name
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(val.toString().trim().toLowerCase()) ||
  //             element.title
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(val.toString().trim().toLowerCase()) ||
  //             element.publisher
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(val.toString().trim().toLowerCase()) ||
  //             element.subTitle
  //                 .toString()
  //                 .toLowerCase()
  //                 .contains(val.toString().trim().toLowerCase()))
  //         .toList();
  //   }
  //   update();
  // }

  void change(val, id) {
    selectPublisherController.text = val;
    selectPublisherControllerforBookOfMonth.text = val;

    publisherId.value = id;
    update();
  }

  void change2(val, id) {
    selectAuthorController.text = val;
    selectAuthorControllerforBookOfMonth.text = val;
    authorId.value = id;
    update();
  }

  // void filterBooks() {
  //   if (publisherId.value.isNotEmpty && authorId.value != 0) {
  //     booksModel.value = originalBooksList
  //         .where((book) =>
  //             book.publisher == publisherId.value &&
  //             book.author!.id == authorId.value)
  //         .toList();
  //   } else if (publisherId.value.isNotEmpty) {
  //     booksModel.value = originalBooksList
  //         .where((element) => element.publisher == publisherId.value)
  //         .toList();
  //   } else if (authorId.value != 0) {
  //     booksModel.value = originalBooksList
  //         .where((element) => element.author!.id == authorId.value)
  //         .toList();
  //   } else {
  //     booksModel.value = originalBooksList;
  //   }
  //   update();
  // }

  // void resetFilters() {
  //   booksModel.value = originalBooksList;
  //   update();
  // }

  changeType(val) {
    page.value = 1;
    getAllBooksData();
    getAllBooksDataPageForBookOfMonth();
  }

  changePage() {
    page.value = 1;
    getAllBooksData();
    getAllBooksDataPageForBookOfMonth();
  }

  loadMoreFiles() {
    if (isPaging.value) {
      page.value++;
      getAllBooksDataPage();
    }
  }
  loadMoreFilesForBookOfMonths() {
    if (isPaging.value) {
      page.value++;
      getAllBooksDataPageForBookOfMonth();
    }
  }

  void getAllBooksDataPage() async {
    gettingMoreData(true);
    final result = await bookRepository.getAllBooksData(
        loginController.userInfo?.accessToken ?? token,
        page.value,
        searchController.text,
        publisherId.value.toString(),
        authorId.value.toString());
    if (page.value == 1) {
      booksModel.value = [];
    }
    result.fold((error) {
      // Get.snackbar("Warning", error.message);
      gettingMoreData.value = false;
    }, (data) async {
      if (data.books.data == []) {
        isPaging(false);
        gettingMoreData.value = false;
      } else {
        booksModel.value.addAll(data.books.data);
        gettingMoreData.value = false;
      }
    });
  }
  void getAllBooksDataPageForBookOfMonth() async {
    gettingMoreData(true);
    final result = await bookRepository.getAllBooksDataForBookOfMonth(
        loginController.userInfo?.accessToken ?? token,
        page.value,
        searchControllerforBookOfMonth.text,
        publisherId.value.toString(),
        authorId.value.toString());
    if (page.value == 1) {
      booksModelForBookOfTheMonth.value = [];
    }
    result.fold((error) {
      // Get.snackbar("Warning", error.message);
      gettingMoreData.value = false;
    }, (data) async {

      log("Check my all book og the month data : ${data.books.data}");
      if (data.books.data == []) {
        isPaging(false);
        gettingMoreData.value = false;
      } else {
        booksModelForBookOfTheMonth.value.addAll(data.books.data);
        gettingMoreData.value = false;
      }
    });
  }

  Future<void> getAllBooksData() async {
    isLoading.value = true;
    final result = await bookRepository.getAllBooksData(
        loginController.userInfo?.accessToken ?? token,
        page.value,
        searchController.text,
        publisherId.value.toString(),
        authorId.value.toString());
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      originalBooksList = [];
      originalBooksList = data.books.data;
      booksModel.value = originalBooksList;
      isPaging.value = true;
      isLoading.value = false;
    });
  }

  Future<void> favouriteMark({ required bool isBookOfTheMonth}) async {

    final result = await bookRepository.getAllBooksData(
        loginController.userInfo?.accessToken ?? token,
        page.value,
        isBookOfTheMonth?searchControllerforBookOfMonth.text : searchController.text,
        publisherId.value.toString(),
        authorId.value.toString());
    result.fold((error) {
      print(error.message);
      Get.snackbar("Success", error.message);
    }, (data) async {
      originalBooksList = data.books.data;
      if (isBookOfTheMonth) {
        booksModelForBookOfTheMonth.value = originalBooksList;
      } else {
        
      booksModel.value = originalBooksList;
      }

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
    });
  }

  Future<void> getPublisherData() async {
    isPublisher.value = true;
    authorModel.value.add(Author(id: 0, name: 'Select', lastName: 'Author'));
    publisherModel.value.add(CategoryIdModel(id: 0, name: 'Select Category'));
    final result = await bookRepository
        .getPublisherData(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      isPublisher.value = false;
    }, (data) async {
      authorModel.value.addAll(data.authors);
      publisherModel.value.addAll(data.categories);
      isPublisher.value = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
    searchControllerforBookOfMonth.dispose();
  }




}