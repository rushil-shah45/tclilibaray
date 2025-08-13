import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/controller/my_subscription_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

class MySubscriptionScreen extends GetView<MySubscriptionController> {
  const MySubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text(
          "My Subscription",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return controller.settingsController.getUserProfile();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(
              () => controller.mainController.isLoading.value
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade300,
                          child: Container(
                            height: Get.height / 5.5,
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade300,
                          child: Container(
                            height: Get.height / 2.5,
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 13.h),
                          decoration: BoxDecoration(
                            color: whiteDoubleColor,
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10.w, top: 5.h),
                                child: Text(
                                  "${controller.mainController.userProfileModel?.plan.title}",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const Divider(),
                              SizedBox(height: 3.h),
                              Align(
                                alignment: Alignment.center,
                                child: CustomBtn(
                                  width: Get.width / 5,
                                  text: "Upgrade",
                                  callback: () {
                                    Get.toNamed(Routes.pricing);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Container(
                          padding: EdgeInsets.only(top: 5.h, bottom: 13.h),
                          decoration: BoxDecoration(
                            color: whiteDoubleColor,
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 10.w, right: 8.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Billing Information",
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 10.w),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                              Routes.billingDetailsScreen);
                                        },
                                        child: Image.asset(
                                          "assets/images/editing.png",
                                          height: 22.h,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                                child: SizedBox(
                                  width: Get.width,
                                  child: Table(
                                    border: TableBorder.all(
                                        color: Colors.white60, width: 1),
                                    defaultVerticalAlignment:
                                        TableCellVerticalAlignment.middle,
                                    children: [
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "Name",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "${controller.mainController.userProfileModel?.billingName}",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "Email",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "${controller.mainController.userProfileModel?.billingEmail}",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "Phone",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "${controller.mainController.userProfileModel?.billingDialCode}${controller.mainController.userProfileModel?.billingPhone}",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "User-Type",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "${controller.mainController.userProfileModel?.type}",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "Address",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "${controller.mainController.userProfileModel?.address}",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "Country",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "${controller.mainController.userProfileModel?.country}",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "State",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "${controller.mainController.userProfileModel?.state}",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "City",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "${controller.mainController.userProfileModel?.city}",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "Zip code",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 5.w),
                                          child: Text(
                                            "${controller.mainController.userProfileModel?.zipcode}",
                                            // textScaler:
                                            //     const TextScaler.linear(1.1),
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
