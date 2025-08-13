import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/core/utils/utils.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/controller/club_details_controller.dart';
import '../model/club_details_model.dart';

class DiscussionCard extends StatelessWidget {
  const DiscussionCard(
      {super.key, required this.controller, required this.post});

  final ClubDetailsController controller;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.postDetailsScreen, arguments: post.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width / 29, vertical: Get.height / 100),
        margin: EdgeInsets.only(bottom: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      height: Get.width / 9.5,
                      width: Get.width / 9.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.white,
                            width: 4,
                            strokeAlign: BorderSide.strokeAlignOutside),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 16,
                              offset: const Offset(0, 0)),
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 16,
                              offset: const Offset(0, 0)),
                        ],
                      ),
                      child: controller.isLoading.value
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade200,
                              child: Container(
                                height: Get.width / 9.5,
                                width: Get.width / 9.5,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: CustomImage(
                                path: "${RemoteUrls.rootUrl}${post.user.image}",
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            "${post.user.name} ${post.user.lastName}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: textColor),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            "Shared - ${Utils.formatDateWithTime(post.createdAt)} ${Utils.formatDateWithMonthName(post.createdAt)}",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.2,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Visibility(
                visible: post.commentsCount != '0',
                child: Text(
                  "Comment: ${post.commentsCount}",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              post.title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.2,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.h),
            Divider(color: Colors.grey.shade300)
          ],
        ),
      ),
    );
  }
}
