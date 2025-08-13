import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ClubShimmers extends StatelessWidget {
  const ClubShimmers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade300,
          child: Container(
            height: 55.h,
            width: Get.width,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        SizedBox(height: 5.h),
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Align(
            alignment: Alignment.centerRight,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade400,
              highlightColor: Colors.grey.shade300,
              child: Container(
                height: Get.height / 18,
                width: Get.width / 3.8,
                margin: const EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
          ),
        ),
        ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              margin: EdgeInsets.symmetric(horizontal: Get.width / 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: Get.width / 8,
                      width: Get.width / 8,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          height: 25,
                          width: Get.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          height: 25,
                          width: Get.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        SizedBox(height: 10.h),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade400,
          highlightColor: Colors.grey.shade300,
          child: Container(
            height: 55.h,
            width: Get.width,
            margin: const EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        ListView.builder(
          itemCount: 4,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              margin: EdgeInsets.symmetric(horizontal: Get.width / 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: Get.width / 8,
                      width: Get.width / 8,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          height: 25,
                          width: Get.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade400,
                        highlightColor: Colors.grey.shade300,
                        child: Container(
                          height: 25,
                          width: Get.width / 2,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
