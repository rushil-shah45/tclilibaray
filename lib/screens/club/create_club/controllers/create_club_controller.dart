import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcllibraryapp_develop/data/error/exception.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class CreateClubController extends GetxController {
  final SettingsRepository settingRepository;
  final LoginController loginController;

  CreateClubController(this.settingRepository, this.loginController);

  final titleController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final aboutQuillController = TextEditingController();
  final rulesQuillController = TextEditingController();
  // QuillEditorController aboutQuillController = QuillEditorController();
  // QuillEditorController rulesQuillController = QuillEditorController();
  RxBool clubStoreLoading = false.obs;
  Rx<File> attachmentClub = File('').obs;
  RxString clubFileName = ''.obs;
  Rx<File> attachmentCoverPhoto = File('').obs;
  RxString coverFileName = ''.obs;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  var token;

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  setClubThumbnail(File file) {
    attachmentClub.value = file;
    String parent = '${file.parent.path}/';
    String path = file.path;
    clubFileName.value = path.replaceAll(parent, '');
  }

  setClubCoverThumbnail(File file) {
    attachmentCoverPhoto.value = file;
    String parent = '${file.parent.path}/';
    String path = file.path;
    coverFileName.value = path.replaceAll(parent, '');
  }

  bool isTitleOkay() {
    if (titleController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isProfilePhotoOkay() {
    if (attachmentClub.value.path.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> clubStore() async {
    clubStoreLoading(true);

    if (isTitleOkay() && isProfilePhotoOkay()) {
      // String? aboutQuillText = await aboutQuillController.text;
      // String? rulesQuillText = await rulesQuillController.text;

      File file = File(attachmentClub.value.path);
      File file2 = File(attachmentCoverPhoto.value.path);

      if (file.path.isNotEmpty) {
        Uri uri = Uri.parse(RemoteUrls.clubStore);
        var request = http.MultipartRequest('POST', uri);

        request.files.add(http.MultipartFile.fromBytes(
            'profile_photo', file.readAsBytesSync(),
            filename: file.path));

        request.files.add(http.MultipartFile.fromBytes(
            'cover_photo', file.readAsBytesSync(),
            filename: file2.path));

        request.headers['Accept'] = 'application/json';
        request.headers['Authorization'] =
            'Bearer ${loginController.userInfo?.accessToken ?? token}';

        request.fields['title'] = titleController.text.trim();
        request.fields['short_description'] =
            shortDescriptionController.text.trim();
        request.fields['about'] = aboutQuillController.text.trim();
        request.fields['rules'] = rulesQuillController.text.trim();

        return request.send().then((value) {
          if (value.statusCode == 200) {
            value.stream
                .transform(utf8.decoder)
                .transform(const LineSplitter())
                .listen((event) async {
              final jsonData = json.decode(event);
              if (jsonData['status']) {
                Get.offNamed(Routes.clubScreen);
                Get.snackbar('Success',
                    'Club Created Successfully. Please wait for Admin approval.',
                    duration: const Duration(seconds: 5));
                clubStoreLoading.value = false;
              } else {
                final errorMsg = jsonData["msg"];
                Get.snackbar('Warning', errorMsg.message);
                clubStoreLoading.value = false;
                throw UnauthorisedException(errorMsg, value.statusCode);
              }
            });
          } else {
            Get.snackbar('No Internet', value.statusCode.toString());
            clubStoreLoading.value = false;
            throw UnauthorisedException('No Internet', value.statusCode);
          }
        });
      } else {
        Get.snackbar('File upload not success', 'Please try again');
        clubStoreLoading(false);
      }
    } else if (!isTitleOkay()) {
      Get.snackbar('Club name can\'t be empty', 'Please enter your club name');
      clubStoreLoading(false);
    } else if (!isProfilePhotoOkay()) {
      Get.snackbar('Club profile photo can\'t be empty',
          'Please chose your club profile photo');
      clubStoreLoading(false);
    }
  }
}
