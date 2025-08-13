import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/book/bookSummary/controller/book_summary_controller.dart';

class BookCover extends StatelessWidget {
  BookCover(
      {super.key,
      required this.controller,
      required this.isBookForSale,
      required this.bookForSaleTitle,
      required this.onBookForSaleChange});

  final BookSummaryController controller;
  bool isBookForSale;
  String bookForSaleTitle;
  Function(bool callback) onBookForSaleChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.bookSummaryDetail.value != null &&
                  controller.bookSummaryDetail.value!.thumb.isNotEmpty
              ? controller.isLoading.value
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade200,
                      child: Container(
                        height: Get.height / 2.5,
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: SizedBox(
                        height: Get.height / 2.5,
                        width: 200,
                        child: CachedNetworkImage(
                          imageUrl:
                              "${RemoteUrls.rootUrl}${controller.bookSummaryDetail.value!.thumb}",
                          height: Get.height / 2.5,
                          width: 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
              : Image.asset('assets/images/default.jpeg',
                  height: Get.height / 4, width: 200.h, fit: BoxFit.contain),
        ),
      ],
    );
  }
}
