import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/model/dashboard_user_model.dart';

class DashboardCardLastBorrowedBook extends StatelessWidget {
  const DashboardCardLastBorrowedBook(
      {super.key, required this.lastBorrowedBook, required this.controller});

  final LastBorrowedBook lastBorrowedBook;
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            lastBorrowedBook.book!.fileType == "url"
                ? (Get.toNamed(Routes.bookDetailsScreen,
                    arguments: [lastBorrowedBook.book!.id, ""]))
                : (lastBorrowedBook.book!.isPaid == 0 ||
                        controller.mainController.userProfileModel!
                                .currentUserPlan!.packageId !=
                            '1')
                    ? (lastBorrowedBook.book!.isBorrowed == false)
                        ? (Get.snackbar(
                            'Warning', 'First, you need to borrow this book.'))
                        : lastBorrowedBook.book!.borrowedNextdate.isEmpty
                            ? (Get.toNamed(Routes.bookDetailsScreen,
                                arguments: [lastBorrowedBook.book!.id, ""]))
                            : (DateTime.now().isAfter(DateTime.parse(
                                    lastBorrowedBook.book!.borrowedNextdate)))
                                ? (Get.snackbar('Warning',
                                    'First, you need to borrow this book.'))
                                : (DateTime.now().isAfter(DateTime.parse(lastBorrowedBook.book!.borrowedEnddate)) &&
                                        DateTime.now().isBefore(DateTime.parse(
                                            lastBorrowedBook
                                                .book!.borrowedNextdate)))
                                    ? (Get.snackbar('Warning', 'First, you need to borrow this book.'))
                                    : (Get.toNamed(Routes.bookDetailsScreen, arguments: [lastBorrowedBook.book!.id, ""]))
                    : (Get.snackbar('Warning', 'First, you need to borrow this book.'));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 1,
                  child: CustomImage(
                    height: 50,
                    fit: BoxFit.cover,
                    path:
                        "${RemoteUrls.rootUrl}${lastBorrowedBook.book?.thumb}",
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    lastBorrowedBook.book?.publisher ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    lastBorrowedBook.book?.publisherYear ?? '',
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      lastBorrowedBook.book?.isbn10 != ''
                          ? Text(
                              lastBorrowedBook.book?.isbn10 ?? '',
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : const Text(
                              'N/A',
                              textAlign: TextAlign.end,
                            ),
                      lastBorrowedBook.book?.isbn13 != ''
                          ? Text(
                              lastBorrowedBook.book?.isbn13 ?? '',
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : const Text(
                              'N/A',
                              textAlign: TextAlign.end,
                            ),
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
