import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/controller/club_details_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';

class ClubNewTopicController extends GetxController {
  final LoginController loginController;
  final SettingsRepository settingRepository;
  final ClubDetailsController clubDetailsController;

  ClubNewTopicController(
      this.settingRepository, this.loginController, this.clubDetailsController);

  RxBool isLoading = false.obs;
  RxString fileName = ''.obs;
  Rx<File> fileAttachment = File('').obs;
  TextEditingController quillEditorController = TextEditingController();
  // QuillEditorController quillEditorController = QuillEditorController();
  TextEditingController titleController = TextEditingController();
  int id = 0;
  var token;

  @override
  void onInit() {
    super.onInit();
    getToken();
    id = Get.arguments;
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  setFileBookType(File file) {
    fileAttachment.value = file;
    String parent = '${file.parent.path}/';
    String path = file.path;
    fileName.value = path.replaceAll(parent, '');
  }

  bool isTitleOkay() {
    if (titleController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void createTopic(context) async {
    isLoading(true);
    // String? text = await quillEditorController.getText();

    bool isDescriptionOkay() {
      if (quillEditorController.text.isNotEmpty) {
        return true;
      }
      return false;
    }

    if (isTitleOkay() && isDescriptionOkay()) {
      if (fileName.value.isNotEmpty) {
        Uri uri = Uri.parse(RemoteUrls.createTopic);
        var request = http.MultipartRequest('POST', uri);
        request.files.add(http.MultipartFile.fromBytes(
            'attachment', fileAttachment.value.readAsBytesSync(),
            filename: fileName.value));

        request.headers['Accept'] = 'application/json';
        request.headers['Authorization'] =
            'Bearer ${loginController.userInfo?.accessToken ?? token}';

        request.fields['club_id'] = id.toString();
        request.fields['title'] = titleController.text;
        request.fields['descriptions'] = quillEditorController.text.trim();

        return request.send().then((value) {
          if (value.statusCode == 200) {
            value.stream
                .transform(utf8.decoder)
                .transform(const LineSplitter())
                .listen((event) {
              final jsonData = json.decode(event);
              if (jsonData['status']) {
                quillEditorController.clear();
                titleController.clear();
                Get.snackbar('Topic Started!',
                    'Your topic has been started successfully');
                clubDetailsController.getClubDetails();
                Navigator.pop(context);
                fileName.value = '';
                isLoading.value = false;
              } else {
                final errorMsg = jsonData["msg"];
                Get.snackbar('Warning', errorMsg.message);
                isLoading.value = false;
              }
            });
          } else {
            Get.snackbar('No Internet', value.statusCode.toString());
            isLoading.value = false;
          }
        });
      } else {
        Map<String, dynamic> body = {
          'club_id': id.toString(),
          'title': titleController.text,
          'descriptions': quillEditorController.text.trim(),
        };
        final result = await settingRepository.createTopic(
            loginController.userInfo?.accessToken ?? token, body);
        result.fold((error) {
          print(error.message);
          isLoading(false);
        }, (data) async {
          if (data) {
            quillEditorController.clear();
            titleController.clear();
            Get.snackbar(
                'Topic Started!', 'Your topic has been started successfully');
            Navigator.pop(context);
            clubDetailsController.getClubDetails();
          }
          isLoading(false);
        });
      }
    } else if (!isTitleOkay()) {
      Get.snackbar('Title can\'t be empty', 'Please enter your title');
      isLoading(false);
    } else if (!isDescriptionOkay()) {
      Get.snackbar(
          'Description can\'t be empty', 'Please enter your description');
      isLoading(false);
    }
  }
}
