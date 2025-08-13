import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';
import 'package:tcllibraryapp_develop/screens/transaction/models/transaction_model.dart';

class TransactionController extends GetxController {
  final SettingsRepository settingsRepository;
  final LoginController loginController;

  TransactionController(this.loginController, this.settingsRepository);

  Rx<List<TransactionModel>> transactionList = Rx<List<TransactionModel>>([]);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getToken();
    super.onInit();
    getTransaction();
  }

  var token;
  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  Future<void> getTransaction() async {
    isLoading.value = true;
    final result = await settingsRepository
        .getTransaction(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      transactionList.value = data;
      isLoading.value = false;
    });
  }

  String getPackageStatus(TransactionModel transactionModel) {
    if (transactionModel.packageId == "1") {
      return 'Free';
    } else if (transactionModel.packageId == "2") {
      return 'Light';
    } else if (transactionModel.packageId == "3") {
      return 'Premium';
    } else {
      return '';
    }
  }
}
