import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tcllibraryapp_develop/data/remote_urls.dart';

import 'error/exception.dart';
import 'models/settings_response_model.dart';

class SettingsDataController extends GetxController {
  SettingsResponseModel? settingsData;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getSettingsData();
  }

  getSettingsData() async {
    final url = Uri.parse(RemoteUrls.settings);
    final headers = {
      'Accept': 'application/json',
    };
    final http.Client client = Get.find();
    final clientMethod = client.get(url, headers: headers);
    http.Response response = await clientMethod;

    if (response.statusCode == 200) {}

    var jsonRes = jsonDecode(response.body);
    
    print("SettingsData: $jsonRes");

    if (jsonRes["status"] == false) {
      final errorMsg = jsonRes["msg"];
      throw UnauthorisedException(errorMsg, 401);
    } else {
      settingsData = SettingsResponseModel.fromJson(jsonRes);
    }
  }
}
