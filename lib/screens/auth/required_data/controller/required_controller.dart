import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/models/country_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

import '../../registration/model/register_model.dart';

class RequiredController extends GetxController {
 // final LoginController loginController;
  final SettingsRepository settingsRepository;

  RequiredController(
      //this.loginController,
      this.settingsRepository);

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailAddressCtrl = TextEditingController();
  final phoneNumberCtrl = TextEditingController();

  RxBool isUpdatingProfile = false.obs;
  RxString dialCode = '61'.obs;
  RxString flagIcon = "🇦🇺".obs;
  RxString countryCode = "AU".obs;
  RxString countryName = 'Australia'.obs;
  String? deviceId = '';
  RxBool isLoading = false.obs;
  var phone;
  UserRegisterModel? userRegisterModel;

  Future<void> getphone() async {
    await sharedPreferences.setString('isPhone', '0');
  }

  @override
  void onInit() {
    super.onInit();
    getToken();
    userRegisterModel = Get.arguments;
    getphone().then((value) {
      print('dddd');
      phone = sharedPreferences.getString('isPhone');
      print(phone);
    });
    // firstNameCtrl.text = loginController.userInfo!.user.name;
    // lastNameCtrl.text = loginController.userInfo!.user.lastName;
    // emailAddressCtrl.text = loginController.userInfo!.user.email;
    if(userRegisterModel!=null){
      firstNameCtrl.text = userRegisterModel!.user.name;
      lastNameCtrl.text = userRegisterModel!.user.lastName;
      emailAddressCtrl.text = userRegisterModel!.user.email;
    }

  }

  var token;

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  bool isFirstNameOkay() {
    if (firstNameCtrl.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isLastNameOkay() {
    if (lastNameCtrl.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isEmailNameOkay() {
    if (emailAddressCtrl.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isPhoneNumberValid(String phoneNumber) {
    RegExp regExp = RegExp(r'^[0-9]+$'); // Only allow digits
    return regExp.hasMatch(phoneNumber);
  }

  bool isPhoneOkay() {
    String phoneNumber = phoneNumberCtrl.text.trim();
    if (phoneNumberCtrl.text.isNotEmpty && isPhoneNumberValid(phoneNumber)) {
      return true;
    }
    return false;
  }

  updateProfile() async {
    isUpdatingProfile(true);
    if (isFirstNameOkay() &&
        isLastNameOkay() &&
        isEmailNameOkay() &&
        isPhoneOkay()) {
      Map<String, dynamic> body = {
        'first_name': firstNameCtrl.text.trim(),
        'last_name': lastNameCtrl.text.trim(),
        'email': emailAddressCtrl.text.trim(),
        'country_code': countryCode.value.trim(),
        'dial_code': '+${dialCode.value.trim()}',
        'phone': phoneNumberCtrl.text.trim(),
        'country': countryName.value,
      };



      if(userRegisterModel!=null){
        final result = await settingsRepository.updateProfile(
            body, userRegisterModel!.accessToken);
        result.fold((error) {
          Get.snackbar('Warning', error.message,
              backgroundColor: Colors.red.shade300, colorText: Colors.black);
          isUpdatingProfile(false);
        }, (data) async {
          sharedPreferences.setString('isPhone', '1');
          Get.offAndToNamed(Routes.main);
          isUpdatingProfile(false);
        });
      }

    } else if (!isFirstNameOkay()) {
      Get.snackbar(
          'First name can\'t be empty', 'Please enter your first name');
      isUpdatingProfile(false);
    } else if (!isLastNameOkay()) {
      Get.snackbar('Last name can\'t be empty', 'Please enter your last name');
      isUpdatingProfile(false);
    } else if (!isEmailNameOkay()) {
      Get.snackbar('Email can\'t be empty', 'Please enter your email');
      isUpdatingProfile(false);
    } else if (!isPhoneOkay()) {
      Get.snackbar(
          'Phone number is not valid', 'Please enter a valid phone number');
      isUpdatingProfile(false);
    }
  }
}
