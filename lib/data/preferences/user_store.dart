import 'dart:convert';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/data/preferences/constants.dart';
import 'package:tcllibraryapp_develop/screens/auth/registration/model/register_model.dart';
import 'storage_service.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();
  String accessToken = '';

  Future<void> setToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_TOKEN_KEY, value);
    accessToken = value;
  }

  Future<void> setCredit(String value) async {
    await StorageService.to.setString(STORAGE_CREDITS_KEY, value);
  }

  Future<void> setOnBoardingCheck(String value) async {
    await StorageService.to.setString(STORAGE_USER_ON_BOARDING, value);
  }

  Future<void> saveProfile(UserRegisterModel userRegisterModel) async {
    await StorageService.to.setBool(STORAGE_IS_LOG_IN, true);
    await StorageService.to.setString(
      STORAGE_USER_PROFILE_KEY,
      json.encode(userRegisterModel.toJson()),
    );
    await setToken(userRegisterModel.accessToken);
  }

  Future<void> onLogout() async {
    await StorageService.to.remove(STORAGE_USER_TOKEN_KEY);
    await StorageService.to.remove(STORAGE_USER_PROFILE_KEY);
    await StorageService.to.remove(STORAGE_IS_LOG_IN);
    accessToken = '';
  }
}
