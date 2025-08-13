import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/model/dashboard_user_model.dart';

class DashboardCardLastViewedUserBook extends StatelessWidget {
  const DashboardCardLastViewedUserBook(
      {super.key, required this.lastViewedBook, required this.controller});

  final LastViewedBook lastViewedBook;
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            print("SSSSSSSSSS");
            lastViewedBook.book!.fileType == "url"
                ? (Get.toNamed(Routes.bookDetailsScreen,
                    arguments: [lastViewedBook.book!.id, ""]))
                : (lastViewedBook.book!.isPaid == 0 ||
                        controller.mainController.userProfileModel!
                                .currentUserPlan!.packageId !=
                            '1')
                    ? (lastViewedBook.book!.isBorrowed == false)

                        ? (Get.snackbar(
                            'Warning', 'Here we go 1'))
                        : (DateTime.now().isAfter(DateTime.parse(
                                lastViewedBook.book!.borrowedNextdate)))
                            ? (Get.snackbar(
                                'Warning', 'Here we go 2'))
                            : (DateTime.now().isAfter(DateTime.parse(lastViewedBook.book!.borrowedEnddate)) &&
                                    DateTime.now().isBefore(DateTime.parse(
                                        lastViewedBook.book!.borrowedNextdate)))
                                ? (Get.snackbar('Warning',
                                    'Here we go 3'))
                                : (Get.toNamed(Routes.bookDetailsScreen,
                                    arguments: [lastViewedBook.book!.id, ""]))
                    : (Get.snackbar('Warning', 'Here we go 4'));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 1,
                  child: CustomImage(
                    height: 50,
                    fit: BoxFit.cover,
                    path: "${RemoteUrls.rootUrl}${lastViewedBook.book?.thumb}",
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    lastViewedBook.book?.publisher ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    lastViewedBook.book?.publisherYear ?? '',
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    lastViewedBook.book?.isbn10 != ''
                        ? Text(
                            lastViewedBook.book?.isbn10 ?? '',
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : const Text(
                            'N/A',
                            textAlign: TextAlign.end,
                          ),
                    lastViewedBook.book?.isbn13 != ''
                        ? Text(
                            lastViewedBook.book?.isbn13 ?? '',
                            textAlign: TextAlign.end,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )
                        : const Text(
                            'N/A',
                            textAlign: TextAlign.end,
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
