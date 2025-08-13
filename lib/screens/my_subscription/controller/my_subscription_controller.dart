import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/models/country_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

import '../../auth/login/controller/login_controller.dart';
import '../../main/controller/main_controller.dart';

class MySubscriptionController extends GetxController {
  final LoginController loginController;
  final MainController mainController;
  final SettingsController settingsController;
  final SettingsRepository settingsRepository;

  MySubscriptionController(this.loginController, this.settingsRepository,
      this.mainController, this.settingsController);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final selectedCountryOption = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  RxString userType = ''.obs;
  Rx<List<CountryModel>> countryModel = Rx<List<CountryModel>>([]);
  RxBool isLoading = false.obs;
  var token;
  Rx<List<String>> userItems = Rx<List<String>>([]);
  RxString dialCode = '61'.obs;
  RxString flagIcon = "🇦🇺".obs;
  RxString countryCodeName = "AU".obs;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    getToken();
    super.onInit();
    getCountryData();
    userItems.value = ["Personal", "Business"];
    nameController.text = "${mainController.userProfileModel?.billingName}";
    emailController.text = "${mainController.userProfileModel?.billingEmail}";
    dialCode.value = mainController.userProfileModel?.billingDialCode == ''
        ? ''
        : "${mainController.userProfileModel?.billingDialCode.substring(1)}";
    phoneController.text = "${mainController.userProfileModel?.billingPhone}";
    userType.value = "${mainController.userProfileModel?.type}";
    addressController.text = "${mainController.userProfileModel?.address}";
    selectedCountryOption.text = "${mainController.userProfileModel?.country}";
    stateController.text = "${mainController.userProfileModel?.state}";
    cityController.text = "${mainController.userProfileModel?.city}";
    zipController.text = "${mainController.userProfileModel?.zipcode}";
    countryCodeName.value = "${mainController.userProfileModel?.billingCountryCode}";

    if (mainController.userProfileModel?.billingCountryCode != '') {
      Country? country = CountryParser.parseCountryCode(
          "${mainController.userProfileModel?.billingCountryCode}");
      flagIcon.value = country.flagEmoji;
    } else {
      Country country = CountryParser.parseCountryCode(
          mainController.userProfileModel!.countryCode);
      flagIcon.value = country.flagEmoji;
      dialCode.value =
          dialCode.value == '' ? country.phoneCode : dialCode.value;
    }
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  void changeSizeItemValue(val) {
    userType.value = val;
    update();
  }

  void change(val) {
    selectedCountryOption.text = val;
  }

  Future<void> getCountryData() async {
    isLoading.value = true;
    final result = await settingsRepository.getCountryData();
    result.fold((error) {
      isLoading.value = false;
    }, (data) async {
      countryModel.value = data;
      isLoading.value = false;
    });
  }

  bool isNameOkay() {
    if (nameController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isEmailOkay() {
    if (emailController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isPhoneNumberValid(String phoneNumber) {
    RegExp regExp = RegExp(r'^[0-9]+$'); // Only allow digits
    return regExp.hasMatch(phoneNumber);
  }

  bool isPhoneOkay() {
    String phoneNumber = phoneController.text.trim();
    if (phoneController.text.isNotEmpty && isPhoneNumberValid(phoneNumber)) {
      return true;
    }
    return false;
  }

  bool isUserTypeOkay() {
    if (userType.value.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isAddressOkay() {
    if (addressController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isCountryOkay() {
    if (selectedCountryOption.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isStateOkay() {
    if (stateController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isCityOkay() {
    if (cityController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isZipCodeOkay() {
    if (zipController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> billingInformationPost(context) async {
    if (isNameOkay() &&
        isEmailOkay() &&
        isPhoneOkay() &&
        isUserTypeOkay() &&
        isAddressOkay() &&
        isCountryOkay() &&
        isStateOkay() &&
        isCityOkay() &&
        isZipCodeOkay()) {
      Map<String, dynamic> body = {
        'billing_name': nameController.text.trim(),
        'billing_email': emailController.text.trim(),
        'billing_country': selectedCountryOption.text,
        'billing_country_code': countryCodeName.value.trim(),
        'billing_dial_code': '+${dialCode.value.trim()}',
        'billing_phone': phoneController.text.trim(),
        'type': userType.value.capitalizeFirst,
        'billing_address': addressController.text.trim(),
        'billing_state': stateController.text.trim(),
        'billing_city': cityController.text.trim(),
        'billing_zipcode': zipController.text.trim(),
      };

      isLoading(true);
      final result = await settingsRepository.billingInformationPost(
          loginController.userInfo?.accessToken ?? token, body);
      result.fold((error) {
        print(error.message);
        Get.snackbar('Warning', error.message);
        isLoading(false);
      }, (data) async {
        mainController.getUserProfile();
        settingsController.getUserProfile();
        Get.snackbar('Success', data);
        Navigator.pop(context);
        isLoading(false);
      });
    } else if (!isNameOkay()) {
      Get.snackbar('Name can\'t be empty', 'Please enter your name');
      isLoading(false);
    } else if (!isEmailOkay()) {
      Get.snackbar('Email can\'t be empty', 'Please enter your email');
      isLoading(false);
    } else if (!isPhoneOkay()) {
      Get.snackbar(
          'Phone number is not valid', 'Please enter a valid phone number');
      isLoading(false);
    } else if (!isAddressOkay()) {
      Get.snackbar('Address can\'t be empty', 'Please enter your address');
      isLoading(false);
    } else if (!isUserTypeOkay()) {
      Get.snackbar('User Type can\'t be empty', 'Please select your type');
      isLoading(false);
    } else if (!isCountryOkay()) {
      Get.snackbar('Country can\'t be empty', 'Please select your country');
      isLoading(false);
    } else if (!isStateOkay()) {
      Get.snackbar('State can\'t be empty', 'Please enter your state');
      isLoading(false);
    } else if (!isCityOkay()) {
      Get.snackbar('City can\'t be empty', 'Please enter your city');
      isLoading(false);
    } else if (!isZipCodeOkay()) {
      Get.snackbar('Zip can\'t be empty', 'Please enter your zip');
      isLoading(false);
    }
  }
}
