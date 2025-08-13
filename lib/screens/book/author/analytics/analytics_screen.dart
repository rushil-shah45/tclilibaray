import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/author/analytics/component/analytics_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/book/author/analytics/controller/analytics_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';
import '../../../../core/utils/constants.dart';
import 'component/analytics_dashboard_book.dart';

class AnalyticsScreen extends GetView<AnalyticsController> {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            }),
        title: Obx(
          () => controller.isLoading.value
              ? Container()
              : Text(
                  "Analytics of ${controller.booksModel!.title}",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return controller.getAnalyticData();
        },
        child: Obx(
          () => controller.isLoading.value
              ? const AnalyticsShimmer()
              : CustomScrollView(
                  slivers: [
                    ///Grid Info
                    SliverPadding(
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: Get.height / 8.5,
                              width: Get.width / 2.3,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: greenColor),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${controller.analyticsModel.value!.totalBorrowed}",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: greenColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text("Borrowed Books"),
                                ],
                              ),
                            ),
                            Container(
                              height: Get.height / 8.5,
                              width: Get.width / 2.3,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: customBlueColor),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "${controller.analyticsModel.value!.totalComplete}",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        color: customBlueColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text("Completed Views"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          height: Get.height / 8.5,
                          width: Get.width,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: primaryGrayColor),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${controller.analyticsModel.value!.totalViewed}",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    color: primaryGrayColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Text("Total Views"),
                            ],
                          ),
                        ),
                      ),
                    ),

                    ///Viewed Books
                    SliverPadding(
                      padding: EdgeInsets.only(
                          left: 16.w, right: 16.w, bottom: 10.h),
                      sliver: SliverToBoxAdapter(
                        child: Text(
                          "Viewed books",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),

                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverToBoxAdapter(
                        child: Visibility(
                          visible:
                              controller.analyticsModel.value!.viewed != null,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              border: Border.all(color: Colors.grey.shade100),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        "Viewed by",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(width: 55.w),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Total Views",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 35.w),
                                        Text(
                                          "Completion",
                                          style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    controller.analyticsModel.value!.viewed.isEmpty == true
                        ? SliverPadding(
                            padding: EdgeInsets.only(
                                left: 16.w, right: 16.w, top: 5.h),
                            sliver: SliverToBoxAdapter(
                                child: CustomGifImage(height: Get.height / 7)),
                          )
                        : SliverPadding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                childCount: controller
                                    .analyticsModel.value!.viewed.length,
                                (context, index) {
                                  return AnalyticsDashboardBook(
                                    viewed: controller
                                        .analyticsModel.value!.viewed[index],
                                  );
                                },
                              ),
                            ),
                          ),
                    SliverToBoxAdapter(child: SizedBox(height: 50.h))
                  ],
                ),
        ),
      ),
    );
  }
}
