import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/model/dashboard_author_model.dart';

class DashboardCardTopReaders extends StatelessWidget {
  const DashboardCardTopReaders({super.key, required this.topReader});

  final TopReader topReader;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CustomImage(
          height: 50,
          width: 45,
          fit: BoxFit.cover,
          path: "${RemoteUrls.rootUrl}${topReader.book!.thumb}",
        ),
        SizedBox(width: 15.w),
        SizedBox(
          width: Get.width / 4.5,
          child: Text(
            topReader.book?.title ?? '',
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 2.w),
        SizedBox(
          width: Get.width / 4.3,
          child: Text(
            "${topReader.user?.name} ${topReader.user?.lastName}" ?? '',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 5.w),
        SizedBox(
          width: Get.width / 5.8,
          child: Text(
            topReader.totalView ?? '',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
