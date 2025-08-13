import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/favourite_book/favourite_books_screen.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/dashboard_screen.dart';
import 'package:tcllibraryapp_develop/screens/main/model/custom_page.dart';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';
import 'package:tcllibraryapp_develop/screens/setting/setting_screen.dart';
import 'package:tcllibraryapp_develop/screens/ticket/ticket_screen.dart';
import '../../book/authorBook/author_books_screen.dart';

class MainController extends GetxController {
  final SettingsRepository settingRepository;
  final LoginController loginController;

  MainController(this.settingRepository, this.loginController);

  UserProfileModel? userProfileModel;
  List<CustomPageModel> customPageModel = [];
  RxInt pageIndex = 0.obs;
  var pageController = PageController(initialPage: 0);
  var bottomPageController = PageController(initialPage: 0);
  RxBool isLoading = false.obs;
  var token;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getUserProfile();
    getPrivacyTermsConditions();
  }

  void changePage(int index) {
    pageIndex.value = index;
    update();
  }

  List<Widget> screenList = [
    const DashboardScreen(),
     TicketScreen(isMain: true,),
     AuthorBooksScreen(isMain: true,),
     FavouriteBooksScreen(isMain: true,),
     SettingScreen(isMain: true,),
  ];

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  void getUserProfile() async {
    isLoading.value = true;
    final result = await settingRepository.getUserProfile(token);
    result.fold((error) {
      if (error.message == "Unauthenticated.") {
        Get.snackbar("Login Required", "Your season has been expired");
        sharedPreferences.clear();
        Get.offAndToNamed(Routes.login);
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
      //isLoading.value = false;
    }, (data) async {
      userProfileModel = data.user;
      isLoading.value = false;
    });
  }

  Future<bool> onBackPressed(context) async {
    if (pageIndex.value != 0) {
      changePage(0);
      bottomPageController.jumpToPage(0);
      pageController.jumpToPage(0);
      return false;
    } else {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              title: Text(
                'Are you sure you want to close application?',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          )) ??
          false;
    }
  }

  Future<void> getPrivacyTermsConditions() async {
    isLoading(true);
    final result = await settingRepository.getPrivacyTermsConditions();
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      customPageModel = data;
      isLoading.value = false;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    bottomPageController.dispose();
    super.dispose();
  }
}
