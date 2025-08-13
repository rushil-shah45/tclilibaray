import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/club/club_new_topic/controllers/club_new_topic_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

class ClubNewTopicScreen extends StatelessWidget {
  const ClubNewTopicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ClubNewTopicController clubNewTopicController = Get.find();

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
          "Ask Question",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomRichText(
                      title: 'Title',
                      star: '*',
                    ),
                    CustomTextField(
                      controller: clubNewTopicController.titleController,
                      hintText: 'Title',
                    ),
                    SizedBox(height: 5.h),
                    const CustomRichText(title: 'Description', star: '*'),
                    CustomTextField(
                      height: Get.height / 3.5,
                      controller: clubNewTopicController.quillEditorController,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      hintText: "About Type Here,",
                      maxLines: 10,
                    ),
                    // Container(
                    //   padding: const EdgeInsets.all(2),
                    //   decoration: BoxDecoration(
                    //       border: Border.all(color: Colors.black),
                    //       borderRadius: BorderRadius.circular(8.r)),
                    //   child: Column(
                    //     children: [
                    //       ToolBar(
                    //           toolBarColor: Colors.grey.withOpacity(0.2),
                    //           activeIconColor: primaryColor,
                    //           padding: const EdgeInsets.all(8),
                    //           iconSize: 20,
                    //           controller:
                    //               clubNewTopicController.quillEditorController),
                    //       QuillHtmlEditor(
                    //         controller:
                    //             clubNewTopicController.quillEditorController,
                    //         isEnabled: true,
                    //         backgroundColor: secondaryColor,
                    //         minHeight: Get.height / 3.5,
                    //         hintTextAlign: TextAlign.start,
                    //         padding: const EdgeInsets.only(left: 10, top: 5),
                    //         hintTextPadding: EdgeInsets.zero,
                    //         loadingBuilder: (context) {
                    //           return const Center(
                    //               child: CircularProgressIndicator());
                    //         },
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 10.h),
                    const CustomRichText(title: 'Attachment'),
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
                                  await FilePicker.platform.pickFiles();
                              if (result != null) {
                                clubNewTopicController.setFileBookType(
                                    File(result.files.single.path!));
                              } else {}
                            },
                            child: Container(
                              width: Get.width / 4,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              alignment: Alignment.center,
                              child: Text('Choose File',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14.sp)),
                            ),
                          ),
                          SizedBox(width: 5.w),
                          Obx(
                            () => SizedBox(
                              height: Get.height,
                              width: Get.width / 2,
                              child: clubNewTopicController.fileName.value == ""
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
                                        clubNewTopicController.fileName.value,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.sp),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Obx(
                      () => clubNewTopicController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Center(
                              child: CustomBtn(
                                width: 200,
                                height: 45,
                                text: 'Submit',
                                callback: () {
                                  clubNewTopicController.createTopic(context);
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
  }
}
