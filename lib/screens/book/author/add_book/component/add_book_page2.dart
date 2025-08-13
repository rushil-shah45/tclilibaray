import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/utils.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

import '../../../../setting/controllers/settings_controller.dart';
import '../controller/add_book_controller.dart';

class AddBookPageTwo extends StatelessWidget {
  const AddBookPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddBookController>(builder: (controller) {
      return CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomRichText(title: 'Publisher ', star: "*"),
                  CustomTextField(
                    controller: controller.publisherController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    hintText: "Enter publisher",
                  ),
                  SizedBox(height: 5.h),
                  const CustomRichText(title: 'Edition'),
                  CustomTextField(
                    controller: controller.editionController,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    hintText: "Enter Edition",
                  ),
                  SizedBox(height: 5.h),
                  const CustomRichText(title: 'Publisher Year ', star: "*"),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Select Year"),
                            content: SizedBox(
                              height: Get.height / 2,
                              width: Get.width,
                              child: YearPicker(
                                initialDate: controller.selectedDate,
                                selectedDate: controller.selectedDate,
                                firstDate:
                                    DateTime(DateTime.now().year - 1000, 1),
                                lastDate:
                                    DateTime(DateTime.now().year + 1000, 1),
                                onChanged: (DateTime dateTime) {
                                  controller.selectedDate = dateTime;
                                  controller.publishYearController.text =
                                      Utils.formatDateWithYear(dateTime);
                                  Get.back();
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: AbsorbPointer(
                      child: CustomTextField(
                        controller: controller.publishYearController,
                        hintText: "Publisher Year",
                        suffixIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Visibility(
                    visible: controller.bookType.value == 'pdf',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomRichText(title: 'Pages'),
                        CustomTextField(
                          controller: controller.pagesController,
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          hintText: "Number of Pages",
                        ),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                  const CustomRichText(title: 'Size '),
                  Container(
                    height: Get.height / 16.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      List<String> items = controller.sizeItems.value;
                      return DropdownButton(
                        borderRadius: BorderRadius.circular(10.r),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        value: controller.sizeType.value == ""
                            ? null
                            : controller.sizeType.value,
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
                          controller.changeSizeItemValue(newValue!);
                        },
                      );
                    }),
                  ),
                  if (controller.bookType.value == "pdf")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        const CustomRichText(
                            title: 'Reading Time (In Hours) ', star: "*"),
                        SizedBox(
                          width: Get.width,
                          child: TextField(
                            controller: controller.readingTimeController,
                            // maxLines: 5,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: "Enter reading time in hours",
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(
                                  top: 25.h, left: 10.w, right: 10.w),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 20.h),
                  const CustomRichText(
                    title: 'Book Distribution ',
                    star: "*",
                  ),
                  Container(
                    height: Get.height / 16.7,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Obx(() {
                      List<String> items =
                          controller.distributionTypeList.value;
                      if (Get.find<SettingsController>()
                              .userProfileModel!
                              .isBuyBook ==
                          0) items.remove('Book For Sale');
                      return DropdownButton(
                        borderRadius: BorderRadius.circular(10.r),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        value: controller.distributionType.value == ""
                            ? null
                            : controller.distributionType.value,
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
                          controller.changeDistributionItemValue(newValue!);
                        },
                      );
                    }),
                  ),
                  if (controller.distributionType.value == "Book For Sale")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomRichText(title: 'Price ', star: "* "),
                            Expanded(
                                child: Text(controller
                                        .bookPriceController.text.isEmpty
                                    ? "( Platform commission 5% )"
                                    : "( Platform commission ${controller.resultWithoutVat.value.toStringAsFixed(2)}\$ and you will get ${controller.vatResult.value.toStringAsFixed(2)}\$)"))
                          ],
                        ),
                        SizedBox(
                          width: Get.width,
                          child: TextField(
                            controller: controller.bookPriceController,
                            onChanged: (value) {
                              controller.priceChange(value);
                            },
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: "Enter book price",
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.only(
                                  top: 25.h, left: 10.w, right: 10.w),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 20.h),
                  const CustomRichText(title: 'Description ', star: "*"),
                  SizedBox(
                    width: Get.width,
                    child: TextField(
                      controller: controller.descriptionController,
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: "Enter description",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.only(top: 25.h, left: 10.w, right: 10.w),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomBtn(
                        width: Get.width / 5,
                        color: Colors.grey,
                        text: 'Previous',
                        callback: () {
                          controller.pageController.previousPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.ease,
                          );
                        },
                      ),
                      SizedBox(width: 10.w),
                      Obx(
                        () => controller.booksStoreLoading.value
                            ? SizedBox(
                                width: Get.width / 6,
                                child: const Center(
                                    child: CircularProgressIndicator()))
                            : CustomBtn(
                                width: Get.width / 6,
                                text: 'Add',
                                callback: () {
                                  controller.newBookStore();
                                },
                              ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );
    });
  }
}
