import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'controller/add_book_controller.dart';

class AddBookScreen extends GetView<AddBookController> {
  const AddBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddBookController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              }),
          title: Text("Add Books",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
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
