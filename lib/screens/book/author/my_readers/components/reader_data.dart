import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/widgets/custom_image.dart';
import '../models/my_readers_model.dart';

class ReaderData extends StatelessWidget {
  const ReaderData({super.key, required this.readersModel});

  final Reader readersModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: 5.w),
        CustomImage(
          height: 50,
          width: 45,
          fit: BoxFit.cover,
          path: "${RemoteUrls.rootUrl}${readersModel.bookThumb}",
        ),
        SizedBox(width: 15.w),
        SizedBox(
          width: Get.width / 4.5,
          child: Text(
            readersModel.bookTitle,
            maxLines: 1,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(width: 2.w),
        SizedBox(
          width: Get.width / 4.3,
          child: Text(
            "${readersModel.readerFirstName} ${readersModel.readerLastName}",
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: 5.w),
        SizedBox(
          width: Get.width / 5.8,
          child: Text(
            readersModel.totalView,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
