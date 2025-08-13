import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/author/analytics/models/analytics_model.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class AnalyticsController extends GetxController {
  final LoginController loginController;
  final SettingsRepository settingsRepository;

  AnalyticsController(this.loginController, this.settingsRepository);

  RxBool isLoading = false.obs;
  Rxn<AnalyticsModel> analyticsModel = Rxn<AnalyticsModel>();
  int id = 0;
  var token;
  Book? booksModel;

  @override
  void onInit() {
    super.onInit();
    getToken();
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null) {
      id = arguments['id'] ?? 0;
      booksModel = arguments['booksModel'] as Book?;
    }
    getAnalyticData();
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  Future<void> getAnalyticData() async {
    isLoading.value = true;
    final result = await settingsRepository.getAnalyticsData(
        loginController.userInfo?.accessToken ?? token, id.toString());
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      analyticsModel.value = data;
      isLoading.value = false;
    });
  }
}
