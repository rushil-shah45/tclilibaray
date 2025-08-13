import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/book/author/analytics/models/analytics_model.dart';

class AnalyticsDashboardBook extends StatelessWidget {
  const AnalyticsDashboardBook({super.key, required this.viewed});

  final Viewed viewed;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: viewed.userProfileModel != null,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: Get.width / 3.5,
              child: Text(
                "${viewed.userProfileModel?.name} ${viewed.userProfileModel?.lastName}" ??
                    "",
                maxLines: 1,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: Get.width / 12.w),
            SizedBox(
              width: Get.width / 10,
              child: Text(
                viewed.totalView,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(width: Get.width / 5.w),
            SizedBox(
              width: Get.width / 10,
              child: Text(
                "${viewed.progress}%",
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
