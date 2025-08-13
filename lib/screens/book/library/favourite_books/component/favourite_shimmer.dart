import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FavouriteShimmer extends StatelessWidget {
  const FavouriteShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: Get.height / 2.5,
            crossAxisCount: 2,
            mainAxisSpacing: 6,
            crossAxisSpacing: 14,
          ),
          itemCount: 8,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade300,
                child: Container(
                  height: Get.height / 2.5,
                  width: Get.width / 2.5,
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
      ),
    );
  }
}
