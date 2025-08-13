import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';

class NoInternetController extends GetxController {
  var isLoading = false.obs;
  // final LoginController _loginController;
  NoInternetController(/*this._loginController*/);

  checkInternet() async {
    // getSession();
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      goPage();
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      goPage();
    } else {
      Get.snackbar("Network Error", "No Internet Connection");
    }
  }

  bool isNet = false;

  void goPage() {
    if (isNet) {
      Get.offAllNamed(Routes.main);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }

}