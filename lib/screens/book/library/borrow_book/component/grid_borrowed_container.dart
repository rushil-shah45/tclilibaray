import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/core/utils/utils.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/book/library/borrow_book/controller/borrowed_book_controller.dart';

class GridBorrowedContainer extends StatefulWidget {
  const GridBorrowedContainer({super.key, required this.controller});

  final BorrowedBookController controller;

  @override
  State<GridBorrowedContainer> createState() => _GridBorrowedContainerState();
}

class _GridBorrowedContainerState extends State<GridBorrowedContainer> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: Obx(
        () => MultiSliver(
          children: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: widget.controller.isTablet
                      ? Get.height / 2.4
                      : Get.height / 2.3,
                  crossAxisCount: 2,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 14),
              delegate: SliverChildBuilderDelegate(
                childCount: widget.controller.borrowedModel.value.length,
                (BuildContext context, int index) {
                  final borrowed = widget.controller.borrowedModel.value[index];
                  // DateTime parsedDate =
                  //     DateFormat('yyyy-MM-dd').parse(borrowed.borrowedEnddate);
                  // String formattedDate =
                  //     DateFormat('dd-MMM-yyyy').format(parsedDate);

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.bookDetailsScreen,
                            arguments: [borrowed.id, ""]);
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
                                          "${RemoteUrls.rootUrl}${borrowed.thumb}",
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
                                            child: Icon(
                                              (borrowed.isPaid == 0 ||
                                                      widget
                                                              .controller
                                                              .mainController
                                                              .userProfileModel!
                                                              .currentUserPlan
                                                              ?.packageId !=
                                                          '1')
                                                  ? (borrowed.isBorrowed ==
                                                          false)
                                                      ? Icons.lock_open
                                                      : borrowed.borrowedEnddate
                                                              .isEmpty
                                                          ? Icons.lock_open
                                                          : (DateTime.now().isAfter(
                                                                      DateTime.parse(
                                                                          borrowed
                                                                              .borrowedStartdate)) &&
                                                                  DateTime.now()
                                                                      .isBefore(
                                                                          DateTime.parse(
                                                                              borrowed.borrowedEnddate)))
                                                              ? Icons.lock_open
                                                              : Icons.lock_open
                                                  : Icons.lock,
                                              color: Colors.white,
                                            ),
                                          ),
                                          SizedBox(height: 5.h),
                                          GestureDetector(
                                            onTap: () {
                                              Get.toNamed(
                                                  Routes.bookDetailsScreen,
                                                  arguments: [borrowed.id, ""]);
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
                                                  .storeFavouriteBook(
                                                      borrowed.id)
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
                                                    borrowed.isFavorite == false
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
                            SizedBox(height: 3.h),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Text(
                                borrowed.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            // SizedBox(height: 3.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBarIndicator(
                                  rating: double.parse(borrowed.avgRating),
                                  itemCount: 5,
                                  itemSize: 20.0,
                                  direction: Axis.horizontal,
                                  itemBuilder: (context, _) => const Icon(
                                      Icons.star_outlined,
                                      color: Colors.amber),
                                ),
                                Text("(${borrowed.totalReview})")
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              // height: Get.height / 30,
                              // width: Get.width / 2.6,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 3),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0),
                              decoration: BoxDecoration(
                                color: validTillColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Center(
                                child: Text(
                                  "Valid till - ${borrowed.borrowedEnddate == "" ? "LifeTime" : Utils.formatDate(borrowed.borrowedEnddate)}",
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: widget.controller.isTablet
                                        ? 10.sp
                                        : 12.sp,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
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
}
