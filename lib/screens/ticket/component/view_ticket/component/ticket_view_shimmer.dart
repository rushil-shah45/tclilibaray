import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class TicketViewShimmer extends StatelessWidget {
  const TicketViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height - (AppBar().preferredSize.height * 2),
      child: ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          reverse: true,
          physics: const ScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              child: Container(
                alignment: index % 2 == 0
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  height: Get.height / 4.5,
                  width: Get.width * 0.70,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: BoxDecoration(
                    color: index % 2 == 0
                        ? Colors.grey.withOpacity(0.5)
                        : Colors.grey.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Column(
                      crossAxisAlignment: index % 2 == 0
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade400,
                          highlightColor: Colors.grey.shade300,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                BorderRadius.circular(100)),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.grey.shade300,
                          child: Container(
                            height: Get.height / 40,
                            width: Get.width / 4,
                            decoration: const BoxDecoration(
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.grey.shade300,
                          child: Container(
                            height: Get.height / 40,
                            width: Get.width / 2,
                            decoration: const BoxDecoration(
                                color: Colors.grey),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.grey.shade300,
                          child: Container(
                            height: Get.height / 40,
                            width: Get.width / 3,
                            decoration: const BoxDecoration(
                                color: Colors.grey),
                          ),
                        ),
                      ]),
                ),
              ),
            );
          }),
    );
  }
}
