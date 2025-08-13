import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/global_widgets/custom_dialog.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/models/publisher_authors_model.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/models/favorite_model.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';
import '../../../../main.dart';
import '../../favourite_book/controller/favourite_books_controller.dart';

class AuthorBookController extends GetxController {
  final MainController mainController;
  final SettingsController settingsController;
  final LoginController loginController;
  final BookRepository bookRepository;
  final FavouriteBooksController favouriteBooksController;
  final DashboardController dashboardController;
  final SettingsRepository settingsRepository;

  AuthorBookController(
      this.mainController,
      this.settingsController,
      this.loginController,
      this.bookRepository,
      this.favouriteBooksController,
      this.dashboardController,
      this.settingsRepository);

  bool isTablet = Get.width >= 600;
  RxBool isBook = false.obs;
  RxBool isLibrary = false.obs;
  RxBool isBookForSale = false.obs;
  RxInt popupMenuItemIndex = 0.obs;
  RxBool isLoading = false.obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController selectPublisherController = TextEditingController();
  TextEditingController selectAuthorController = TextEditingController();
  RxBool isPublisher = false.obs;
  Rx<List<Datum>> favouriteBooksModel = Rx<List<Datum>>([]);
  Rx<List<Book>> booksModels = Rx<List<Book>>([]);
  List<Book> originalBooksList = [];
  Rx<List<CategoryIdModel>> publisherModel = Rx<List<CategoryIdModel>>([]);
  Rx<List<Author>> authorModel = Rx<List<Author>>([]);
  RxBool isPaging = true.obs;
  RxBool gettingMoreData = false.obs;
  RxInt page = 1.obs;
  RxInt publisherId = 0.obs;
  RxInt authorId = 0.obs;
  BooksModel? booksModel;
  Timer? _debounce;
  var token;
  Rx<List<Book>> issuedModel = Rx<List<Book>>([]);

  @override
  void onInit() {
    super.onInit();
    getToken();
    getMyBook();
    getAllBooksData();
    getPublisherData();
    getFavouriteBooks();
    getBorrowedBooks();
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
  //
  // searchItem(val) {
  //   if (val.isEmpty) {
  //     resetFilters();
  //   } else {
  //     booksModels.value = originalBooksList
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
    publisherId.value = id;
  }

  void change2(val, id) {
    selectAuthorController.text = val;
    authorId.value = id;
  }

  // void filterBooks() {
  //   if (publisherId.value.isNotEmpty && authorId.value != 0) {
  //     booksModels.value = originalBooksList
  //         .where((book) =>
  //             book.publisher == publisherId.value &&
  //             book.author!.id == authorId.value)
  //         .toList();
  //   } else if (publisherId.value.isNotEmpty) {
  //     booksModels.value = originalBooksList
  //         .where((element) => element.publisher == publisherId.value)
  //         .toList();
  //   } else if (authorId.value != 0) {
  //     booksModels.value = originalBooksList
  //         .where((element) => element.author!.id == authorId.value)
  //         .toList();
  //   } else {
  //     booksModels.value = originalBooksList;
  //   }
  //   update();
  // }

  // void resetFilters() {
  //   booksModels.value = originalBooksList;
  //   update();
  // }

  changeTypeFavourite(val) {
    page.value = 1;
    getFavouriteBooks();
  }

  changePageFavourite() {
    page.value = 1;
    getFavouriteBooks();
  }

  loadMoreFilesFavourite() {
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
      Get.snackbar("Success", error.message);
    }, (data) async {
      Get.snackbar("Success", data);
    });
  }

  void arrow(val) {
    isLibrary.value = !val;
    update();
  }

  final bookList = [
    {"name": "My Books"},
    {"name": "Pending Books"},
    {"name": "Declined Books"},
    {"name": "My Readers"},
  ];

  final libraryBookList = [
    {"name": "All Books"},
    {"name": "Favourite Books"},
    {"name": "Borrowed Books"},
    {"name": "Book of the month"},
  ];

  final bookForSaleBookList = [
    {"name": "All"},
    {"name": "Purchased Books"}
  ];

  final libraryBookListInstitution = [
    {"name": "Issued Books"},
    {"name": "Favourite Books"},
  ];

  changeType(val) {
    page.value = 1;
    getAllBooksData();
  }

  changePage() {
    page.value = 1;
    getAllBooksData();
  }

  loadMoreFiles() {
    if (isPaging.value) {
      page.value++;
      getAllBooksDataPage();
    }
  }

  void getAllBooksDataPage() async {
    gettingMoreData(true);
    final result = await bookRepository.getAllBooksData(
      loginController.userInfo?.accessToken ?? token,
      page.value,
      searchController.text,
      publisherId.value.toString(),
      authorId.value.toString(),
    );
    if (page.value == 1) {
      booksModels.value = [];
    }
    result.fold((error) {
      print(error.message);
      gettingMoreData.value = false;
    }, (data) async {
      if (data.books.data == []) {
        isPaging(false);
        gettingMoreData.value = false;
      } else {
        booksModels.value.addAll(data.books.data);
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
    print('dddddddddddddddddddddddddddd');
    print(publisherId.value);
    print(authorId.value);
    print('sssssssssssssssssssssssssss');
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      originalBooksList = [];
      originalBooksList = data.books.data;
      booksModels.value = originalBooksList;
      isPaging.value = true;
      isLoading.value = false;
    });
  }

  Future<void> favouriteMark() async {
    final result = await bookRepository.getAllBooksData(
      loginController.userInfo?.accessToken ?? token,
      page.value,
      searchController.text,
      publisherId.value.toString(),
      authorId.value.toString(),
    );
    result.fold((error) {
      print(error.message);
      Get.snackbar("Success", error.message);
    }, (data) async {
      originalBooksList = data.books.data;
      booksModels.value = originalBooksList;
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

  Future<void> favouriteMarkInstitution() async {
    final result = await bookRepository
        .getBorrowedBooksData(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      print(error.message);
    }, (data) async {
      issuedModel.value = data.books;
      favouriteBooksController.getFavouriteBooks();
      dashboardController.getDashboardData();
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
      print(error.message);
      isPublisher.value = false;
    }, (data) async {
      authorModel.value.addAll(data.authors);
      publisherModel.value.addAll(data.categories);
      isPublisher.value = false;
    });
  }

  Future<void> getBorrowedBooks() async {
    isLoading.value = true;
    final result = await bookRepository
        .getBorrowedBooksData(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      issuedModel.value = data.books;
      isLoading.value = false;
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

  Future onBackPressed(context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        title: Column(
          children: [
            Text(
              'Are you sure to logout from this device?',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.red,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Get.back();

              GoogleSignIn googleSignIn = GoogleSignIn(
                  signInOption: SignInOption.standard, scopes: ['email']);
              await googleSignIn.signOut();
              sharedPreferences.clear();

              sharedPreferences.clear();
              Get.offAllNamed(Routes.login);
            },
            child: Text(
              'Yes',
              style: TextStyle(
                fontSize: 14.sp,
                color: primaryColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }
}

enum Options { analytics, edit, delete }
