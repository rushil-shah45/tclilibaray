import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/global_method/global_method.dart';
import 'package:tcllibraryapp_develop/screens/ticket/component/view_ticket/controller/view_ticket_controller.dart';
import 'package:tcllibraryapp_develop/screens/ticket/model/ticket_details_model.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

viewAttachmentDialog(
    BuildContext context, Details details, ViewTicketController controller) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.green,
        child: Container(
          height: controller.isTablet ? Get.height / 2.7 : Get.height / 1.5,
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Padding(
            padding:
                EdgeInsets.only(left: 0.w, right: 0.w, top: 0.h, bottom: 0.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height:
                      controller.isTablet ? Get.height / 3.1 : Get.height / 1.7,
                  width: Get.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: primaryColor, width: 2)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: CustomImage(
                      path: "${RemoteUrls.rootUrl}${details.fileNameUploaded}",
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomBtn(
                        width: controller.isTablet
                            ? Get.width / 1.5
                            : Get.width / 2,
                        text: "Click here to download",
                        color: primaryColor,
                        callback: () {
                          downloadVideo(
                                  '${RemoteUrls.rootUrl}${details.fileNameUploaded}',
                                  details.fileNameUploaded)
                              .then(
                            (value) {
                              Get.back();
                              Get.snackbar(
                                  'File Downloaded', 'File has been downloaded!');
                            },
                          );
                        },
                      ),
                      SizedBox(width: 5.w),
                      CustomBtn(
                        width: Get.width / 5.5,
                        text: "Close",
                        color: Colors.red,
                        callback: () {
                          Get.back();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
        ),
      );
    },
  );
}
