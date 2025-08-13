import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/controller/dashboard_controller.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/model/dashboard_institution_model.dart';

class DashboardCardLastViewedBook extends StatelessWidget {
  const DashboardCardLastViewedBook(
      {super.key, required this.lastViewedBooks, required this.controller});

  final LastViewedBook lastViewedBooks;
  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.bookDetailsScreen,
                arguments: [lastViewedBooks.book!.id, ""]);
          },
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 1,
                    child: CustomImage(
                      height: 50,
                      fit: BoxFit.cover,
                      path:
                          "${RemoteUrls.rootUrl}${lastViewedBooks.book?.thumb}",
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      lastViewedBooks.book?.publisher ?? '',
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      lastViewedBooks.book?.publisherYear ?? '',
                      textAlign: TextAlign.center,
                    )),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      lastViewedBooks.book?.isbn10 != ''
                          ? Text(
                              lastViewedBooks.book?.isbn10 ?? '',
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : const Text(
                              'N/A',
                              textAlign: TextAlign.end,
                            ),
                      lastViewedBooks.book?.isbn13 != ''
                          ? Text(
                              lastViewedBooks.book?.isbn13 ?? '',
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
        ),
      ],
    );
  }
}
