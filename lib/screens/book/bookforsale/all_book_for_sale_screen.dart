import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/global_widgets/custom_dialog.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/book/bookforsale/book_details_screen.dart';
import 'package:tcllibraryapp_develop/screens/book/bookforsale/book_payment_screen.dart';
import 'package:tcllibraryapp_develop/screens/book/bookforsale/controller/all_book_for_sale_screen_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/component/custom_authors_bottomsheet.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/component/custom_publisher_bottomSheet.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

class AllBookForSaleScreen extends StatefulWidget {
  const AllBookForSaleScreen({super.key});

  @override
  State<AllBookForSaleScreen> createState() => _AllBookForSaleScreenState();
}

class _AllBookForSaleScreenState extends State<AllBookForSaleScreen> {
  // SettingsDataController settingsDataController = Get.find<SettingsDataController>();
final ScrollController _scrollController = ScrollController();
  var allBookSaleController = Get.put(AllBookForSaleScreenController());

  @override
  void initState() {
    super.initState();
    allBookSaleController.getUserProfile();
    allBookSaleController.getPublisherData();
    allBookSaleController.getAllBooksSaleData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // Load more books when reaching the bottom of the list
        allBookSaleController.loadMoreBooks();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "All",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // return controller.changePage();
          allBookSaleController.page.value = 1; 
          await allBookSaleController.getAllBooksSaleData();
        },
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextField(
                      controller: allBookSaleController.searchController,
                      textInputAction: TextInputAction.done,
                      hintText: 'keyword',
                      hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      // onChanged: controller.onSearchTextChanged,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // controller.searchItem('');
                          allBookSaleController.searchController.clear();
                          allBookSaleController.selectPublisherController
                              .clear();
                          allBookSaleController.selectAuthorController.clear();
                          allBookSaleController.publisherId.value = 0;
                          allBookSaleController.authorId.value = 0;
                          allBookSaleController.getAllBooksSaleData();
                        },
                        child: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Get.width / 2.25,
                          child: GestureDetector(
                            onTap: () {
                              customBottomSheet(
                                context,
                                CustomPublisherBottomSheetForSale(
                                  controller: allBookSaleController,
                                ),
                              );
                            },
                            child: AbsorbPointer(
                              child: CustomTextField(
                                controller: allBookSaleController
                                    .selectPublisherController,
                                hintText: 'Select Category',
                                hintStyle: TextStyle(
                                    fontSize: 12.sp, color: Colors.grey),
                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.w),
                        SizedBox(
                          width: Get.width / 2.25,
                          child: GestureDetector(
                            onTap: () {
                              customBottomSheet(
                                context,
                                CustomAuthorsBottomSheetForBookSale(
                                  controller: allBookSaleController,
                                ),
                              );
                            },
                            child: AbsorbPointer(
                              child: CustomTextField(
                                controller: allBookSaleController
                                    .selectAuthorController,
                                hintText: 'Select Author',
                                hintStyle: TextStyle(
                                    fontSize: 12.sp, color: Colors.grey),
                                maxLines: 1,
                                suffixIcon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.grey,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomBtn(
                          width: Get.width / 6,
                          text: 'Reset',
                          color: const Color(0xFFdc3545),
                          callback: () {
                            allBookSaleController.searchController.clear();
                            allBookSaleController.selectPublisherController
                                .clear();
                            allBookSaleController.selectAuthorController
                                .clear();
                            allBookSaleController.publisherId.value = 0;
                            allBookSaleController.authorId.value = 0;
                            // controller.searchItem('');
                            allBookSaleController.getAllBooksSaleData();
                          },
                        ),
                        SizedBox(width: 5.w),
                        CustomBtn(
                          width: Get.width / 6,
                          text: 'Search',
                          callback: () {
                            // controller.filterBooks();
                            allBookSaleController.getAllBooksSaleData();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Obx(
                      () => allBookSaleController.isLoading.value
                          ? SizedBox(
                              width: Get.width,
                              child: GridView.builder(
                                itemCount: 8,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: Get.height / 2.5,
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 6,
                                        crossAxisSpacing: 14),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 5.h),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade400,
                                      highlightColor: Colors.grey.shade300,
                                      child: Container(
                                        height: Get.height / 2.5,
                                        width: Get.width / 2.5,
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : allBookSaleController.allSaleBookList.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(top: 100.h),
                                  child: const CustomGifImage())
                              : Column(
                                  children: [
                                    SizedBox(
                                      width: Get.width,
                                      child: Obx(
                                        () => GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            mainAxisExtent: Get.height / 2.3,
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 14,
                                          ),
                                          itemCount: allBookSaleController
                                              .allSaleBookList.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final model = allBookSaleController
                                                .allSaleBookList[index];
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h),
                                              child: GestureDetector(
                                                onTap: () {
                                                  log("Center Tap:");
                                                  if (model.isBought == true) {
                                                    Get.toNamed(
                                                      Routes.bookDetailsScreen,
                                                      arguments: [
                                                        model.id,
                                                        "isBookForSale"
                                                      ],
                                                    );
                                                  } else {
                                                    log('Boo Prices :::: ${model.bookPrice}');
                                                    Get.to(() =>
                                                                    BookPaymentScreen(
                                                                      bookPrice:
                                                                          model
                                                                              .bookPrice,
                                                                      title: model
                                                                          .title,
                                                                      id: model
                                                                          .id,
                                                                    ));
                                                              
                                                    // Get.to(() =>
                                                    //     BookDetailsForSaleScreen(
                                                    //       bookID: model.id ?? 0,
                                                    //       bookForSaleTitle:
                                                    //           "Buy - ${model.bookPrice}\$",
                                                    //       onBookForSaleChange:
                                                    //           (status) {
                                                    //         if (Platform
                                                    //             .isIOS) {
                                                    //           customDialog(
                                                    //               context,
                                                    //               'Is which way do you want to pay?',
                                                    //               'InApp',
                                                    //               '', () {
                                                    //             // Get.back();
                                                    //             // Get.to(() => BookPaymentScreen(
                                                    //             //       bookPrice: model.bookPrice,
                                                    //             //       title: model.title,
                                                    //             //       id: model.id,
                                                    //             //     ));
                                                    //           }, () {
                                                    //             Get.back();
                                                    //             Get.to(() =>
                                                    //                 BookPaymentScreen(
                                                    //                   bookPrice:
                                                    //                       model
                                                    //                           .bookPrice,
                                                    //                   title: model
                                                    //                       .title,
                                                    //                   id: model
                                                    //                       .id,
                                                    //                 ));
                                                    //           });
                                                    //         } else {
                                                    //           Get.to(() =>
                                                    //               BookPaymentScreen(
                                                    //                 bookPrice: model
                                                    //                     .bookPrice,
                                                    //                 title: model
                                                    //                     .title,
                                                    //                 id: model
                                                    //                     .id,
                                                    //               ));
                                                    //         }
                                                    //       },
                                                    //     ));
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey.shade300,
                                                        width: 1.w),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    primaryGrayColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r)),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.r),
                                                              child:
                                                                  CustomImage(
                                                                path:
                                                                    "${RemoteUrls.rootUrl}${model.thumb}",
                                                                height:
                                                                    Get.height /
                                                                        3.65,
                                                                width:
                                                                    Get.width,
                                                                fit:
                                                                    BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),
                                                          Positioned(
                                                            left: 5,
                                                            top: 5,
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            40.r),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(5),
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      height: Get
                                                                              .height /
                                                                          19.80,
                                                                      width: Get
                                                                              .width /
                                                                          10.5,
                                                                      decoration: const BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color:
                                                                              primaryGrayColor),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .lock_open,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5.h),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // model.fileType == "url"
                                                                        //     ? (Get.toNamed(Routes.bookDetailsScreen, arguments: model.id))
                                                                        //     : model.isBorrowed == true
                                                                        //         ? (Get.toNamed(Routes.bookDetailsScreen, arguments: model.id))
                                                                        //         : Get.snackbar('Warning', 'First, you need to borrow this book.');
                                                                        if (model.isBought ==
                                                                            true) {
                                                                          Get.toNamed(
                                                                            Routes.bookDetailsScreen,
                                                                            arguments: [
                                                                              model.id,
                                                                              "isBookForSale"
                                                                            ],
                                                                          );
                                                                        } else {
                                                                          Get.snackbar(
                                                                              'Warning',
                                                                              'First, you need to purchased this book.');
                                                                        }
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height: Get.height /
                                                                            19.80,
                                                                        width: Get.width /
                                                                            10.5,
                                                                        decoration: const BoxDecoration(
                                                                            color:
                                                                                primaryGrayColor,
                                                                            shape:
                                                                                BoxShape.circle),
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .remove_red_eye_rounded,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            5.h),
                                                                    GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        // controller.storeFavouriteBook(model.id ?? 0).then((value) {
                                                                        //   controller.favouriteMark();

                                                                        // allBookSaleController
                                                                        // });

                                                                        allBookSaleController.storeFavouriteBook(
                                                                            id: model.id ??
                                                                                0);
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height: Get.height /
                                                                            19.80,
                                                                        width: Get.width /
                                                                            10.5,
                                                                        decoration: const BoxDecoration(
                                                                            color:
                                                                                primaryGrayColor,
                                                                            shape:
                                                                                BoxShape.circle),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .favorite_outlined,
                                                                          color: model.isFavorite == false
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
                                                        height: Get.height / 8,
                                                        width: Get.width,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.r),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10.r)),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              model.title ?? '',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                height: 5.h),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                RatingBarIndicator(
                                                                  rating: double
                                                                      .parse(model
                                                                              .avgRating ??
                                                                          ''),
                                                                  itemCount: 5,
                                                                  itemSize:
                                                                      20.0,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  itemBuilder: (context,
                                                                          _) =>
                                                                      const Icon(
                                                                          Icons
                                                                              .star_outlined,
                                                                          color:
                                                                              Colors.amber),
                                                                ),
                                                                Text(
                                                                    "(${model.totalReview})"),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                                height: 5.h),
                                                            CustomBtn(
                                                              width: Get.width /
                                                                  4.3.w,
                                                              text: model.isBought ==
                                                                      true
                                                                  ? 'Bought'
                                                                  : "Buy - ${model.bookPrice}\$",
                                                              gradient:
                                                                  LinearGradient(
                                                                begin: Alignment
                                                                    .centerLeft,
                                                                end: Alignment
                                                                    .centerRight,
                                                                colors: model
                                                                            .isBought ==
                                                                        true
                                                                    ? <Color>[
                                                                        blackGrayColor,
                                                                        blackGrayColor
                                                                      ]
                                                                    : <Color>[
                                                                        primaryColor,
                                                                        primColor
                                                                      ],
                                                              ),
                                                              callback:
                                                                  model.isBought ==
                                                                          true
                                                                      ? () {}
                                                                      : () {
                                                                          // ? Get.toNamed(Routes.paymentScreen, arguments: [null, "", ""])
                                                                          // if (Platform
                                                                          //     .isIOS) {
                                                                          //   customDialog(
                                                                          //       context,
                                                                          //       'Is which way do you want to pay?',
                                                                          //       'InApp',
                                                                          //       '',
                                                                          //       () {
                                                                          //     Get.back();
                                                                          //     Get.to(() => BookPaymentScreen(
                                                                          //           bookPrice: model.bookPrice,
                                                                          //           title: model.title,
                                                                          //           id: model.id,
                                                                          //         ));
                                                                          //   }, () {});
                                                                          // } else {
                                                                            Get.to(() =>
                                                                                BookPaymentScreen(
                                                                                  bookPrice: model.bookPrice,
                                                                                  title: model.title,
                                                                                  id: model.id,
                                                                                ));
                                                                          // }
                                                                        },
                                                            ),
                                                            SizedBox(
                                                                height: 5.h),
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
                                    ),
                                    Visibility(
                                      visible:
                                          allBookSaleController.isFetchingMore.value,
                                      child: const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                  ],
                                ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void customBottomSheet(context, Widget widget) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return widget;
      },
    );
  }
}
