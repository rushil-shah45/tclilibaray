import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller/update_book_controller.dart';

class UpdateBookScreen extends GetView<UpdateBookController> {
  const UpdateBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpdateBookController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new)),
            title: Text("Edit Books", style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
          centerTitle: true,

        ),
        body: PageView(
          controller: controller.pageController,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          children: controller.screenList,
        ),
      );
    });
  }
}
