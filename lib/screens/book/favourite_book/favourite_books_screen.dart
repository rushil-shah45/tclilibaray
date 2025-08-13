import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:tcllibraryapp_develop/screens/book/favourite_book/component/favorite_book_card.dart';
import 'package:tcllibraryapp_develop/screens/book/favourite_book/controller/favourite_books_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';

import '../../../core/utils/constants.dart';
import '../../../core/utils/custom_image.dart';
import '../../../data/remote_urls.dart';
import '../../../routes/routes.dart';
import '../../../widgets/custom_btn.dart';

class FavouriteBooksScreen extends StatefulWidget {
   FavouriteBooksScreen({super.key,this.isMain= false});
   bool? isMain ;

  @override
  State<FavouriteBooksScreen> createState() => _FavouriteBooksScreenState();
}

class _FavouriteBooksScreenState extends State<FavouriteBooksScreen> {
  final ScrollController _scrollController = ScrollController();
  FavouriteBooksController controller = Get.find();

  void _scroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.loadMoreFiles();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          controller.mainController.userProfileModel?.roleId == 2
              ? "Declined Books"
              : "Favourite Books",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        leading: widget.isMain == false ? IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)) : const SizedBox(),
      ),
      body: controller.mainController.userProfileModel?.roleId == 1
          ? RefreshIndicator(
              onRefresh: () async {
                return controller.changePage();
              },
              child: Obx(
                () => controller.isLoading.value
                    ? Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade400,
                              highlightColor: Colors.grey.shade300,
                              child: Container(
                                height: 40,
                                margin: const EdgeInsets.only(bottom: 5),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(0.r),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Get.width,
                            child: ListView.builder(
                              itemCount: 6,
                              shrinkWrap: true,
                              // physics: const AlwaysScrollableScrollPhysics(),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(left: 16.w, right: 16.w),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade400,
                                    highlightColor: Colors.grey.shade300,
                                    child: Container(
                                      height: 65,
                                      margin: const EdgeInsets.only(bottom: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(0.r),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : controller.favouriteBooksModel.value.isEmpty
                        ? CustomScrollView(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            slivers: [
                                SliverPadding(
                                    padding: EdgeInsets.only(top: 120.h),
                                    sliver: const SliverToBoxAdapter(
                                        child: CustomGifImage()))
                              ])
                        :  CustomScrollView(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverPadding(
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
                                    childCount: controller.favouriteBooksModel.value
                                        .length,
                                        (BuildContext context, int index) {
                                      final favourite =
                                      controller.favouriteBooksModel.value[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(vertical: 5.h),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.mainController.userProfileModel
                                                ?.roleId == "3" || favourite.book.fileType ==
                                                "url"
                                                ? (Get.toNamed(
                                                Routes
                                                    .bookDetailsScreen,
                                                arguments: [favourite.book.id, ""]))
                                                :
                                            (favourite.book.isPaid ==
                                                0 ||
                                                controller
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
                                                arguments: [favourite.book.id,""]))
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
                                                                child: controller
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
                                                                      controller
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
                                                                  controller
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
                                                                      [favourite.book.id,""]) : Get
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
                                                                  controller.storeFavouriteBook(
                                                                      favourite.book.id)
                                                                      .then((value) {
                                                                    controller
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
                                                        visible: controller
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
                                                                    controller
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
                                                                   controller
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
                                                                      controller
                                                                          .mainController
                                                                          .userProfileModel!
                                                                          .currentUserPlan!
                                                                          .packageId !=
                                                                          '1'
                                                                      ? (favourite.book
                                                                      .isBorrowed ==
                                                                      false)
                                                                      ? (controller
                                                                      .storeBorrowBook(
                                                                      favourite.book.id))
                                                                      : (favourite.book
                                                                      .borrowedNextdate !=
                                                                      "") && (DateTime.now()
                                                                      .isAfter(
                                                                      DateTime.parse(
                                                                          favourite.book
                                                                              .borrowedNextdate)))
                                                                      ? (controller
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
                                    visible: controller.gettingMoreData.value,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      ),
                    )
                  ],
                ),
                // CustomScrollView(
                //             controller: _scrollController,
                //             physics: const AlwaysScrollableScrollPhysics(),
                //             slivers: [
                //               SliverPadding(
                //                 padding: EdgeInsets.symmetric(horizontal: 16.w),
                //                 sliver: SliverToBoxAdapter(
                //                   child: Container(
                //                     padding: const EdgeInsets.all(10),
                //                     decoration: BoxDecoration(
                //                       color: Colors.grey.shade100,
                //                       border: Border.all(
                //                           color: Colors.grey.shade100),
                //                     ),
                //                     child: Column(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.center,
                //                       children: [
                //                         Row(
                //                           mainAxisAlignment:
                //                               MainAxisAlignment.start,
                //                           children: [
                //                             SizedBox(width: 25.w),
                //                             SizedBox(
                //                               child: Text(
                //                                 "Book",
                //                                 style: TextStyle(
                //                                     fontSize:
                //                                         controller.isTablet
                //                                             ? 10.sp
                //                                             : 12.sp,
                //                                     fontWeight:
                //                                         FontWeight.bold),
                //                               ),
                //                             ),
                //                             SizedBox(width: 70.w),
                //                             SizedBox(
                //                               child: Text(
                //                                 "Publisher",
                //                                 style: TextStyle(
                //                                     fontSize:
                //                                         controller.isTablet
                //                                             ? 10.sp
                //                                             : 12.sp,
                //                                     fontWeight:
                //                                         FontWeight.bold),
                //                               ),
                //                             ),
                //                             SizedBox(width: 60.w),
                //                             SizedBox(
                //                               child: Text(
                //                                 "ISBN",
                //                                 style: TextStyle(
                //                                     fontSize:
                //                                         controller.isTablet
                //                                             ? 10.sp
                //                                             : 12.sp,
                //                                     fontWeight:
                //                                         FontWeight.bold),
                //                               ),
                //                             ),
                //                           ],
                //                         )
                //                       ],
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //               SliverPadding(
                //                 padding: EdgeInsets.only(
                //                     left: 16.w, right: 16.w, bottom: 50.h),
                //                 sliver: SliverList(
                //                   delegate: SliverChildBuilderDelegate(
                //                     childCount: controller
                //                         .favouriteBooksModel.value.length,
                //                     (context, index) {
                //                       return Container(
                //                         padding: const EdgeInsets.all(10),
                //                         decoration: BoxDecoration(
                //                             color: Colors.white,
                //                             border: Border.all(
                //                                 color: Colors.grey.shade100)),
                //                         child: FavoriteBookCard(
                //                           favoriteBookModel: controller
                //                               .favouriteBooksModel.value[index],
                //                         ),
                //                       );
                //                     },
                //                   ),
                //                 ),
                //               ),
                //               SliverToBoxAdapter(
                //                 child: Visibility(
                //                   visible: controller.gettingMoreData.value,
                //                   child: const Center(
                //                     child: CircularProgressIndicator(),
                //                   ),
                //                 ),
                //               ),
                //               SliverToBoxAdapter(child: SizedBox(height: 50.h))
                //             ],
                //           ),
              ),
            )
          : controller.mainController.userProfileModel?.roleId == 2
              ? RefreshIndicator(
                  onRefresh: () async {
                    return controller.getDeclineBook();
                  },
                  child: Obx(
                    () => controller.isDeclinedLoading.value
                        ? Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.w, right: 16.w),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade400,
                                  highlightColor: Colors.grey.shade300,
                                  child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(0.r),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width,
                                child: ListView.builder(
                                  itemCount: 6,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 16.w, right: 16.w),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade400,
                                        highlightColor: Colors.grey.shade300,
                                        child: Container(
                                          height: 65,
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(0.r),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : controller.booksModel?.books == null
                            ? CustomScrollView(
                                controller: _scrollController,
                                physics: const AlwaysScrollableScrollPhysics(),
                                slivers: [
                                    SliverPadding(
                                        padding: EdgeInsets.only(top: 120.h),
                                        sliver: const SliverToBoxAdapter(
                                            child: CustomGifImage()))
                                  ])
                            : CustomScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                slivers: [
                                  SliverPadding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    sliver: SliverToBoxAdapter(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          border: Border.all(
                                              color: Colors.grey.shade100),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                "Book",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(width: 60.w),
                                            SizedBox(
                                              child: Text(
                                                "Publisher",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(width: 30.w),
                                            SizedBox(
                                              child: Text(
                                                "ISBN",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(width: 35.w),
                                            SizedBox(
                                              child: Text(
                                                "Action",
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SliverPadding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        childCount:
                                            controller.booksModel?.books.length,
                                        (context, index) {
                                          return Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                  color: Colors.grey.shade100),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: Get.width / 3.8,
                                                  child: Text(
                                                    "${controller.booksModel?.books[index].title}",
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(width: 2.w),
                                                SizedBox(
                                                  width: Get.width / 5.8,
                                                  child: Text(
                                                    "${controller.booksModel?.books[index].publisher}",
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(width: 2.w),
                                                SizedBox(
                                                  width: Get.width / 3.7,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      controller
                                                                  .booksModel
                                                                  ?.books[index]
                                                                  .isbn10 ==
                                                              ''
                                                          ? const Text("N/A")
                                                          : Text(
                                                              "${controller.booksModel?.books[index].isbn10}",
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                      controller
                                                                  .booksModel
                                                                  ?.books[index]
                                                                  .isbn13 ==
                                                              ''
                                                          ? const Text("N/A")
                                                          : Text(
                                                              "${controller.booksModel?.books[index].isbn13}",
                                                              maxLines: 1,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 2.w),
                                                SizedBox(
                                                  width: Get.width / 9,
                                                  child: PopupMenuButton(
                                                    onSelected: (value) {
                                                      controller
                                                          .onMenuItemSelected(
                                                              value as int,
                                                              controller
                                                                  .booksModel!
                                                                  .books[index]
                                                                  .id, context);
                                                    },
                                                    offset: Offset(
                                                        Get.width / 10,
                                                        Get.height / 20),
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      8.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      8.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      8.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      8.0)),
                                                    ),
                                                    itemBuilder: (ctx) => [
                                                      _buildPopupMenuItem(
                                                          'View',
                                                          Options.view.index),
                                                      _buildPopupMenuItem(
                                                          'Delete',
                                                          Options.delete.index),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SliverToBoxAdapter(
                                    child: SizedBox(height: 50.h),
                                  ),
                                ],
                              ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    return controller.getFavouriteBooks();
                  },
                  child: Obx(
                    () => controller.isLoading.value
                        ? Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 16.w, right: 16.w),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade400,
                                  highlightColor: Colors.grey.shade300,
                                  child: Container(
                                    height: 40,
                                    margin: const EdgeInsets.only(bottom: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(0.r),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width,
                                child: ListView.builder(
                                  itemCount: 6,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 16.w, right: 16.w),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade400,
                                        highlightColor: Colors.grey.shade300,
                                        child: Container(
                                          height: 65,
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(0.r),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : controller.favouriteBooksModel.value.isEmpty
                            ? CustomScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                slivers: [
                                    SliverPadding(
                                        padding: EdgeInsets.only(top: 140.h),
                                        sliver: const SliverToBoxAdapter(
                                            child: CustomGifImage()))
                                  ])
                            : CustomScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                slivers: [
                                  SliverPadding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.w),
                                    sliver: SliverToBoxAdapter(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          border: Border.all(
                                              color: Colors.grey.shade100),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 25.w),
                                                SizedBox(
                                                  child: Text(
                                                    "Book",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(width: 70.w),
                                                SizedBox(
                                                  child: Text(
                                                    "Publisher",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(width: 60.w),
                                                SizedBox(
                                                  child: Text(
                                                    "ISBN",
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SliverPadding(
                                    padding: EdgeInsets.only(
                                        left: 16.w, right: 16.w),
                                    sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        childCount: controller
                                            .favouriteBooksModel.value.length,
                                        (context, index) {
                                          return Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade100)),
                                            child: FavoriteBookCard(
                                              favoriteBookModel: controller
                                                  .favouriteBooksModel
                                                  .value[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SliverToBoxAdapter(
                                    child: Visibility(
                                      visible: controller.gettingMoreData.value,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ),
                                  SliverToBoxAdapter(
                                      child: SizedBox(height: 50.h)),
                                ],
                              ),
                  ),
                ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(title,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
