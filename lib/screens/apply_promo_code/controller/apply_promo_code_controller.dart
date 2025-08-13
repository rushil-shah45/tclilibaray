import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class ApplyPromoCodeController extends GetxController {
  final SettingsRepository settingRepository;
  final LoginController loginController;

  ApplyPromoCodeController(this.settingRepository, this.loginController);

  final codeController = TextEditingController();
  RxString applyType = ''.obs;
  RxBool isLoading = false.obs;
  Rx<List<String>> applyItems = Rx<List<String>>([]);

  final Map<String, String> applyNames = {
    'Book': 'book',
    'Package': 'package',
  };

  @override
  void onInit() {
    getToken();
    super.onInit();
    applyItems.value = applyNames.keys.toList();
  }

  var token;
  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  void changeSizeItemValue(val) {
    applyType.value = val;
    update();
  }

  bool isCodeOkay() {
    if (codeController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isApplyTypeOkay() {
    if (applyType.value.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> applyPromoCode(context) async {
    isLoading(true);
    if (isApplyTypeOkay() && isCodeOkay()) {
      String applyName = applyNames[applyType.value.trim()] ?? '';

      Map<String, dynamic> body = {
        'apply_for': applyName,
        'code': codeController.text.trim(),
      };

      final result = await settingRepository.applyPromoCode(
          loginController.userInfo?.accessToken ?? token, body);
      result.fold((error) {
        Get.snackbar('Warning', error.message);
        isLoading(false);
      }, (data) async {
        Get.snackbar('Success', data);
        Navigator.pop(context);
        isLoading(false);
      });
    } else if (!isApplyTypeOkay()) {
      Get.snackbar(
          'Apply type can\'t be empty', 'Please select your apply type');
      isLoading(false);
    } else if (!isCodeOkay()) {
      Get.snackbar(
          'Promo Code can\'t be empty', 'Please enter your promo code');
      isLoading(false);
    }
  }
}
