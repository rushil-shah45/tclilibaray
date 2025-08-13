import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProfileViewShimmer extends StatelessWidget {
  const ProfileViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5.h, left: 16.w, right: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: Get.height / 6.5,
              width: Get.height / 6.5,
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade300,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 30.h,
            width: Get.width,
            child: container(),
          ),
          SizedBox(
            height: 30.h,
            width: 200.w,
            child: container(),
          ),
          SizedBox(
            height: 30.h,
            width: 200.w,
            child: container(),
          ),
          SizedBox(
            height: 30.h,
            width: 200.w,
            child: container(),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 30.h,
            width: Get.width,
            child: container(),
          ),
          SizedBox(height: 10.h),
          Center(
            child: SizedBox(
              height: Get.height / 22,
              width: Get.width / 3.5,
              child: container(),
            ),
          ),
        ],
      ),
    );
  }

  Shimmer container() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade400,
      highlightColor: Colors.grey.shade300,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}
