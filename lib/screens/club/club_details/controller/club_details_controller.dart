import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcllibraryapp_develop/data/error/exception.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/model/club_details_model.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/controllers/club_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class ClubDetailsController extends GetxController {
  final LoginController loginController;
  final SettingsRepository settingRepository;
  final ClubController clubController;

  ClubDetailsController(
      this.settingRepository, this.loginController, this.clubController);

  final titleController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final aboutQuillController = TextEditingController();
  final rulesQuillController = TextEditingController();
  // QuillEditorController aboutQuillController = QuillEditorController();
  // QuillEditorController rulesQuillController = QuillEditorController();
  ClubDetailsModel? clubDetailsModel;
  RxInt selectedMenu = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isClubUpdateLoading = false.obs;
  Rx<File> attachmentClub = File('').obs;
  RxString clubFileName = ''.obs;
  Rx<File> attachmentCoverPhoto = File('').obs;
  RxString coverFileName = ''.obs;
  String aboutQuil = '';
  String rulesQuil = '';
  int id = 0;
  var token;
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
    id = Get.arguments;
    getClubDetails();
  }

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

  final tabMenuList = ["Overview", "Discussion", "Members", "Settings"];

  void tabMenuChange(value) {
    selectedMenu.value = value;
    update();
  }

  Future<void> getClubDetails() async {
    isLoading(true);
    final result = await settingRepository.getClubDetails(
        loginController.userInfo?.accessToken ?? token, id.toString());
    result.fold((error) {
      print(error.message);
      isLoading(false);
    }, (data) async {
      clubDetailsModel = data;
      titleController.text = clubDetailsModel!.club.title;
      shortDescriptionController.text = clubDetailsModel!.club.shortDescription;
      aboutQuil = clubDetailsModel!.club.aboutClub;
      rulesQuil = clubDetailsModel!.club.rulesClub;
      isLoading(false);
    });
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

  Future<void> clubUpdate() async {
    isClubUpdateLoading(true);

    if (isTitleOkay() && isProfilePhotoOkay()) {
      // String? aboutQuillText = await aboutQuillController.getText();
      // String? rulesQuillText = await rulesQuillController.getText();

      File file = File(attachmentClub.value.path);
      File file2 = File(attachmentCoverPhoto.value.path);

      if (file.path.isNotEmpty) {
        Uri uri = Uri.parse(RemoteUrls.clubUpdate(id));
        var request = http.MultipartRequest('POST', uri);

        request.files.add(http.MultipartFile.fromBytes(
            'profile_photo', file.readAsBytesSync(),
            filename: file.path));
        if (file2.path.isNotEmpty) {
          request.files.add(http.MultipartFile.fromBytes(
              'cover_photo', file2.readAsBytesSync(),
              filename: file2.path));
        }

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
                getClubDetails();
                Get.snackbar('Successful', 'Club successfully updated');
                isClubUpdateLoading.value = false;
              } else {
                final errorMsg = jsonData["msg"];
                Get.snackbar('Warning', errorMsg.message);
                isClubUpdateLoading.value = false;
                throw UnauthorisedException(errorMsg, value.statusCode);
              }
            });
          } else {
            Get.snackbar('No Internet', value.statusCode.toString());
            isClubUpdateLoading.value = false;
            throw UnauthorisedException('No Internet', value.statusCode);
          }
        });
      } else {
        Get.snackbar('File upload not success', 'Please try again');
        isClubUpdateLoading(false);
      }
    } else if (!isTitleOkay()) {
      Get.snackbar('Name can\'t be empty', 'Please enter your club name');
      isClubUpdateLoading(false);
    } else if (!isProfilePhotoOkay()) {
      Get.snackbar('Club logo can\'t be empty', 'Please select your club logo');
      isClubUpdateLoading(false);
    }
  }

  RxBool isJoinClubLoading = false.obs;
  RxBool isLeaveClubLoading = false.obs;
  RxBool isJoinPending = false.obs;
  RxBool isMemberStatus = false.obs;

  Future<void> joinClub(String clubId) async {
    isJoinClubLoading(true);
    final result = await settingRepository.joinClub(
        loginController.userInfo?.accessToken ?? token, clubId);
    result.fold((error) {
      print(error.message);
      isJoinClubLoading(false);
    }, (data) async {
      getClubDetails();
      Get.snackbar('Success', data);
      isJoinClubLoading(false);
    });
  }

  Future<void> leaveClub(String clubId) async {
    isLeaveClubLoading(true);
    final result = await settingRepository.leaveClub(
        loginController.userInfo?.accessToken ?? token, clubId);
    result.fold((error) {
      print(error.message);
      isLeaveClubLoading(false);
    }, (data) async {
      getClubDetails();
      clubController.getClub();
      Get.back();
      Get.snackbar('Success', data);
      isLeaveClubLoading(false);
    });
  }

  Future<void> memberStatusChange(String memberId, String status) async {
    isMemberStatus(true);
    final result = await settingRepository.memberStatusChange(
        loginController.userInfo?.accessToken ?? token, memberId, status);
    result.fold((error) {
      print(error.message);
      isMemberStatus(false);
    }, (data) async {
      getClubDetails();
      Get.snackbar('Success', data);
      isMemberStatus(false);
    });
  }
}
