import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/faq/controller/faq_controller.dart';

class FaqScreen extends GetView<FaqController> {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaqController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Get.back();
                }),
            title: Text(
              "FAQ",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return controller.getFaqData();
            },
            child: Obx(
              () => controller.isLoading.value
                  ? SizedBox(
                      width: Get.width,
                      child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: controller.isTablet
                                ? EdgeInsets.only(left: 10.w, right: 10.w)
                                : EdgeInsets.only(left: 16.w, right: 16.w),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.grey.shade300,
                              child: Container(
                                height: 50,
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : Container(
                      padding: controller.isTablet
                          ? EdgeInsets.only(
                              left: 10.w, right: 10.w, bottom: 16.h)
                          : EdgeInsets.only(
                              left: 16.w, right: 16.w, bottom: 16.h),
                      child: ListView.separated(
                        itemCount: controller.faqModelList.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    if (controller
                                        .isClickToVisible[index].value) {
                                      controller.isClickToVisible[index].value =
                                          !controller
                                              .isClickToVisible[index].value;
                                    } else {
                                      controller.closeAll(index);
                                      controller.isClickToVisible[index].value =
                                          !controller
                                              .isClickToVisible[index].value;
                                    }
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: controller.isTablet
                                            ? const EdgeInsets.all(5)
                                            : const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: controller
                                                    .isClickToVisible[index]
                                                    .value
                                                ? redColor.withOpacity(0.2)
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            border: Border.all(
                                                color: Colors.grey.shade400)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                controller
                                                    .faqModelList[index].title,
                                                style: TextStyle(
                                                    fontSize:
                                                        controller.isTablet
                                                            ? 11.sp
                                                            : 14.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Icon(
                                                controller
                                                        .isClickToVisible[index]
                                                        .value
                                                    ? Icons.remove
                                                    : Icons.add,
                                                color: primaryColor),
                                          ],
                                        ),
                                      ),
                                      Obx(() => Visibility(
                                            visible: controller
                                                .isClickToVisible[index].value,
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Text(
                                                controller
                                                    .faqModelList[index].body,
                                                style: TextStyle(
                                                  fontSize: controller.isTablet
                                                      ? 9.sp
                                                      : 13.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 10.h);
                        },
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
