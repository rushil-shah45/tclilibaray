import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';

class DeclineBookController extends GetxController {
  final LoginController loginController;
  final BookRepository bookRepository;
  DeclineBookController(this.bookRepository, this.loginController);

  RxInt popupMenuItemIndex = 0.obs;
  BooksModel? booksModel;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getDeclineBook();
  }
  var token;
  getToken(){
    token = sharedPreferences.getString("uToken");
  }
  Future<void> getDeclineBook() async {
    isLoading.value = true;
    final result = await bookRepository
        .getDeclineBook(loginController.userInfo?.accessToken??token);
    result.fold((error) {
      isLoading.value = false;
      print(error.message);
    }, (data) async {
      isLoading.value = false;
      booksModel = data;
    });
  }

  Future<void> deleteBook(String id) async {
    final result = await bookRepository.deleteBook(
        loginController.userInfo?.accessToken??token, id);
    result.fold((error) {
      print(error.message);
      Get.snackbar("Warning", error.message);
    }, (data) async {
      Get.snackbar("Success", data);
    });
  }

  onMenuItemSelected(int value, int id) {
    popupMenuItemIndex.value = value;

    if (value == Options.view.index) {
      Get.toNamed(Routes.bookDetailsScreen, arguments: [id, ""]);
    } else {
      deleteBook(id.toString()).then((value) {
        booksModel!.books.removeWhere((element) => element.id == id);
        getDeclineBook();
      });
    }
  }
}

enum Options { view, delete }
