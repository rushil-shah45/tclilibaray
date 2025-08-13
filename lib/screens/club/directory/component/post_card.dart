import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/values/k_images.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/controllers/club_controller.dart';
import 'package:tcllibraryapp_develop/screens/club/directory/model/club_model.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post, required this.clubController});

  final ClubController clubController;
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.postDetailsScreen, arguments: post.id);
        },
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(
              horizontal: Get.width / 29, vertical: Get.height / 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: clubController.isLoading.value
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
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${RemoteUrls.rootUrl}${post.user.image}',
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) => Image.asset(
                                KImages.avatar,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(width: 5.w),
                  Column(
                    children: [
                      SizedBox(
                        width: Get.width - (Get.width / 3.5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${post.user.name} ${post.user.lastName}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Text(
                                'Shared - ${DateFormat('h:mm a dd MMM yyyy').format(post.createdAt)}'),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                post.club.title,
                                style: TextStyle(
                                    fontSize: 13.sp, color: primaryColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                post.title,
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
