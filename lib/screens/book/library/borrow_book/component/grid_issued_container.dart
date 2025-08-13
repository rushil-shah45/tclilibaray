import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/screens/book/library/borrow_book/controller/borrowed_book_controller.dart';

class GridIssuedContainer extends StatefulWidget {
  const GridIssuedContainer({super.key, required this.controller});

  final BorrowedBookController controller;

  @override
  State<GridIssuedContainer> createState() => _GridIssuedContainerState();
}

class _GridIssuedContainerState extends State<GridIssuedContainer> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: Obx(
        () => MultiSliver(
          children: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: Get.height / 2.5,
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 14),
              delegate: SliverChildBuilderDelegate(
                childCount: widget.controller.issuedModel.value.length,
                (BuildContext context, int index) {
                  final issued = widget.controller.issuedModel.value[index];
                  DateTime parsedDate =
                      DateFormat('yyyy-MM-dd').parse(issued.borrowedEnddate);
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(parsedDate);

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.bookDetailsScreen,
                            arguments: [issued.id, ""]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              color: Colors.grey.shade300, width: 1.w),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: CustomImage(
                                      path:
                                          "${RemoteUrls.rootUrl}${issued.thumb}",
                                      height: Get.height / 3.65,
                                      width: Get.width,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 5,
                                  top: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(40.r),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Container(
                                            height: Get.height / 19.80,
                                            width: Get.width / 10.5,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: primaryGrayColor),
                                            child:
                                                // Icon(
                                                //   (issued.isPaid == 0 ||
                                                //       (widget.controller.mainController.userProfileModel?.roleId != "3" && widget
                                                //           .controller
                                                //           .mainController
                                                //           .userProfileModel!
                                                //           .currentUserPlan!
                                                //           .packageId !=
                                                //           '1'))
                                                //       ? (issued.isBorrowed ==
                                                //       false)
                                                //       ? Icons.lock_open
                                                //       : ((issued
                                                //       .borrowedStartdate !=
                                                //       "" &&
                                                //       issued.borrowedEnddate !=
                                                //           "") &&
                                                //       DateTime.now().isAfter(
                                                //           DateTime.parse(issued
                                                //               .borrowedStartdate)) &&
                                                //       DateTime.now().isBefore(
                                                //           DateTime.parse(
                                                //               issued
                                                //                   .borrowedEnddate)))
                                                //       ? Icons.lock_open
                                                //       : Icons.lock_open
                                                //       : Icons.lock,
                                                //   color: Colors.white,
                                                // ),
                                                const Icon(
                                              Icons.lock_open,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes.bookDetailsScreen,
                                                  arguments: [issued.id, ""]);
                                            },
                                            child: Container(
                                              height: Get.height / 19.80,
                                              width: Get.width / 10.5,
                                              decoration: const BoxDecoration(
                                                color: primaryGrayColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: const Icon(
                                                Icons.remove_red_eye_rounded,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          GestureDetector(
                                            onTap: () {
                                              widget.controller
                                                  .storeFavouriteBook(issued.id)
                                                  .then((value) {
                                                setState(() {
                                                  widget.controller
                                                      .favouriteMark();
                                                });
                                              });
                                            },
                                            child: Container(
                                              height: Get.height / 19.80,
                                              width: Get.width / 10.5,
                                              decoration: const BoxDecoration(
                                                color: primaryGrayColor,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.favorite_outlined,
                                                color:
                                                    issued.isFavorite == false
                                                        ? Colors.white
                                                        : Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: Get.height / 9.1,
                              width: Get.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10.r),
                                    bottomRight: Radius.circular(10.r)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    issued.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RatingBar(
                                        allowHalfRating: true,
                                        initialRating: double.parse(issued.avgRating),
                                        maxRating: 5,
                                        itemSize: 20.0,
                                        ignoreGestures: true,
                                        ratingWidget: RatingWidget(
                                          full: const Icon(Icons.star,
                                              color: Colors.amber),
                                          half: const Icon(Icons.star,
                                              color: Colors.amber),
                                          empty: const Icon(Icons.star_border,
                                              color: Colors.amber),
                                        ),
                                        onRatingUpdate: (double value) {},
                                      ),
                                      Text("(${issued.totalReview})")
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String convertDateFormat(DateTime inputDateTime) {
    final newFormat = DateFormat.yMMMd();
    return newFormat.format(inputDateTime);
  }
}
