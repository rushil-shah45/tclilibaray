import 'package:country_picker/country_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ip_country_lookup/ip_country_lookup.dart';
import 'package:ip_country_lookup/models/ip_country_data_model.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/auth/registration/model/register_model.dart';
import 'package:tcllibraryapp_develop/screens/auth/repository/auth_repository.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/models/country_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class RegistrationController extends GetxController {
  AuthRepository authRepository;
  final SettingsRepository settingsRepository;

  RegistrationController(this.authRepository, this.settingsRepository);

  Rx<List<CountryModel>> countryModel = Rx<List<CountryModel>>([]);
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxInt radioVal = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isCountryLoading = false.obs;
  RxBool isSocialLoading = false.obs;
  String? deviceId = '';
  RxString dialCode = '61'.obs;
  RxString flagIcon = "🇦🇺".obs;
  RxString countryCode = 'AU'.obs;
  RxString countryName = 'Australia'.obs;
  RxBool obscureText = true.obs;
  RxBool obscureConfirmText = true.obs;
  bool isTablet = Get.width >= 600;

  LoginController data = Get.put(LoginController(Get.find()));

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
    // final result = authRepository.getCashedUserInfo();
    // result.fold(
    //   (l) => userRegisterModel = null,
    //   (r) {
    //     user = r;
    //   },
    // );
    super.onInit();
    getCountryInformation();
  }

  RxBool isGettingCountry = false.obs;

  Future<void> getCountryInformation() async {
    try {
      isGettingCountry(true);
      IpCountryData countryData = await IpCountryLookup().getIpLocationData();
      Country country = CountryParser.parseCountryName(countryData.country_name!);
      dialCode.value = country.phoneCode;
      flagIcon.value = country.flagEmoji;
      countryName.value = country.name;
      countryCode.value = country.countryCode;
      isGettingCountry(false);
    } catch (e) {
      isGettingCountry(false);
      print(e);
    }
  }

  changeRadioVal(value) {
    radioVal.value = value;
  }

  void toggle() {
    obscureText.toggle();
    update();
  }

  void toggleConfirm() {
    obscureConfirmText.toggle();
    update();
  }

  bool isFirstNameOkay() {
    if (firstNameController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isLastNameOkay() {
    if (lastNameController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isEmailNameOkay() {
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

  bool isPasswordOkay() {
    if (passwordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isConfirmPasswordOkay() {
    if (confirmPasswordController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isCountryCodeOkay() {
    if (dialCode.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> registration() async {
    isLoading.value = true;
    try {
      deviceId = await FirebaseMessaging.instance.getToken();
    } on FirebaseException catch (e) {
      isLoading.value = false;
      print(e.message);
      // Get.snackbar(e.code, e.message!);
    }

    if (isFirstNameOkay() &&
        isLastNameOkay() &&
        isEmailNameOkay() &&
        isCountryCodeOkay() &&
        isPhoneOkay() &&
        isPasswordOkay() &&
        isConfirmPasswordOkay()) {
      if (passwordController.text == confirmPasswordController.text) {
        final body = <String, String>{};
        body.addAll({"first_name": firstNameController.text.trim()});
        body.addAll({"last_name": lastNameController.text.trim()});
        body.addAll({"email": emailController.text.trim()});
        body.addAll({"phone": phoneController.text.trim()});
        body.addAll({"country_code": countryCode.value.trim().toLowerCase()});
        body.addAll({"password": passwordController.text.trim()});
        body.addAll({"password_confirmation": confirmPasswordController.text.trim()});
        body.addAll({"dial_code": "+${dialCode.value}"});
        body.addAll({"country": countryName.value});
        body.addAll({"device_id": deviceId.toString()});
        final result = await authRepository.userRegister(body);
        result.fold((error) {
          Get.snackbar('Warning', error.message, backgroundColor: Colors.red.shade300, colorText: Colors.white);
          isLoading.value = false;
        }, (data) async {
          userRegisterModel = data;
          firstNameController.text = "";
          lastNameController.text = "";
          emailController.text = "";
          phoneController.text = "";
          passwordController.text = "";
          confirmPasswordController.text = "";
          deviceId = "";
          sharedPreferences.setString("uToken", data.accessToken);
          // cacheUserWithData(data);
          Get.offAndToNamed(Routes.main);
          isLoading.value = false;
        });
      } else {
        Get.snackbar("Warning", "Confirm password not matched");
        isLoading.value = false;
      }
    } else if (!isFirstNameOkay()) {
      Get.snackbar('First name can\'t be empty', 'Please enter your first name');
      isLoading.value = false;
    } else if (!isLastNameOkay()) {
      Get.snackbar('Last name can\'t be empty', 'Please enter your last name');
      isLoading.value = false;
    } else if (!isEmailNameOkay()) {
      Get.snackbar('Email can\'t be empty', 'Please enter your email');
      isLoading.value = false;
    } else if (!isCountryCodeOkay()) {
      Get.snackbar('Country code can\'t be empty', 'Please select your code');
      isLoading.value = false;
    } else if (!isPhoneOkay()) {
      Get.snackbar('Phone number is not valid', 'Please enter a valid phone number');
      isLoading.value = false;
    } else if (!isPasswordOkay()) {
      Get.snackbar('Password can\'t be empty', 'Please enter password');
      isLoading.value = false;
    } else if (!isConfirmPasswordOkay()) {
      Get.snackbar('Confirm password can\'t be empty', 'Please enter confirm password');
      isLoading.value = false;
    }
  }

  void socialLogin(String social) async {
    isSocialLoading(true);
    final result = await authRepository.socialLogin(social);
    result.fold((error) {
      Get.snackbar('Warning', error.message, backgroundColor: Colors.red.shade300, colorText: Colors.black);
      isSocialLoading(false);
    }, (data) async {
      //print("SocialLogInSuccess");
      userRegisterModel = data;
      sharedPreferences.setString("uToken", data.accessToken);

      if (userRegisterModel!.user.phone == '') {
        Get.toNamed(Routes.requiredScreen, arguments: userRegisterModel);
      } else {
        Get.offAndToNamed(Routes.main);
      }
      isSocialLoading(false);
    });
  }
}
