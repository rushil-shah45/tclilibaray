import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcllibraryapp_develop/data/error/exception.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/repository/auth_repository.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/models/country_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

import '../model/profile_model.dart';

class SettingsController extends GetxController {
  final MainController mainController;
  final AuthRepository authRepository;
  final SettingsRepository settingsRepository;

  SettingsController(
      this.mainController, this.authRepository, this.settingsRepository);

  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final emailAddressCtrl = TextEditingController();
  final addressCtrl = TextEditingController();
  final phoneNumberCtrl = TextEditingController();
  final currentPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
  final deleteCtrl = TextEditingController();
  Rx<File> profileImage = File('').obs;
  RxBool passIsLoading = false.obs;
  RxBool isUpdatingProfile = false.obs;
  RxBool isDeleteBtnLoading = false.obs;
  RxBool obscureText = true.obs;
  RxBool obscureNewText = true.obs;
  RxBool obscureConfirmText = true.obs;
  RxBool isLoading = false.obs;
  Rx<List<CountryModel>> countryModel = Rx<List<CountryModel>>([]);
  var token;
  RxString image = ''.obs;
  RxString path = ''.obs;
  RxString dialCode = '61'.obs;
  RxString flagIcon = "🇦🇺".obs;
  RxString countryCode = "AU".obs;
  RxString countryName = 'Australia'.obs;
  UserProfileModel? userProfileModel;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getUserProfile();
  }

  void toggle() {
    obscureText.toggle();
    update();
  }

  void toggleNew() {
    obscureNewText.toggle();
    update();
  }

  void toggleConfirm() {
    obscureConfirmText.toggle();
    update();
  }

  void getUserProfile() async {
    isLoading.value = true;
    final result = await settingsRepository.getUserProfile(token);
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
      image.value = userProfileModel!.image;
      firstNameCtrl.text = "${userProfileModel?.name}";
      lastNameCtrl.text = "${userProfileModel?.lastName}";
      emailAddressCtrl.text = "${userProfileModel?.email}";
      countryName.value = "${userProfileModel?.country}";
      countryCode.value = "${userProfileModel?.countryCode}";
      if (userProfileModel?.roleId == "1" || userProfileModel?.roleId == "2") {
        dialCode.value = "${userProfileModel?.dialCode.substring(1)}";
        Country country =
            CountryParser.parseCountryCode("${userProfileModel?.countryCode}");
        flagIcon.value = country.flagEmoji;
      } else {}
      phoneNumberCtrl.text = "${userProfileModel?.phone}";
      isLoading.value = false;
    });
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  setProfileImage(File profileImg) {
    profileImage.value = profileImg;
    String parent = '${profileImg.parent.path}/';
    path.value = profileImg.path;
    path.value = path.value.replaceAll(parent, '');
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

  updateProfile(context) async {
    isUpdatingProfile(true);
    if (isFirstNameOkay() && isLastNameOkay() && isEmailNameOkay()) {
      if (profileImage.value.path.isNotEmpty) {
        Uri uri = Uri.parse(RemoteUrls.updateProfile);
        var request = http.MultipartRequest('POST', uri);
        request.files.add(http.MultipartFile.fromBytes(
            'image', profileImage.value.readAsBytesSync(),
            filename: path.value));

        request.headers['Accept'] = 'application/json';
        request.headers['Authorization'] = 'Bearer $token';

        request.fields['first_name'] = firstNameCtrl.text.trim();
        request.fields['last_name'] = lastNameCtrl.text.trim();
        request.fields['email'] = emailAddressCtrl.text.trim();
        if (mainController.userProfileModel?.roleId == '1' ||
            mainController.userProfileModel?.roleId == '2') {
          if (isPhoneOkay()) {
            request.fields['dial_code'] = '+${dialCode.value.trim()}';
            request.fields['phone'] = phoneNumberCtrl.text.trim();
            request.fields['country'] = countryName.value;
            request.fields['country_code'] = countryCode.value.trim();
            return request.send().then((value) {
              try {
                value.stream
                    .transform(utf8.decoder)
                    .transform(const LineSplitter())
                    .listen((event) {
                  getUserProfile();
                  mainController.getUserProfile();
                  Navigator.pop(context);
                  Get.snackbar('Successfully', 'Profile successfully updated');
                  image.value = '';
                  isUpdatingProfile.value = false;
                });
              } on SocketException {
                throw const NetworkException(
                    'Please check your \nInternet Connection', 10061);
              } on FormatException {
                throw const DataFormatException('Data format exception', 422);
              } on TimeoutException {
                throw const NetworkException('Request timeout', 408);
              }
            });
          } else {
            Get.snackbar('Phone number is not valid',
                'Please enter a valid phone number');
            isUpdatingProfile.value = false;
          }
        } else {
          return request.send().then((value) {
            try {
              value.stream
                  .transform(utf8.decoder)
                  .transform(const LineSplitter())
                  .listen((event) {
                getUserProfile();
                mainController.getUserProfile();
                Navigator.pop(context);
                Get.snackbar('Successfully', 'Profile successfully updated');
                image.value = '';
                isUpdatingProfile.value = false;
              });
            } on SocketException {
              throw const NetworkException(
                  'Please check your \nInternet Connection', 10061);
            } on FormatException {
              throw const DataFormatException('Data format exception', 422);
            } on TimeoutException {
              throw const NetworkException('Request timeout', 408);
            }
          });
        }
      } else {
        Map<String, dynamic> body = {
          'first_name': firstNameCtrl.text.trim(),
          'last_name': lastNameCtrl.text.trim(),
          'email': emailAddressCtrl.text.trim(),
        };

        if (mainController.userProfileModel?.roleId == '1' ||
            mainController.userProfileModel?.roleId == '2') {
          if (isPhoneOkay()) {
            body.addAll({"dial_code": '+${dialCode.value.trim()}'});
            body.addAll({"phone": phoneNumberCtrl.text.trim()});
            body.addAll({"country": countryName.value});
            body.addAll({"country_code": countryCode.value.trim()});
            final result = await settingsRepository.updateProfile(body, token);
            result.fold((error) {
              Get.snackbar('Warning', error.message,
                  backgroundColor: Colors.red.shade300,
                  colorText: Colors.black);
              isUpdatingProfile.value = false;
            }, (data) async {
              getUserProfile();
              mainController.getUserProfile();
              Navigator.pop(context);
              Get.snackbar('Successfully', data);
              isUpdatingProfile.value = false;
            });
          } else {
            Get.snackbar('Phone number is not valid',
                'Please enter a valid phone number');
            isUpdatingProfile.value = false;
          }
        } else {
          final result = await settingsRepository.updateProfile(body, token);
          result.fold((error) {
            Get.snackbar('Warning', error.message,
                backgroundColor: Colors.red.shade300, colorText: Colors.black);
            isUpdatingProfile.value = false;
          }, (data) async {
            getUserProfile();
            mainController.getUserProfile();
            Navigator.pop(context);
            Get.snackbar('Successfully', data);
            isUpdatingProfile.value = false;
          });
        }
      }
    } else if (!isFirstNameOkay()) {
      Get.snackbar(
          'First name can\'t be empty', 'Please enter your first name');
      isUpdatingProfile.value = false;
    } else if (!isLastNameOkay()) {
      Get.snackbar('Last name can\'t be empty', 'Please enter your last name');
      isUpdatingProfile.value = false;
    } else if (!isEmailNameOkay()) {
      Get.snackbar('Email can\'t be empty', 'Please enter your email');
      isUpdatingProfile.value = false;
    }
  }

  bool isCurrentPasswordOkay() {
    if (currentPassCtrl.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isNewPasswordOkay() {
    if (newPassCtrl.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isConfirmPasswordOkay() {
    if (confirmPassCtrl.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  updatePassword() async {
    passIsLoading.value = true;
    if (isCurrentPasswordOkay() &&
        isNewPasswordOkay() &&
        isConfirmPasswordOkay()) {
      if (newPassCtrl.text == confirmPassCtrl.text) {
        final body = <String, String>{};
        body.addAll({"current_password": currentPassCtrl.text.trim()});
        body.addAll({"new_password": newPassCtrl.text.trim()});
        body.addAll({"new_password_confirmation": confirmPassCtrl.text.trim()});

        final result = await mainController.settingRepository.updatePassword(
            body,
            mainController.loginController.userInfo?.accessToken ?? token);

        result.fold((error) {
          passIsLoading.value = false;
          Get.snackbar('Warning', error.message,
              backgroundColor: Colors.red.shade300, colorText: Colors.black);
        }, (data) async {
          currentPassCtrl.text = "";
          newPassCtrl.text = "";
          confirmPassCtrl.text = "";
          passIsLoading.value = false;
          Get.back();
          Get.snackbar('Success', data,
              backgroundColor: Colors.white60, colorText: Colors.black);
        });
      } else {
        Get.snackbar("Warning", "Confirm password not matched");
        passIsLoading.value = false;
      }
    } else if (!isCurrentPasswordOkay()) {
      Get.snackbar('Current password can\'t be empty',
          'Please enter your current password');
      passIsLoading.value = false;
    } else if (!isNewPasswordOkay()) {
      Get.snackbar(
          'New password can\'t be empty', 'Please enter your new password');
      passIsLoading.value = false;
    } else if (!isConfirmPasswordOkay()) {
      Get.snackbar('Confirm password can\'t be empty',
          'Please enter your confirm password');
      passIsLoading.value = false;
    }
  }

  bool isDeleteOkay() {
    if (deleteCtrl.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> deleteAccount() async {
    if (isDeleteOkay()) {
      if (deleteCtrl.text == "Delete") {
        isDeleteBtnLoading.value = true;
        final result = await mainController.settingRepository.deleteAccount(
            mainController.loginController.userInfo?.accessToken ?? token);
        result.fold((error) {
          isDeleteBtnLoading.value = false;
          Get.snackbar('Warning', error.message, colorText: Colors.black);
        }, (data) async {
          deleteCtrl.clear();
          sharedPreferences.clear();
          Get.offAllNamed(Routes.login);
          Get.snackbar('Success', data,
              backgroundColor: Colors.white60, colorText: Colors.black);
          isDeleteBtnLoading.value = false;
        });
      } else {
        Get.snackbar("Warning", "Please enter \"Delete\"");
      }
    } else if (!isDeleteOkay()) {
      Get.snackbar('Delete can\'t be empty', 'Please enter delete');
      isDeleteBtnLoading(false);
    }
  }
}
