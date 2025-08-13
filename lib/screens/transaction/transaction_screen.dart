import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/transaction/controller/transaction_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';

class TransactionScreen extends GetView<TransactionController> {
  const TransactionScreen({super.key});

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
          "Transactions",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return controller.getTransaction();
        },
        child: Obx(
          () => controller.isLoading.value
              ? SizedBox(
                  width: Get.width,
                  child: ListView.builder(
                    itemCount: 6,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade300,
                          child: Container(
                            height: Get.height / 8,
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : controller.transactionList.value.isEmpty
                  ? CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [SliverPadding(padding: EdgeInsets.only(top: 130.h), sliver: const SliverToBoxAdapter(child: CustomGifImage()))])
                  : CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(childCount: controller.transactionList.value.length, (context, index) {
                              final transaction = controller.transactionList.value[index];
                              inspect(transaction);
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(color: primaryColor),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 5.w, top: 5.h, right: 5.w, bottom: 5.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Trans ID: ${transaction.transactionId}",
                                          style: TextStyle(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "Pay Status: ${transaction.paymentStatus}",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "Amount: ${transaction.usdAmount.isNotEmpty ? double.parse(transaction.usdAmount).toStringAsFixed(2) : ""}\$",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          "Pay Method: ${transaction.paymentProvider}",
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        transaction.packageId != "" || transaction.book != null
                                            ? Text(
                                                transaction.packageId != ""
                                                    ? "Package: ${controller.getPackageStatus(transaction)}"
                                                    : "Book: ${transaction.book != null ? transaction.book!.title.toString() : ""}",
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                      ],
                    ),
        ),
      ),
    );
  }
}
