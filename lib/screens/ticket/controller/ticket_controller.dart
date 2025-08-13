import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/ticket/model/ticket_model.dart';
import 'package:tcllibraryapp_develop/screens/ticket/repository/ticket_repository.dart';

class TicketController extends GetxController {
  final LoginController loginController;
  final TicketRepository ticketRepository;

  TicketController(this.loginController, this.ticketRepository);

  final subjectCtrl = TextEditingController();
  final messageCtrl = TextEditingController();
  RxBool isLoading = false.obs;
  RxBool btnIsLoading = false.obs;
  List<TicketModel> ticketModelList = [];
  RxInt popupMenuItemIndex = 0.obs;
  Color changeColorAccordingToMenuItem = Colors.red;
  RxString fileName = ''.obs;
  Rx<File> attachment = File('').obs;
  RxString selectedPriority = "".obs;
  var token;
  bool isTablet = Get.width >= 600;

  List priorityList = [
    {"name": "High", "id": "3"},
    {"name": "Medium", "id": "2"},
    {"name": "Low", "id": "1"},
  ];

  @override
  void onInit() {
    super.onInit();
    getToken();
    getUserTicket();
    selectedPriority.value = "";
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  void changeItemValue(val) {
    selectedPriority.value = val;
    update();
  }

  setFile(File file) {
    attachment.value = file;
    String parent = '${file.parent.path}/';
    String path = file.path;
    fileName.value = path.replaceAll(parent, '');
  }

  Future<void> getUserTicket() async {
    isLoading.value = true;
    final result = await ticketRepository
        .getUserTicket(loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      ticketModelList = data;
      isLoading.value = false;
    });
  }

  Future<void> deleteUserTicket(String id) async {
    final result = await ticketRepository.deleteUserTicket(
        loginController.userInfo?.accessToken ?? token, id);
    result.fold((error) {
      print(error.message);
      Get.snackbar("Warning", error.message);
    }, (data) async {
      Get.snackbar("Success", data);
      getUserTicket();
    });
  }

  bool isSubjectOkay() {
    if (subjectCtrl.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isPriorityOkay() {
    if (selectedPriority.value.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool isMessageOkay() {
    if (messageCtrl.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  void createTicket() async {
    btnIsLoading.value = true;

    if (isSubjectOkay() && isPriorityOkay() && isMessageOkay()) {
      if (fileName.value.isNotEmpty) {
        Uri uri = Uri.parse(RemoteUrls.createUserTicket);
        var request = http.MultipartRequest('POST', uri);
        request.files.add(http.MultipartFile.fromBytes(
            'attachment', attachment.value.readAsBytesSync(),
            filename: attachment.value.path));

        request.headers['Accept'] = 'application/json';
        request.headers['Authorization'] = 'Bearer $token';

        request.fields['subject'] = subjectCtrl.text;
        request.fields['message'] = messageCtrl.text;
        request.fields['priority'] = selectedPriority.value;

        return request.send().then((value) {
          if (value.statusCode == 200) {
            value.stream
                .transform(utf8.decoder)
                .transform(const LineSplitter())
                .listen((event) {
              final jsonData = json.decode(event);
              if (jsonData['status']) {
                btnIsLoading.value = false;
                selectedPriority.value = "";
                fileName.value = "";
                subjectCtrl.text = "";
                messageCtrl.text = "";
                attachment.value.existsSync()
                    ? attachment.value.deleteSync()
                    : null;
                Get.snackbar('Success', 'Ticket is successfully created.');
                isLoading.value = false;
                getUserTicket().then((value) {
                  Navigator.pop(Get.context!);
                });
              } else {
                final errorMsg = jsonData["message"];
                btnIsLoading.value = false;
                Get.snackbar('Warning', errorMsg.message);
                isLoading.value = false;
              }
            });
          }
        });
      } else {
        Map<String, dynamic> body = {
          'subject': subjectCtrl.text,
          'priority': selectedPriority.value,
          'message': messageCtrl.text,
        };
        final result = await ticketRepository.createUserTicket(body, "$token");
        result.fold((error) {
          btnIsLoading.value = false;
          Get.snackbar("Warning", error.message);
        }, (data) async {
          btnIsLoading.value = false;
          selectedPriority.value = "";
          fileName.value = "";
          subjectCtrl.text = "";
          messageCtrl.text = "";
          attachment.value.existsSync() ? attachment.value.deleteSync() : null;
          Get.snackbar("Success", data);
          getUserTicket().then((value) {
            Navigator.pop(Get.context!);
          });
        });
      }
    } else if (!isSubjectOkay()) {
      Get.snackbar('Subject can\'t be empty', 'Please enter your subject');
      btnIsLoading(false);
    } else if (!isPriorityOkay()) {
      Get.snackbar('Priority can\'t be empty', 'Please enter your priority');
      btnIsLoading(false);
    } else if (!isMessageOkay()) {
      Get.snackbar('Message can\'t be empty', 'Please enter your message');
      btnIsLoading(false);
    }
  }

  onMenuItemSelected(int value, int id, context) {
    popupMenuItemIndex.value = value;

    if (value == Options.view.index) {
      Get.toNamed(Routes.viewTicket, arguments: id)!.then((value) {
        getUserTicket();
      });
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          title: Column(
            children: [
              Text(
                'Are you sure to delete this ticket?',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.red,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                deleteUserTicket(id.toString()).then((value) {
                  // ticketModelList.removeWhere((element) => element.pkNo == id);
                  ticketModelList = [];
                  getUserTicket();
                });
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      );
      // deleteUserTicket(id.toString()).then((value) {
      //   // ticketModelList.removeWhere((element) => element.pkNo == id);
      //   getUserTicket();
      // });
    }
  }
}

enum Options { view, delete }
