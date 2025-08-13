import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/main.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/ticket/model/ticket_details_model.dart';
import 'package:tcllibraryapp_develop/screens/ticket/repository/ticket_repository.dart';

class ViewTicketController extends GetxController {
  final LoginController loginController;
  final TicketRepository ticketRepository;
  ViewTicketController(this.loginController, this.ticketRepository);

  RxBool isLoading = false.obs;
  RxBool isSendBtnLoading = false.obs;
  final messageCtrl = TextEditingController();
  int id = 0;
  var token;
  RxString fileName = ''.obs;
  RxString attachedLength = '0'.obs;
  Rx<File> attachment = File('').obs;
  FilePickerResult? result;
  Rxn<TicketDetailsModel> ticketDetailsModelList = Rxn<TicketDetailsModel>();
  List<Details> ticketDetails = [];
  bool isTablet = Get.width >= 600;

  @override
  void onInit() {
    super.onInit();
    getToken();
    id = Get.arguments;
    getUserTicketDetails();
  }

  getToken() {
    token = sharedPreferences.getString("uToken");
  }

  setFile(File file) {
    attachment.value = file;
    String parent = '${file.parent.path}/';
    String path = file.path;
    fileName.value = path.replaceAll(parent, '');
  }

  Future<void> getUserTicketDetails() async {
    isLoading.value = true;
    final result = await ticketRepository.getUserTicketDetails(
        id.toString(), loginController.userInfo?.accessToken ?? token);
    result.fold((error) {
      print(error.message);
      isLoading.value = false;
    }, (data) async {
      ticketDetailsModelList.value = data;
      ticketDetails = ticketDetailsModelList.value!.details!.reversed.toList();
      isLoading.value = false;
    });
  }

  Future<void> userTicketReply() async {
    isSendBtnLoading.value = true;
    if (fileName.value.isNotEmpty) {
      Uri uri = Uri.parse(RemoteUrls.userTicketReplay);
      var request = http.MultipartRequest('POST', uri);
      request.files.add(http.MultipartFile.fromBytes(
          'attachment', attachment.value.readAsBytesSync(),
          filename: attachment.value.path));

      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] =
          'Bearer ${loginController.userInfo?.accessToken ?? token}';

      request.fields['ticketid'] = id.toString();
      request.fields['message'] = messageCtrl.text;

      return request.send().then((value) {
        if (value.statusCode == 200) {
          value.stream
              .transform(utf8.decoder)
              .transform(const LineSplitter())
              .listen((event) {
            final jsonData = json.decode(event);
            if (jsonData['status']) {
              isSendBtnLoading.value = false;
              fileName.value = "";
              messageCtrl.text = "";
              attachment.value.existsSync()
                  ? attachment.value.deleteSync()
                  : null;
              Get.snackbar('Success', 'Your reply is successfully send.');
              isLoading.value = false;
              getUserTicketDetails();
            } else {
              final errorMsg = jsonData["message"];
              isSendBtnLoading.value = false;
              Get.snackbar('Warning', errorMsg.message);
              isLoading.value = false;
            }
          });
        }
      });
    } else {
      Map<String, dynamic> body = {
        'ticketid': id.toString(),
        'message': messageCtrl.text,
      };

      final result = await ticketRepository.userTicketReply(
          body, loginController.userInfo?.accessToken ?? token);
      result.fold((error) {
        isSendBtnLoading.value = false;
        Get.snackbar("Warning", error.message);
      }, (data) async {
        isSendBtnLoading.value = false;
        fileName.value = "";
        messageCtrl.text = "";
        attachment.value.existsSync() ? attachment.value.deleteSync() : null;
        Get.snackbar("Success", data);
        getUserTicketDetails();
      });
    }
  }
}
