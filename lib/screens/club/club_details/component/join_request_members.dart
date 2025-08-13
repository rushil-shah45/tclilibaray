import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/utils.dart';
import 'package:tcllibraryapp_develop/core/values/colors.dart';
import 'package:tcllibraryapp_develop/core/values/k_images.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/controller/club_details_controller.dart';
import 'package:tcllibraryapp_develop/screens/club/club_details/model/club_details_model.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

class JoinRequestList extends StatelessWidget {
  const JoinRequestList(
      {super.key, required this.controller, required this.member});

  final ClubDetailsController controller;
  final Member member;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h, bottom: 5.h),
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: AppColors.f4f4f4,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
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
                            height: 60.h,
                            width: 60.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                              imageUrl:
                                  "${RemoteUrls.rootUrl}${member.user.image}",
                              height: 60.h,
                              width: 60.h,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Image.asset(
                                    KImages.avatar,
                                    fit: BoxFit.fill,
                                  )),
                        ),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: Get.width / 3,
                          child: Text(
                            "${member.user.name} ${member.user.lastName}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        Visibility(
                          visible: member.isOwner == true,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: const Color(0xff18A2B8),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Owner",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "${Utils.formatDateWithTime(member.createdAt)} ${Utils.formatDateWithMonthName(member.createdAt)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                          color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(width: 5.w),
              ],
            ),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomBtn(
                  height: Get.height / 30.h,
                  width: Get.width / 6.3,
                  text: "Approve",
                  size: 12.sp,
                  color: greenColor,
                  callback: () {
                    controller.memberStatusChange("${member.id}", "${1}");
                  },
                ),
                SizedBox(height: 5.h),
                CustomBtn(
                  height: Get.height / 30.h,
                  width: Get.width / 6.3,
                  text: "Deny",
                  size: 12.sp,
                  color: redDeepColor,
                  callback: () {
                    controller.memberStatusChange("${member.id}", "${0}");
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
