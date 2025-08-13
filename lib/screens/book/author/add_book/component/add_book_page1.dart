import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/book/author/add_book/component/category_bottom_sheet.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

import '../controller/add_book_controller.dart';

class AddBookPageOne extends StatelessWidget {
  const AddBookPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddBookController>(builder: (controller) {
      String text = "In Video";
      if (controller.bookType.value == "pdf") {
        text = "In PDF";
      } else if (controller.bookType.value == "audio") {
        text = "In Audio";
      } else if (controller.bookType.value == "video") {
        text = "In Video";
      } else if (controller.bookType.value == "url") {
        text = "Video url";
      }
      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomRichText(title: 'Book Type ', star: "*"),

                  ///Book Type(PDF,VIDEO,AUDIO)
                  Container(
                    height: Get.height / 16.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      List<String> items = controller.bookItems.value;
                      return DropdownButton(
                        borderRadius: BorderRadius.circular(10.r),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        value: controller.bookType.value == ""
                            ? null
                            : controller.bookType.value,
                        isExpanded: true,
                        iconEnabledColor: Colors.grey.shade400,
                        underline: const SizedBox(),
                        hint: const Text("Select"),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          controller.changeBookItemValue(newValue!);
                        },
                      );
                    }),
                  ),
                  SizedBox(height: 10.h),

                  ///Book File (PDF,VIDEO,AUDIO)
                  Visibility(
                    visible: controller.bookType.value != "",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomRichText(title: 'Book ($text) ', star: "*"),
                        Visibility(
                          visible: controller.bookType.value != "url",
                          child: Column(
                            children: [
                              Container(
                                height: Get.height / 16.7,
                                width: Get.width,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                ),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions:
                                              controller.bookType.value == "pdf"
                                                  ? ['pdf']
                                                  : controller.bookType.value ==
                                                          "audio"
                                                      ? ['mp3']
                                                      : controller.bookType
                                                                  .value ==
                                                              "video"
                                                          ? ['mp4']
                                                          : null,
                                        );
                                        if (result != null) {
                                          if (result.files.isNotEmpty) {
                                            controller.setFileBookType(File(
                                                result.files.single.path!));
                                          }
                                        } else {}
                                      },
                                      child: Container(
                                        height: Get.height / 14,
                                        width: Get.width / 4,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        alignment: Alignment.center,
                                        child: const Text('Choose File',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14)),
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                    Obx(
                                      () => SizedBox(
                                        height: Get.height,
                                        width: Get.width / 2,
                                        child: controller.bookFileName.value ==
                                                ""
                                            ? Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "No file chosen",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.sp),
                                                ),
                                              )
                                            : Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  controller.bookFileName.value,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: controller.bookType.value == "url",
                          child: CustomTextField(
                            controller: controller.youtubeUrlController,
                            textInputType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            hintText: "Enter youtube url",
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///Thumbnail
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CustomRichText(title: 'Thumbnail '),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "[ ",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "Recommended size : 300 x 350",
                              style: TextStyle(
                                  fontSize: controller.isTablet ? 9.sp : 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.red),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              " ]",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              "*",
                              style: TextStyle(
                                  fontSize: 14.sp,
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
                                    controller.setThumbnail(
                                        File(result.files.single.path!));
                                  }
                                } else {}
                              },
                              child: Container(
                                height: Get.height / 14,
                                width: Get.width / 4,
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(10.r)),
                                alignment: Alignment.center,
                                child: const Text('Choose File',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14)),
                              ),
                            ),
                            SizedBox(width: 5.w),
                            Obx(
                              () => SizedBox(
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
                      SizedBox(height: 5.h),
                    ],
                  ),

                  ///Category
                  const CustomRichText(title: 'Category ', star: "*"),
                  SizedBox(
                    height: Get.height / 16.7,
                    child: GestureDetector(
                      onTap: () {
                        categoryBottomSheet(context);
                      },
                      child: AbsorbPointer(
                        child: CustomTextField(
                          hintText: "Select",
                          controller: controller.selectedCategoryOption,
                          textInputAction: TextInputAction.done,
                          suffixIcon: const Icon(Icons.keyboard_arrow_down,
                              color: Colors.grey, size: 24),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  const CustomRichText(title: 'Title ', star: "*"),
                  CustomTextField(
                    controller: controller.titleController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Title",
                  ),
                  SizedBox(height: 5.h),
                  const CustomRichText(title: 'Sub Title'),
                  CustomTextField(
                    controller: controller.subTitleController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Subtitle",
                  ),
                  SizedBox(height: 5.h),
                  const CustomRichText(title: 'ISBN-10 ', star: "*"),
                  CustomTextField(
                    controller: controller.isbnTenController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter ISBN-10",
                  ),
                  SizedBox(height: 5.h),
                  const CustomRichText(title: 'ISBN-13 ', star: ""),
                  CustomTextField(
                    controller: controller.isbnThreeController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter ISBN-13",
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: CustomBtn(
                      width: Get.width / 6,
                      text: 'Next',
                      callback: () {
                        if (controller.isBookType() &&
                            controller.isBookFileOkay() &&
                            controller.isThumbNailOkay() &&
                            controller.isCategoryOkay() &&
                            controller.isTitleOkay() &&
                            controller.isIsbnTenOkay()) {
                          controller.changePage(1);
                          controller.pageController.animateToPage(1,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        } else if (!controller.isBookType()) {
                          Get.snackbar('Book type can\'t be empty',
                              'Please select book type');
                        } else if (!controller.isBookFileOkay()) {
                          if (controller.bookType.value != 'url') {
                            Get.snackbar('Book file can\'t be empty',
                                'Please select your book file');
                          } else {
                            Get.snackbar('Youtube link can\'t be empty',
                                'Please enter your youtube link');
                          }
                        } else if (!controller.isThumbNailOkay()) {
                          Get.snackbar('Thumbnail can\'t be empty',
                              'Please select your thumbnail');
                        } else if (!controller.isCategoryOkay()) {
                          Get.snackbar('Category can\'t be empty',
                              'Please choose your category');
                        } else if (!controller.isTitleOkay()) {
                          Get.snackbar('Title can\'t be empty',
                              'Please enter your title');
                        } else if (!controller.isIsbnTenOkay()) {
                          Get.snackbar('Isbn10 can\'t be empty',
                              'Please enter your Isbn10');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    });
  }

  void categoryBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return const CategoryBottomSheet();
      },
    );
  }
}
