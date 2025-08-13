import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/ticket/controller/ticket_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';

class AddTicketScreen extends GetView<TicketController> {
  const AddTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TicketController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () {
                    Get.back();
                  }),
              title: Text(
                "Add New",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              )),
          body: Obx(
            () => CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomRichText(title: 'Subject ', star: "*"),
                        SizedBox(
                          height: Get.height / 14,
                          child: TextFormField(
                            controller: controller.subjectCtrl,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Subject",
                              contentPadding: EdgeInsets.only(
                                  top: 25.h, left: 10.w, right: 10.w),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    const BorderSide(color: primaryColor),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                            ),
                          ),
                        ),
                        const CustomRichText(title: 'Priority ', star: "*"),
                        SizedBox(
                          height: Get.height / 14,
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            decoration: InputDecoration(
                              hintText: "Priority",
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                  top: 25.h, left: 10.w, right: 10.w),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: redColor),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            value: controller.selectedPriority.value == ""
                                ? null
                                : controller.selectedPriority.value,
                            items: controller.priorityList
                                .map<DropdownMenuItem>((e) {
                              return DropdownMenuItem(
                                value: e["id"],
                                child: Text(e["name"]),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              controller.changeItemValue(newValue.toString());
                            },
                          ),
                        ),
                        const CustomRichText(title: 'Attachment'),
                        Container(
                          height: Get.height / 16.7,
                          width: Get.width,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  FilePickerResult? result =
                                      await FilePicker.platform.pickFiles();
                                  if (result != null) {
                                    controller.setFile(
                                        File(result.files.single.path!));
                                  } else {
                                    // User canceled the file picker
                                  }
                                },
                                child: Container(
                                  height: Get.height / 14,
                                  width: Get.width / 4,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Choose File',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              SizedBox(
                                height: Get.height,
                                width: Get.width / 2,
                                child: controller.fileName.value == ""
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "No file chosen",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp),
                                        ),
                                      )
                                    : Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          controller.fileName.value,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.h),
                        const CustomRichText(title: 'Message ', star: "*"),
                        TextFormField(
                          controller: controller.messageCtrl,
                          maxLines: 4,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: "Message",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide: const BorderSide(color: primaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.r),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Obx(
                          () => controller.btnIsLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : Center(
                                  child: CustomBtn(
                                    width: Get.width / 5,
                                    text: 'Submit',
                                    callback: () {
                                      controller.createTicket();
                                    },
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
