import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/auth/repository/auth_repository.dart';

class ForgotPasswordController extends GetxController {
  LoginController loginController;
  AuthRepository authRepository;

  ForgotPasswordController(this.loginController, this.authRepository);

  final emailController = TextEditingController();
  RxBool isLoading = false.obs;

  bool isEmailOkay() {
    if (emailController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> forgotPassword() async {
    if (isEmailOkay()) {
      final body = <String, String>{};
      body.addAll({"email": emailController.text.trim()});

      isLoading.value = true;
      final result = await authRepository.forgotPassword(body);

      result.fold((error) {
        Get.snackbar('Warning', error.message,
            backgroundColor: Colors.red.shade300, colorText: Colors.black);
        isLoading.value = false;
      }, (data) async {
        Get.snackbar("We have mailed your password", "Please check mailbox");
        Navigator.pop(Get.context!);
        emailController.text = "";
        isLoading.value = false;
      });
    } else if (!isEmailOkay()) {
      Get.snackbar('Email can\'t be empty', 'Please enter your email');
      isLoading(false);
    }
  }
}
