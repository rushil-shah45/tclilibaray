import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/notification/controller/notification_controller.dart';
import 'package:tcllibraryapp_develop/screens/notification/model/notification_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationCart extends StatelessWidget {
  const NotificationCart(
      {super.key, required this.notificationModel, required this.controller});

  final Notifications notificationModel;
  final NotificationController controller;

  @override
  Widget build(BuildContext context) {
    Duration difference =
        DateTime.now().difference(notificationModel.createdAt);
    String ago = '';
    difference.inDays == 0
        ? difference.inHours == 0
            ? ago = '${difference.inMinutes} mins ago'
            : ago = '${difference.inHours} hours ago'
        : ago = '${difference.inDays} days ago';

    return GestureDetector(
      // onTap: () {
      //   controller.readNotifications(notificationModel.id);
        // controller.readNotifications(notificationModel.id).then((value) async {
        //   if (controller
        //           .dashboardController.mainController.userProfileModel!.roleId
        //           .compareTo('1') ==
        //       0) {
        //     if (notificationModel.type == "new_book") {
        //       Get.back();
        //       Get.toNamed(Routes.allBooks);
        //     } else if (notificationModel.type == "club") {
        //       Get.back();
        //       Get.toNamed(Routes.clubScreen);
        //     } else if (notificationModel.type == "forum") {
        //       Get.back();
        //       final Uri url = Uri.parse(RemoteUrls.forum);
        //       if (!await launchUrl(url)) {
        //         throw Exception('Could not launch $url');
        //       }
        //     }
        //   } else if (controller.dashboardController.mainController
        //               .userProfileModel!.roleId
        //               .compareTo('2') ==
        //           0 &&
        //       notificationModel.type == "author_book") {
        //     Get.back();
        //     Get.toNamed(Routes.myBooks);
        //   }
        // });
      // },
      child: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    notificationModel.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                GestureDetector(onTap: () {
                  controller.readNotifications(notificationModel.id);
                },child: const Icon(Icons.delete,color: Colors.red,))
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                ago,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
