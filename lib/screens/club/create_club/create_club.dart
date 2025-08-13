import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/club/create_club/controllers/create_club_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

class CreateClubScreen extends GetView<CreateClubController> {
  const CreateClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text(
          "Club Details",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(
                left: 16.w, right: 16.w, top: 5.h, bottom: 20.h),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomRichText(title: 'Name'),
                  CustomTextField(
                    controller: controller.titleController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Club Name",
                  ),

                  ///Club Logo
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomRichText(title: 'Club Logo '),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "[Recommended size : 150 x 150]",
                              style: TextStyle(
                                  fontSize: controller.isTablet ? 9.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: Get.height / 16.7,
                        width: Get.width,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                    'png',
                                    'jpeg',
                                    'jpg',
                                    'svg'
                                  ],
                                );
                                if (result != null) {
                                  if (result.files.isNotEmpty) {
                                    controller.setClubThumbnail(
                                        File(result.files.single.path!));
                                  }
                                } else {}
                              },
                              child: Container(
                                width: Get.width / 4,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Choose File',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Obx(
                              () => SizedBox(
                                height: Get.height,
                                width: Get.width / 2,
                                child: controller.clubFileName.value == ""
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
                                          controller.clubFileName.value,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),

                  ///Cover Photo
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomRichText(title: 'Cover Photo '),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.h),
                            child: Text(
                              "[Recommended size : 1024 x 150]",
                              style: TextStyle(
                                fontSize: controller.isTablet ? 9.sp : 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: Get.height / 16.7,
                        width: Get.width,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                FilePickerResult? result =
                                    await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: [
                                    'png',
                                    'jpeg',
                                    'jpg',
                                    'svg'
                                  ],
                                );
                                if (result != null) {
                                  if (result.files.isNotEmpty) {
                                    controller.setClubCoverThumbnail(
                                        File(result.files.single.path!));
                                  }
                                } else {}
                              },
                              child: Container(
                                width: Get.width / 4,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Choose File',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Obx(
                              () => SizedBox(
                                height: Get.height,
                                width: Get.width / 2,
                                child: controller.coverFileName.value == ""
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
                                          controller.coverFileName.value,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12.sp),
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  const CustomRichText(title: 'Short Description'),
                  CustomTextField(
                    controller: controller.shortDescriptionController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    hintText: "Club short description",
                    maxLines: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomRichText(title: 'About'),
                  CustomTextField(
                    height: Get.height / 3.5,
                    controller: controller.aboutQuillController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    hintText: "About Type Here,",
                    maxLines: 10,
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(2),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black),
                  //     borderRadius: BorderRadius.circular(8.r),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       // ToolBar(
                  //       //     toolBarColor: Colors.grey.withOpacity(0.2),
                  //       //     activeIconColor: primaryColor,
                  //       //     padding: const EdgeInsets.all(8),
                  //       //     iconSize: 20,
                  //       //     controller: controller.aboutQuillController),
                  //       // QuillHtmlEditor(
                  //       //   controller: controller.aboutQuillController,
                  //       //   isEnabled: true,
                  //       //   minHeight: Get.height / 3.5,
                  //       //   hintTextAlign: TextAlign.start,
                  //       //   padding: EdgeInsets.only(left: 10.w, top: 5.h),
                  //       //   hintTextPadding: EdgeInsets.zero,
                  //       //   loadingBuilder: (context) {
                  //       //     return const Center(
                  //       //         child: CircularProgressIndicator());
                  //       //   },
                  //       // ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  const CustomRichText(title: 'Rules'),
                  CustomTextField(
                    height: Get.height / 3.5,
                    controller: controller.rulesQuillController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    hintText: "Rules Type Here,",
                    maxLines: 10,
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(2),
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black),
                  //     borderRadius: BorderRadius.circular(8.r),
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       ToolBar(
                  //           toolBarColor: Colors.grey.withOpacity(0.2),
                  //           activeIconColor: primaryColor,
                  //           padding: const EdgeInsets.all(8),
                  //           iconSize: 20,
                  //           controller: controller.rulesQuillController),
                  //       QuillHtmlEditor(
                  //         controller: controller.rulesQuillController,
                  //         isEnabled: true,
                  //         minHeight: Get.height / 3.5,
                  //         hintTextAlign: TextAlign.start,
                  //         padding: EdgeInsets.only(left: 10.w, top: 5.h),
                  //         hintTextPadding: EdgeInsets.zero,
                  //         loadingBuilder: (context) {
                  //           return const Center(
                  //               child: CircularProgressIndicator());
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 20.h),
                  Obx(
                    () => controller.clubStoreLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : Center(
                            child: CustomBtn(
                              width: 200,
                              height: 45,
                              text: 'Add',
                              size: 18.sp,
                              callback: () {
                                controller.clubStore();
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
