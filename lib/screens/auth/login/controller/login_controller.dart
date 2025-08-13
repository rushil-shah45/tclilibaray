import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tcllibraryapp_develop/core/utils/extensions.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/registration/model/register_model.dart';
import 'package:tcllibraryapp_develop/screens/auth/repository/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository authRepository;

  LoginController(this.authRepository);

  final formValueKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? deviceId = '';
  RxBool obscureText = true.obs;
  RxBool isLoading = false.obs;
  RxInt isSelected = 0.obs;
  RxBool isSocialLoading = false.obs;
  bool isTablet = Get.width >= 600;

  RxList<String> userList = ["User", "Author", "Institution"].obs;

  UserRegisterModel? userRegisterModel;

  bool get isLoggedIn => userRegisterModel != null && userRegisterModel!.accessToken.isNotEmpty;

  UserRegisterModel? get userInfo => userRegisterModel;

  set user(UserRegisterModel userData) => userRegisterModel = userData;

  // void cacheUserData() => authRepository.saveCashedUserInfo(userRegisterModel!);
  //
  // void cacheUserWithData(UserRegisterModel userData) =>
  //     authRepository.saveCashedUserInfo(userData);

  @override
  void onInit() {
    super.onInit();
    getFCMToken();

    /// set user data if user already login
    // final result = authRepository.getCashedUserInfo();
    // result.fold(
    //   (l) => userRegisterModel = null,
    //   (r) {
    //     user = r;
    //   },
    // );
  }

  getFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("Check my FCM Token ::::: ${token}");
  }

  changeSelected(val) {
    isSelected.value = val;
  }

  void toggle() {
    obscureText.toggle();
    update();
  }

  bool isEmailNameOkay() {
    if (emailController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isPasswordOkay() {
    if (passwordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void login() async {
    // try {
    // if (Platform.isIOS) {
    //   await Firebase.initializeApp();
    //   deviceId = await FirebaseMessaging.instance.getAPNSToken();

      /// todo Need to Change Token issue
    // } else {
      deviceId = await FirebaseMessaging.instance.getToken();

      /// android
    // }

    print("Device Token: ${deviceId}");
    if (isEmailNameOkay() && isPasswordOkay()) {
      final body = <String, String>{};
      body.addAll({"email": emailController.text.trim()});
      body.addAll({"password": passwordController.text.trim()});
      body.addAll({"device_id": deviceId.toString()});
      body.addAll({"role_id": (isSelected.value + 1).toString()});

      isLoading.value = true;
      print("Request Body: $body");
      final result = await authRepository.login(body);
      result.fold((error) {
        isLoading.value = false;
        Get.snackbar('Cancel', error.message, backgroundColor: Colors.red.shade300, colorText: Colors.black);
      }, (data) async {
        userRegisterModel = data;
        emailController.text = "";
        passwordController.text = "";
        deviceId = "";
        sharedPreferences.setString("uToken", data.accessToken);
        // cacheUserWithData(data);
        Get.offAndToNamed(Routes.main);
        isLoading.value = false;
      });
    } else if (!isEmailNameOkay()) {
      Get.snackbar('Email can\'t be empty', 'Please enter your email');
      isLoading.value = false;
    } else if (!isPasswordOkay()) {
      Get.snackbar('Password can\'t be empty', 'Please enter your password');
      isLoading.value = false;
    }
    // } catch (e) {
    //   //print strack trace
    //   print("Error: $e");
    //   isLoading.value = false;
    //   Get.snackbar('Error', 'Something went wrong, please try again later');
    // } finally {
    //   isLoading.value = false;
    // }
  }

  void socialLogin(String social) async {
    isSocialLoading(true);
    // GoogleSignIn googleSignIn = GoogleSignIn(
    //     signInOption: SignInOption.standard, scopes: ['email']);
    //     await googleSignIn.signOut();
    final result = await authRepository.socialLogin(social);
    result.fold((error) {
      print(error.message);
      Get.snackbar('Warning', error.message, backgroundColor: Colors.red.shade300, colorText: Colors.black);
      isSocialLoading(false);
    }, (data) async {
      print(data);
      userRegisterModel = data;
      sharedPreferences.setString("uToken", data.accessToken);
      sharedPreferences.setString("uPhone", data.user.phone);

      if (userRegisterModel!.user.phone == '') {
        Get.toNamed(Routes.requiredScreen, arguments: userRegisterModel);
      } else {
        Get.offAndToNamed(Routes.main);
      }
      isSocialLoading(false);
    });
  }
}
