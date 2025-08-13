import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class PricingShimmer extends StatelessWidget {
  const PricingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 1.33,
      child: PageView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 120.h,
              ),
              child: Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: 40,
                      width: 250,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: 30,
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: 30,
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: 30,
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: 30,
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: 30,
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: 30,
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: 30,
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: 30,
                      width: Get.width,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade300,
                    child: Container(
                      height: Get.height / 24,
                      width: Get.width / 4.5,
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
