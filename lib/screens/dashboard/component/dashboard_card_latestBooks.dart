import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';

class DashboardCardLatestBook extends StatelessWidget {
  const DashboardCardLatestBook(
      {super.key, required this.book, required this.controller});

  final Book? book;
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.bookDetailsScreen, arguments: [book!.id,""]);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomImage(
                height: 50,
                width: 45,
                fit: BoxFit.cover,
                path: "${RemoteUrls.rootUrl}${book?.thumb}",
              ),
              SizedBox(width: 2.w),
              SizedBox(
                width: Get.width / 5,
                child: Text(
                  book?.publisher ?? '',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 5.w),
              SizedBox(
                width: Get.width / 4.5,
                child: Text(
                  book?.publisherYear ?? '',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 5.w),
              SizedBox(
                width: Get.width / 5,
                child: PopupMenuButton(
                  onSelected: (value) {
                    controller.onMenuItemSelected(value as int, book!.id, book, context);
                  },
                  offset: Offset(Get.width / 10, Get.height / 20),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0)),
                  ),
                  itemBuilder: (ctx) => [
                    buildPopupMenuItem('Edit', Options.edit.index),
                    buildPopupMenuItem('Delete', Options.delete.index),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  PopupMenuItem buildPopupMenuItem(String title, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
