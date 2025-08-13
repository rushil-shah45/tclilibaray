import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';

import '../models/my_readers_model.dart';

class MyReadersController extends GetxController {
  final LoginController loginController;
  final BookRepository bookRepository;

  MyReadersController(this.bookRepository, this.loginController);

  var token;
  RxBool isLoading = false.obs;
  Rx<List<Reader>> readerModel = Rx<List<Reader>>([]);
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getMyReaders();
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  Future<void> getMyReaders() async {
    isLoading.value = true;
    final result = await bookRepository
        .getMyReaders(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      isLoading.value = false;
    }, (data) async {
      readerModel.value = data.readers;
      isLoading.value = false;
    });
  }
}
