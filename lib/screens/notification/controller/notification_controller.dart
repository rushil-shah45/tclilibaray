import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/notification/model/notification_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class NotificationController extends GetxController {
  final SettingsRepository settingsRepository;
  final LoginController loginController;

  NotificationController(this.settingsRepository, this.loginController);
  final DashboardController dashboardController = Get.find();
  Rx<List<Notifications>> notificationList = Rx<List<Notifications>>([]);
  RxBool isLoading = false.obs;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    getToken();
    super.onInit();
    getNotifications();
  }

  var token;
  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  Future<void> getNotifications() async {
    isLoading.value = true;
    final result = await settingsRepository
        .getNotifications(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      notificationList.value = data;
      isLoading.value = false;
    });
  }

  Future<void> readNotifications(int id) async {
    isLoading(true);
    final result = await settingsRepository.readNotifications(
        loginController.userInfo?.accessToken ?? token, id.toString());
    result.fold((error) {
      Get.snackbar('Warning', error.message);
      isLoading(false);
    }, (data) async {
      Get.snackbar('Success', data);
      getNotifications();
      dashboardController.getDashboardData();
      isLoading(false);
    });
  }
}
