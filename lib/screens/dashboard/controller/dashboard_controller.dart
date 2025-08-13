import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/repository/book_repository.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/model/dashboard_author_model.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/model/dashboard_institution_model.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/model/dashboard_user_model.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';
import '../../../global_widgets/custom_dialog.dart';
import '../../book/model/books_model.dart';

class DashboardController extends GetxController {
  final LoginController loginController;
  final MainController mainController;
  final BookRepository bookRepository;
  final SettingsRepository settingsRepository;

  DashboardController(
      this.bookRepository, this.loginController, this.mainController, this.settingsRepository);

  RxBool isLoading = false.obs;
  RxInt popupMenuItemIndex = 0.obs;
  Rxn<DashboardUserModel> dashboardModel = Rxn<DashboardUserModel>();
  Rxn<DashboardAuthorModel> dashboardAuthorModel = Rxn<DashboardAuthorModel>();
  Rxn<DashboardInstitutionModel> dashboardInstitutionModel =
      Rxn<DashboardInstitutionModel>();
  List<Book> dashBoardAuthorList = [];
  RxInt notifications = 0.obs;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
    mainController.getUserProfile();
    getDashboardData();
  }

  var token;

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  Future<void> getDashboardData() async {
    isLoading.value = true;
    final result = await bookRepository.getDashboardData(token);
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      if (mainController.userProfileModel?.roleId == 1) {
        dashboardModel.value = DashboardUserModel.fromMap(data);
        notifications.value = dashboardModel.value!.unreadNotificationCount;
        isLoading.value = false;
      } else if (mainController.userProfileModel?.roleId == 2) {
        dashboardAuthorModel.value = DashboardAuthorModel.fromMap(data);
        notifications.value = dashboardAuthorModel.value!.unreadNotificationCount;
        isLoading.value = false;
      } else {
        dashboardInstitutionModel.value = DashboardInstitutionModel.fromMap(data);
        notifications.value = dashboardInstitutionModel.value!.unreadNotificationCount;
        isLoading.value = false;
      }
    });
  }

  Future<void> deleteBook(String id) async {
    final result = await bookRepository.deleteBook(token, id);
    result.fold((error) {
      print(error.message);
      Get.snackbar("Success", error.message);
    }, (data) async {
      Get.snackbar("Success", data);
    });
  }

  onMenuItemSelected(int value, int id, index, BuildContext context) {
    popupMenuItemIndex.value = value;

    if (value == Options.edit.index) {
      Get.toNamed(Routes.updateBookScreen, arguments: index)!.then((value) {
        getDashboardData();
      });
    } else {
      customDialog(context, 'Are you sure to delete the book?', 'No', 'Yes',
              () {
        Navigator.pop(context);
            deleteBook(id.toString()).then((value) {
              dashBoardAuthorList.removeWhere((element) => element.id == id);

              getDashboardData();
            });
          }, () {
            Navigator.pop(context);
          });
    }
  }
}

enum Options { edit, delete }
