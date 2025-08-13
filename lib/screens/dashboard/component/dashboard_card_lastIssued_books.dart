import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/model/dashboard_institution_model.dart';

class DashboardCardLastIssuedBook extends StatelessWidget {
  const DashboardCardLastIssuedBook(
      {super.key, required this.lastIssuedBook, required this.controller});

  final LastIssuedBook lastIssuedBook;
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            (lastIssuedBook.book!.isPaid == 0 ||
                    controller.mainController.userProfileModel!.currentUserPlan!
                            .packageId !=
                        '1')
                ? (lastIssuedBook.book!.isBorrowed == false)
                    ? (Get.snackbar(
                        'Warning', 'First, you need to borrow this book.'))
                    : (DateTime.now().isAfter(DateTime.parse(
                            lastIssuedBook.book!.borrowedNextdate)))
                        ? (Get.snackbar(
                            'Warning', 'First, you need to borrow this book.'))
                        : (DateTime.now().isAfter(DateTime.parse(
                                    lastIssuedBook.book!.borrowedEnddate)) &&
                                DateTime.now().isBefore(DateTime.parse(
                                    lastIssuedBook.book!.borrowedNextdate)))
                            ? (Get.snackbar(
                                'Warning', 'First, you need to borrow this book.'))
                            : (Get.toNamed(Routes.bookDetailsScreen,
                                arguments: [lastIssuedBook.book!.id, ""]))
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
                    path: "${RemoteUrls.rootUrl}${lastIssuedBook.book?.thumb}",
                  )),
              Expanded(
                  flex: 3,
                  child: Text(
                    lastIssuedBook.book?.publisher ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              Expanded(
                  flex: 2,
                  child: Text(
                    lastIssuedBook.book?.publisherYear ?? '',
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                flex: 2,
                child: Text(
                  lastIssuedBook.book?.isbn10 ?? '',
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
