import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/book/library/favourite_books/controller/favourite_books_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

class GridFavouriteContainer extends StatefulWidget {
  const GridFavouriteContainer({super.key, required this.controller});

  final FavouriteController controller;

  @override
  State<GridFavouriteContainer> createState() => _GridFavouriteContainerState();
}

class _GridFavouriteContainerState extends State<GridFavouriteContainer> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: Obx(
            () =>
            MultiSliver(
              children: [
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: Get.height / 2.3,
                      crossAxisCount: 2,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 14),
                  delegate: SliverChildBuilderDelegate(
                    childCount: widget.controller.favouriteBooksModel.value
                        .length,
                        (BuildContext context, int index) {
                      final favourite =
                      widget.controller.favouriteBooksModel.value[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: GestureDetector(
                          onTap: () {
                            widget.controller.mainController.userProfileModel
                                ?.roleId == "3" || favourite.book.fileType ==
                                "url"
                                ? (Get.toNamed(
                                Routes
                                    .bookDetailsScreen,
                                arguments: [favourite.book.id, ""]))
                                :
                            (favourite.book.isPaid ==
                                0 ||
                                widget.controller
                                    .mainController
                                    .userProfileModel!
                                    .currentUserPlan!
                                    .packageId !=
                                    '1')
                                ? (favourite.book.isBorrowed ==
                                false)
                                ? (Get.snackbar('Warning',
                                'First, you need to borrow this book.'))
                                : (favourite.book.borrowedNextdate !=
                                "") && (DateTime.now().isAfter(
                                DateTime.parse(favourite.book
                                    .borrowedNextdate)))
                                ? (Get.snackbar('Warning',
                                'First, you need to borrow this book.'))
                                : (favourite.book.borrowedStartdate !=
                                "" &&
                                favourite.book.borrowedEnddate !=
                                    "") && (DateTime.now().isAfter(
                                DateTime.parse(
                                    favourite.book.borrowedEnddate)) &&
                                DateTime.now().isBefore(
                                    DateTime.parse(
                                        favourite.book.borrowedNextdate)))
                                ? (Get.snackbar('Warning',
                                'First, you need to borrow this book.'))
                                : (Get.toNamed(
                                Routes.bookDetailsScreen,
                                arguments: [favourite.book.id, ""]))
                                : (Get.snackbar('Warning',
                              'First, you need to borrow this book.',
                            ),
                            );
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
                                        borderRadius: BorderRadius.circular(
                                            10.r),
                                        child: CustomImage(
                                          path:
                                          "${RemoteUrls.rootUrl}${favourite.book
                                              .thumb}",
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
                                          borderRadius: BorderRadius.circular(
                                              40.r),
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
                                                child: widget.controller
                                                    .mainController
                                                    .userProfileModel
                                                    ?.roleId == "3"
                                                    ? const Icon(
                                                  Icons.lock_open,
                                                  color: Colors.white,
                                                )
                                                    : Icon(
                                                  (favourite.book
                                                      .isPaid ==
                                                      0 ||
                                                      widget.controller
                                                          .mainController
                                                          .userProfileModel!
                                                          .currentUserPlan
                                                          ?.packageId !=
                                                          '1')
                                                      ? (favourite.book
                                                      .isBorrowed == false)
                                                      ? Icons.lock_open
                                                      : (favourite.book
                                                      .borrowedStartdate !=
                                                      "" &&
                                                      favourite.book
                                                          .borrowedEnddate !=
                                                          "") && (DateTime.now()
                                                      .isAfter(DateTime.parse(
                                                      favourite.book
                                                          .borrowedStartdate)) &&
                                                      DateTime.now().isBefore(
                                                          DateTime.parse(
                                                              favourite.book
                                                                  .borrowedEnddate)))
                                                      ? Icons.lock_open
                                                      : Icons
                                                      .lock_open
                                                      : Icons
                                                      .lock,
                                                  color: Colors
                                                      .white,
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              GestureDetector(
                                                onTap: () {
                                                  widget.controller
                                                      .mainController
                                                      .userProfileModel
                                                      ?.roleId == "3" ||
                                                      favourite.book.fileType ==
                                                          "url"
                                                      ? (Get.toNamed(
                                                      Routes
                                                          .bookDetailsScreen,
                                                      arguments: [favourite.book.id, ""]))
                                                      : favourite.book
                                                      .isBorrowed ==
                                                      true ? Get.toNamed(
                                                      Routes
                                                          .bookDetailsScreen,
                                                      arguments:
                                                      [favourite.book.id, ""]) : Get
                                                      .snackbar('Warning',
                                                      'First, you need to borrow this book.');
                                                },
                                                child: Container(
                                                  height: Get.height / 19.80,
                                                  width: Get.width / 10.5,
                                                  decoration: const BoxDecoration(
                                                    color: primaryGrayColor,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons
                                                        .remove_red_eye_rounded,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 5.h),
                                              GestureDetector(
                                                onTap: () {
                                                  widget.controller
                                                      .storeFavouriteBook(
                                                      favourite.book.id)
                                                      .then((value) {
                                                    widget.controller
                                                        .favouriteMark();
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
                                                    favourite.book.isFavorite ==
                                                        false
                                                        ? Colors
                                                        .white
                                                        : Colors
                                                        .red,
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
                                  height: Get.height / 7.8,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10.r),
                                        bottomRight: Radius.circular(10.r)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Text(
                                        favourite.book.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 14.sp),
                                      ),
                                      SizedBox(height: 5.h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          RatingBar(
                                            allowHalfRating: true,
                                            initialRating: double.parse(
                                                favourite.book.avgRating),
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
                                          Text("(${favourite.book
                                              .totalReview})"),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                      Visibility(
                                        visible: widget.controller
                                            .mainController.userProfileModel
                                            ?.roleId != "3",
                                        child: SizedBox(
                                          child: Column(
                                            children: [
                                              SizedBox(height: 5.h),
                                              CustomBtn(
                                                width: Get.width / 5,
                                                text:
                                                favourite.book.fileType == "url"
                                                    ? "Watch Now"
                                                    :
                                                (favourite.book.isPaid ==
                                                    0 ||
                                                    widget.controller
                                                        .mainController
                                                        .userProfileModel!
                                                        .currentUserPlan
                                                        ?.packageId !=
                                                        '1')
                                                    ? (favourite.book
                                                    .isBorrowed ==
                                                    false)
                                                    ? 'Borrow'
                                                    : (favourite.book
                                                    .borrowedNextdate !=
                                                    "") && (DateTime.now()
                                                    .isAfter(
                                                    DateTime.parse(
                                                        favourite.book
                                                            .borrowedNextdate)))
                                                    ? 'Borrow'
                                                    : (favourite.book
                                                    .borrowedEnddate !=
                                                    "" &&
                                                    favourite.book
                                                        .borrowedNextdate !=
                                                        "") && (DateTime.now()
                                                    .isAfter(DateTime.parse(
                                                    favourite.book
                                                        .borrowedEnddate)) &&
                                                    DateTime.now().isBefore(
                                                        DateTime.parse(
                                                            favourite.book
                                                                .borrowedNextdate)))
                                                    ? 'Locked'
                                                    : 'Borrowed'
                                                    : 'Premium',
                                                gradient: favourite.book
                                                    .fileType == "url"
                                                    ? const LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: <Color>[
                                                    primaryColor,
                                                    primColor
                                                  ],
                                                )
                                                    : favourite.book
                                                    .isPaid ==
                                                    0 ||
                                                    widget.controller
                                                        .mainController
                                                        .userProfileModel!
                                                        .currentUserPlan
                                                        ?.packageId !=
                                                        '1'
                                                    ? favourite.book
                                                    .isBorrowed ==
                                                    false
                                                    ? const LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: <Color>[
                                                    primaryColor,
                                                    primaryColor
                                                  ],
                                                )
                                                    : (favourite.book
                                                    .borrowedNextdate !=
                                                    "") && (DateTime.now()
                                                    .isAfter(
                                                    DateTime.parse(
                                                        favourite.book
                                                            .borrowedNextdate)))
                                                    ? const LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: <Color>[
                                                    primaryColor,
                                                    primaryColor
                                                  ],
                                                )
                                                    : (favourite.book
                                                    .borrowedEnddate !=
                                                    "" &&
                                                    favourite.book
                                                        .borrowedNextdate !=
                                                        "") && (DateTime.now()
                                                    .isAfter(DateTime.parse(
                                                    favourite.book
                                                        .borrowedEnddate)) &&
                                                    DateTime.now().isBefore(
                                                        DateTime.parse(
                                                            favourite.book
                                                                .borrowedNextdate)))
                                                    ? const LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: <Color>[
                                                    blackGrayColor,
                                                    blackGrayColor
                                                  ],
                                                )
                                                    : const LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: <Color>[
                                                    blackGrayColor,
                                                    blackGrayColor
                                                  ],
                                                )
                                                    : const LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                  colors: <Color>[
                                                    primaryColor,
                                                    primColor
                                                  ],
                                                ),
                                                callback: () {
                                                  favourite.book.fileType ==
                                                      "url"
                                                      ? (Get.toNamed(
                                                      Routes
                                                          .bookDetailsScreen,
                                                      arguments: [favourite.book.id, ""]))
                                                      :
                                                  favourite.book.isPaid == 0 ||
                                                      widget.controller
                                                          .mainController
                                                          .userProfileModel!
                                                          .currentUserPlan!
                                                          .packageId !=
                                                          '1'
                                                      ? (favourite.book
                                                      .isBorrowed ==
                                                      false)
                                                      ? (widget.controller
                                                      .storeBorrowBook(
                                                      favourite.book.id))
                                                      : (favourite.book
                                                      .borrowedNextdate !=
                                                      "") && (DateTime.now()
                                                      .isAfter(
                                                      DateTime.parse(
                                                          favourite.book
                                                              .borrowedNextdate)))
                                                      ? (widget.controller
                                                      .storeBorrowBook(
                                                      favourite.book.id))
                                                      : (favourite.book
                                                      .borrowedEnddate !=
                                                      "" &&
                                                      favourite.book
                                                          .borrowedNextdate !=
                                                          "") && (DateTime.now()
                                                      .isAfter(
                                                      DateTime.parse(
                                                          favourite.book
                                                              .borrowedEnddate)) &&
                                                      DateTime.now()
                                                          .isBefore(
                                                          DateTime.parse(
                                                              favourite.book
                                                                  .borrowedNextdate)))
                                                      ? ''
                                                      : ''
                                                      : (Get.toNamed(
                                                      Routes
                                                          .pricing));
                                                },
                                              ),
                                              SizedBox(height: 5.h),
                                            ],
                                          ),
                                        ),
                                      ),
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
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: widget.controller.gettingMoreData.value,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
