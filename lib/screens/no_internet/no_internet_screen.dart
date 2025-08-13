import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/no_internet/controller/no_internet_controller.dart';

class NoInternetScreen extends GetView<NoInternetController> {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () async {
            try {
              controller.isLoading.value = true;
              final result = await InternetAddress.lookup('example.com');
              if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                controller.checkInternet();
              } else {
                Get.snackbar("Network Error", "No Internet Connection");
              }
            } on SocketException catch (_) {
              Get.snackbar("Network Error", "No Internet Connection");
            } finally {
              controller.isLoading.value = false;
            }
          },
          child: Obx(() => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Text(
                        "Please check your \nInternet Connection",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Icon(
                      Icons.rotate_right,
                      size: 30,
                    )
                  ],
                )),
        ),
      ),
    );
  }
}
