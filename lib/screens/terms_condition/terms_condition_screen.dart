import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/screens/terms_condition/controller/terms_condition_controller.dart';

class TermsConditionScreen extends StatelessWidget {
  const TermsConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TermConditionController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new),
                onPressed: () {
                  Get.back();
                }),
            title: Text(
              controller.mainController.customPageModel[1].title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return controller.mainController.getPrivacyTermsConditions();
            },
            child: SingleChildScrollView(
              child: Obx(
                () => controller.mainController.isLoading.value
                    ? SizedBox(
                        height: Get.height,
                        child: ListView.builder(
                            itemCount: 14,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: controller.isTablet
                                    ? EdgeInsets.symmetric(horizontal: 10.w)
                                    : EdgeInsets.symmetric(horizontal: 16.w),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade400,
                                  highlightColor: Colors.grey.shade300,
                                  child: Container(
                                    height: 55.h,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(7.r),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    : Container(
                        padding: controller.isTablet
                            ? EdgeInsets.only(
                                left: 8.w, right: 8.w, bottom: 20.h)
                            : EdgeInsets.only(
                                left: 16.w, right: 16.w, bottom: 20.h),
                        child: Html(
                            data: controller
                                .mainController.customPageModel[1].body),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
