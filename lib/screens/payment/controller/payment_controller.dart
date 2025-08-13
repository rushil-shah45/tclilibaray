import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/models/country_model.dart';
import 'package:tcllibraryapp_develop/screens/payment/views/in_app_webview.dart';
import 'package:tcllibraryapp_develop/screens/pricing/model/pricing_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';
import 'package:uuid/uuid.dart';

import '../../pricing/controller/pricing_controller.dart';

class PaymentController extends GetxController {
  final SettingsRepository settingsRepository;
  final LoginController loginController;
  final MainController mainController;
  final SettingsController settingsController;
  final DashboardController dashboardController;
  final PricingController pricingController;

  PaymentController(
      this.settingsRepository,
      this.mainController,
      this.loginController,
      this.dashboardController,
      this.pricingController,
      this.settingsController);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final billingAddressController = TextEditingController();
  final billingCityController = TextEditingController();
  final billingStateController = TextEditingController();
  final billingZipCodeController = TextEditingController();
  final billingSelectedCountryController = TextEditingController();
  final phoneController = TextEditingController();
  Rx<List<CountryModel>> countryModel = Rx<List<CountryModel>>([]);
  Rxn<PricingModel> pricingModel = Rxn<PricingModel>();
  RxBool isLoading = false.obs;
  RxBool makingPayment = false.obs;
  RxBool isSelected = false.obs;
  Rx<List<String>> userItems = Rx<List<String>>([]);
  var token;
  RxString userType = ''.obs;
  RxString dialCode = '61'.obs;
  RxString flagIcon = "🇦🇺".obs;
  RxString countryCodeName = "AU".obs;
  RxString url = "".obs;
  RxString tranxId = ''.obs;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
    getCountryData();
    pricingModel.value = Get.arguments;
    userItems.value = ["Personal", "Business"];
    nameController.text = "${mainController.userProfileModel?.billingName}";
    emailController.text = "${mainController.userProfileModel?.billingEmail}";
    billingAddressController.text =
        "${mainController.userProfileModel?.address}";
    billingCityController.text = "${mainController.userProfileModel?.city}";
    billingStateController.text = "${mainController.userProfileModel?.state}";
    billingZipCodeController.text =
        "${mainController.userProfileModel?.zipcode}";
    billingSelectedCountryController.text =
        "${mainController.userProfileModel?.country}";
    userType.value = "${mainController.userProfileModel?.type}";
    dialCode.value = mainController.userProfileModel?.billingDialCode == ''
        ? ''
        : "${mainController.userProfileModel?.billingDialCode.substring(1)}";
    phoneController.text = "${mainController.userProfileModel?.billingPhone}";
    countryCodeName.value =
        "${mainController.userProfileModel?.billingCountryCode}";
    if (mainController.userProfileModel?.billingCountryCode != '') {
      Country country = CountryParser.parseCountryCode(
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

  changeItemValue(val) {
    dialCode.value = val;
  }

  changeSelected(val) {
    isSelected.value = val;
  }

  void changeSizeItemValue(val) {
    userType.value = val;
    update();
  }

  void change(val) {
    billingSelectedCountryController.text = val;
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

  // Future<void> makeFlutterWavePayment(context) async {
  //   final Customer customer = Customer(
  //       name: nameController.text,
  //       phoneNumber: phoneController.text,
  //       email: emailController.text);
  //   final Flutterwave flutterwave = Flutterwave(
  //     context: context,
  //     publicKey: PUBLIC_KEY,
  //     currency: "NGN",
  //     redirectUrl: 'https://facebook.com',
  //     txRef: Uuid().v1(),
  //     paymentPlanId: pricingModel.value!.flutterPlan,
  //     amount: pricingModel.value!.priceNgn,
  //     customer: customer,
  //     paymentOptions: "ussd, card, barter, payattitude",
  //     customization: Customization(title: "TCLI Library Payment"),
  //     isTestMode: true,
  //   );
  //   final ChargeResponse response = await flutterwave.charge();
  //   if (response.success!) {
  //     tranxId.value = response.transactionId!;
  //     print(tranxId.value);
  //     makePaypalPayment('flutterwave');
  //   } else {
  //     Get.snackbar('Warning', response.status!);
  //   }
  // }

  Future<void> flutterWaveApi() async {
    Map<String, dynamic> body = {};

    final result = await settingsRepository.flutterWaveApi(
        body, loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      makingPayment.value = false;
    }, (data) async {
      Get.snackbar('Successful', data);
      makingPayment.value = false;
    });
  }

  bool isBillingNameOkay() {
    if (nameController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingEmailOkay() {
    if (emailController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingAddressOkay() {
    if (billingAddressController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingCityOkay() {
    if (billingCityController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingStateOkay() {
    if (billingStateController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingZipCodeOkay() {
    if (billingZipCodeController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingCountryOkay() {
    if (billingSelectedCountryController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isBillingTypeOkay() {
    if (userType.value.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isPhoneNumberValid(String phoneNumber) {
    RegExp regExp = RegExp(r'^[0-9]+$'); // Only allow digits
    return regExp.hasMatch(phoneNumber);
  }

  bool isBillingPhoneOkay() {
    String phoneNumber = phoneController.text.trim();
    if (phoneController.text.isNotEmpty && isPhoneNumberValid(phoneNumber)) {
      return true;
    }
    return false;
  }

  Future<void> makePaypalPayment(String name) async {
    log("Pricing Model ID  : ${pricingModel.value!.id}");
    if (isBillingNameOkay() &&
        isBillingEmailOkay() &&
        isBillingAddressOkay() &&
        isBillingCityOkay() &&
        isBillingStateOkay() &&
        isBillingZipCodeOkay() &&
        isBillingCountryOkay() &&
        isBillingTypeOkay() &&
        isBillingPhoneOkay()) {
      Map<String, dynamic> body = {
        'billing_name': nameController.text,
        'billing_email': emailController.text,
        'billing_country': billingSelectedCountryController.text,
        'billing_country_code': countryCodeName.value.trim(),
        'billing_dial_code': '+${dialCode.value.trim()}',
        'billing_phone': phoneController.text.trim(),
        'type': userType.value.capitalizeFirst,
        'billing_address': billingAddressController.text,
        'billing_state': billingStateController.text,
        'billing_city': billingCityController.text,
        'billing_zipcode': billingZipCodeController.text,
        'payment_method': name,
        'billing_for': "plan",
      };

      makingPayment(true);
      if (name == 'flutterwave') {
        body.addAll({'transaction_id': tranxId.value});
      }

      final result = await settingsRepository.makePaypalPayment(
          body,
          loginController.userInfo?.accessToken ?? token,
          pricingModel.value!.id);
      result.fold((error) {
        //print(error);
        makingPayment.value = false;
      }, (data) async {
        if (name == 'paypal') {
          log("Getting url data : ${data}");
          Get.to(InAppWeb(
              url: data,
              onSuccess: (val) {
                makeSubscription(val);
              },
              onError: (val) {
                Get.snackbar('Warning', val.toString());
              },
              onCancel: (val) {
                Get.snackbar('Warning', val.toString());
              }));
          // Get.snackbar('Successful', data);
          makingPayment(false);
        } else {
          print("Paypal payment done1");
          Get.snackbar('Successful', data);
          dashboardController.getDashboardData();
          settingsController.getUserProfile();
          mainController.getUserProfile();
          pricingController.getPricing();
          Navigator.pop(Get.context!);
          Navigator.pop(Get.context!);
          makingPayment(false);
        }
      });
    } else if (!isBillingNameOkay()) {
      Get.snackbar('Billing name can\'t be empty', 'Please enter billing name');
      makingPayment.value = false;
    } else if (!isBillingEmailOkay()) {
      Get.snackbar(
          'Billing email can\'t be empty', 'Please enter billing email');
      makingPayment.value = false;
    } else if (!isBillingAddressOkay()) {
      Get.snackbar(
          'Billing address can\'t be empty', 'Please enter billing address');
      makingPayment.value = false;
    } else if (!isBillingCityOkay()) {
      Get.snackbar('Billing city can\'t be empty', 'Please enter billing city');
      makingPayment.value = false;
    } else if (!isBillingStateOkay()) {
      Get.snackbar(
          'Billing state can\'t be empty', 'Please enter billing state');
      makingPayment.value = false;
    } else if (!isBillingZipCodeOkay()) {
      Get.snackbar(
          'Billing zip code can\'t be empty', 'Please enter billing zip code');
      makingPayment.value = false;
    } else if (!isBillingCountryOkay()) {
      Get.snackbar('Billing country can\'t be empty',
          'Please select your billing country');
      makingPayment.value = false;
    } else if (!isBillingTypeOkay()) {
      Get.snackbar(
          'Billing type can\'t be empty', 'Please select your billing type');
      makingPayment.value = false;
    } else if (!isBillingPhoneOkay()) {
      Get.snackbar('Billing phone number is not valid',
          'Please valid billing phone number');
      makingPayment.value = false;
    }
  }

  Future<void> makeFreePayment() async {
    if (isBillingNameOkay() &&
        isBillingEmailOkay() &&
        isBillingAddressOkay() &&
        isBillingCityOkay() &&
        isBillingStateOkay() &&
        isBillingZipCodeOkay() &&
        isBillingCountryOkay() &&
        isBillingTypeOkay() &&
        isBillingPhoneOkay()) {
      Map<String, dynamic> body = {
        'billing_name': nameController.text,
        'billing_email': emailController.text,
        'billing_country': billingSelectedCountryController.text,
        'billing_country_code': countryCodeName.value.trim(),
        'billing_dial_code': '+${dialCode.value.trim()}',
        'billing_phone': phoneController.text.trim(),
        'type': userType.value.capitalizeFirst,
        'billing_address': billingAddressController.text,
        'billing_state': billingStateController.text,
        'billing_city': billingCityController.text,
        'billing_zipcode': billingZipCodeController.text,
        // 'payment_method': name,
        'billing_for': 'plan'
      };

      makingPayment(true);
      // if (name == 'flutterwave') {
      //   body.addAll({'transaction_id': tranxId.value});
      // }

      final result = await settingsRepository.makeFreePayment(
          body,
          loginController.userInfo?.accessToken ?? token,
          pricingModel.value!.id);
      result.fold((error) {
        print(error);
        makingPayment.value = false;
      }, (data) async {
        print("MakeFreePayment Free");
        Get.snackbar('Successful', data);
        dashboardController.getDashboardData();
        settingsController.getUserProfile();
        mainController.getUserProfile();
        pricingController.getPricing();
        Navigator.pop(Get.context!);
        Navigator.pop(Get.context!);
        makingPayment(false);
      });
    } else if (!isBillingNameOkay()) {
      Get.snackbar('Billing name can\'t be empty', 'Please enter billing name');
      makingPayment.value = false;
    } else if (!isBillingEmailOkay()) {
      Get.snackbar(
          'Billing email can\'t be empty', 'Please enter billing email');
      makingPayment.value = false;
    } else if (!isBillingAddressOkay()) {
      Get.snackbar(
          'Billing address can\'t be empty', 'Please enter billing address');
      makingPayment.value = false;
    } else if (!isBillingCityOkay()) {
      Get.snackbar('Billing city can\'t be empty', 'Please enter billing city');
      makingPayment.value = false;
    } else if (!isBillingStateOkay()) {
      Get.snackbar(
          'Billing state can\'t be empty', 'Please enter billing state');
      makingPayment.value = false;
    } else if (!isBillingZipCodeOkay()) {
      Get.snackbar(
          'Billing zip code can\'t be empty', 'Please enter billing zip code');
      makingPayment.value = false;
    } else if (!isBillingCountryOkay()) {
      Get.snackbar('Billing country can\'t be empty',
          'Please select your billing country');
      makingPayment.value = false;
    } else if (!isBillingTypeOkay()) {
      Get.snackbar(
          'Billing type can\'t be empty', 'Please select your billing type');
      makingPayment.value = false;
    } else if (!isBillingPhoneOkay()) {
      Get.snackbar('Billing phone number is not valid',
          'Please valid billing phone number');
      makingPayment.value = false;
    }
  }

  Future<void> makeSubscription(String url) async {
    final result = await settingsRepository.makeSubscription(
        url, loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      makingPayment.value = false;
    }, (data) async {
      print("Paypal payment done2");
      Get.snackbar('Successful', data);
      dashboardController.getDashboardData();
      settingsController.getUserProfile();
      mainController.getUserProfile();
      pricingController.getPricing();
      Navigator.pop(Get.context!);
      Navigator.pop(Get.context!);
      // Get.offAndToNamed(Routes.main);
      // Navigator.pushNamedAndRemoveUntil(Get.context!, Routes.main, (route) => false);
      makingPayment.value = false;
    });
  }
}
