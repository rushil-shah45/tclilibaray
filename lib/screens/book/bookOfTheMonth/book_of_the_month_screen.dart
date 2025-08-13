import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/SettingsDataController.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/global_widgets/custom_dialog.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/book/bookforsale/book_payment_screen.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/component/custom_authors_bottomsheet.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/component/custom_publisher_bottomSheet.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/controller/all_books_controller.dart';

class BookOfTheMonthScreen extends StatefulWidget {
  const BookOfTheMonthScreen({super.key});

  @override
  State<BookOfTheMonthScreen> createState() => _BookOfTheMonthScreenState();
}

class _BookOfTheMonthScreenState extends State<BookOfTheMonthScreen> {
  final ScrollController _scrollController = ScrollController();
  // AllBooksController controller = Get.find();
  AllBooksController controller = Get.put(
      AllBooksController(Get.find(), Get.find(), Get.find(), Get.find()));

  void _scroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.loadMoreFilesForBookOfMonths();
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
    // SettingsDataController settingsDataController = Get.find<SettingsDataController>();

//

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Books Of The Month",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return controller.changePage();
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
                      controller: controller.searchControllerforBookOfMonth,
                      textInputAction: TextInputAction.done,
                      hintText: 'keyword',
                      hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      // onChanged: controller.onSearchTextChanged,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          // controller.searchItem('');
                          controller.searchControllerforBookOfMonth.clear();
                          controller.selectPublisherControllerforBookOfMonth
                              .clear();
                          controller.selectAuthorControllerforBookOfMonth
                              .clear();
                          controller.publisherId.value = 0;
                          controller.authorId.value = 0;
                          controller.getAllBooksDataPageForBookOfMonth();
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
                                CustomPublisherBottomSheet(
                                  controller: controller,
                                ),
                              );
                            },
                            child: AbsorbPointer(
                              child: CustomTextField(
                                controller: controller
                                    .selectPublisherControllerforBookOfMonth,
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
                                CustomAuthorsBottomSheet(
                                    controller: controller),
                              );
                            },
                            child: AbsorbPointer(
                              child: CustomTextField(
                                controller: controller
                                    .selectAuthorControllerforBookOfMonth,
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
                            controller.searchControllerforBookOfMonth.clear();
                            controller.selectPublisherControllerforBookOfMonth
                                .clear();
                            controller.selectAuthorControllerforBookOfMonth
                                .clear();
                            controller.publisherId.value = 0;
                            controller.authorId.value = 0;
                            // controller.searchItem('');
                            controller.getAllBooksDataPageForBookOfMonth();
                          },
                        ),
                        SizedBox(width: 5.w),
                        CustomBtn(
                          width: Get.width / 6,
                          text: 'Search',
                          callback: () {
                            // controller.filterBooks();
                            controller.getAllBooksDataPageForBookOfMonth();
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Obx(
                      () => controller.isLoading.value
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
                          : controller.booksModelForBookOfTheMonth.value.isEmpty
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
                                            mainAxisExtent: Get.height / 2.4,
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 6,
                                            crossAxisSpacing: 14,
                                          ),
                                          itemCount: controller
                                              .booksModelForBookOfTheMonth
                                              .value
                                              .length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final model = controller
                                                .booksModelForBookOfTheMonth
                                                .value[index];
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.h),
                                              child: GestureDetector(
                                                onTap: () {
                                                  model.fileType == "url"
                                                      ? (Get.toNamed(
                                                          Routes
                                                              .bookDetailsScreen,
                                                          arguments: [
                                                              model.id,
                                                              ""
                                                            ]))
                                                      : (model.isPaid == 0 ||
                                                              controller
                                                                      .mainController
                                                                      .userProfileModel!
                                                                      .currentUserPlan!
                                                                      .packageId !=
                                                                  '1')
                                                          ? (model.isBorrowed ==
                                                                  false)
                                                              ? (Get.snackbar(
                                                                  'Warning',
                                                                  'First, you need to borrow this book.'))
                                                              : (model.borrowedNextdate !=
                                                                          "") &&
                                                                      (DateTime.now()
                                                                          .isAfter(
                                                                              DateTime.parse(model.borrowedNextdate)))
                                                                  ? (Get.snackbar('Warning', 'First, you need to borrow this book.'))
                                                                  : (model.borrowedEnddate != "" && model.borrowedNextdate != "") && (DateTime.now().isAfter(DateTime.parse(model.borrowedEnddate)) && DateTime.now().isBefore(DateTime.parse(model.borrowedNextdate)))
                                                                      ? (Get.snackbar('Warning', 'First, you need to borrow this book.'))
                                                                      : (Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]))
                                                          : (Get.snackbar('Warning', 'First, you need to borrow this book.'));
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
                                                                        (model.isPaid == 0 ||
                                                                                controller.mainController.userProfileModel!.currentUserPlan?.packageId != '1')
                                                                            ? (model.isBorrowed == false)
                                                                                ? Icons.lock_open
                                                                                : (DateTime.now().isAfter(DateTime.parse(model.borrowedStartdate)) && DateTime.now().isBefore(DateTime.parse(model.borrowedEnddate)))
                                                                                    ? Icons.lock_open
                                                                                    : Icons.lock_open
                                                                            : Icons.lock,
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
                                                                        model.fileType ==
                                                                                "url"
                                                                            ? (Get.toNamed(Routes.bookDetailsScreen, arguments: [
                                                                                model.id,
                                                                                ""
                                                                              ]))
                                                                            : model.isBorrowed ==
                                                                                    true
                                                                                ? (Get.toNamed(Routes.bookDetailsScreen, arguments: [
                                                                                    model.id,
                                                                                    ""
                                                                                  ]))
                                                                                : Get.snackbar('Warning', 'First, you need to borrow this book.');
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
                                                                        controller
                                                                            .storeFavouriteBook(model.id)
                                                                            .then((value) {
                                                                          controller.favouriteMark(
                                                                              isBookOfTheMonth: true);
                                                                        });
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
                                                              model.title,
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
                                                                          .avgRating),
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
                                                              text: model.bookFor ==
                                                                      "sale"
                                                                  ? "Buy - ${model.bookPrice}\$"
                                                                  : model.fileType ==
                                                                          "url"
                                                                      ? "Watch Now"
                                                                      : (model.isPaid == 0 ||
                                                                              controller.mainController.userProfileModel!.currentUserPlan?.packageId != '1')
                                                                          ? (model.isBorrowed == false)
                                                                              ? 'Borrow'
                                                                              : (DateTime.now().isAfter(DateTime.parse(model.borrowedNextdate)))
                                                                                  ? 'Borrow'
                                                                                  : (DateTime.now().isAfter(DateTime.parse(model.borrowedEnddate)) && DateTime.now().isBefore(DateTime.parse(model.borrowedNextdate)))
                                                                                      ? 'Locked'
                                                                                      : 'Borrowed'
                                                                          : 'Premium',
                                                              gradient: model
                                                                          .fileType ==
                                                                      "url"
                                                                  ? const LinearGradient(
                                                                      begin: Alignment
                                                                          .centerLeft,
                                                                      end: Alignment
                                                                          .centerRight,
                                                                      colors: <Color>[
                                                                        primaryColor,
                                                                        primColor
                                                                      ],
                                                                    )
                                                                  : model.isPaid ==
                                                                              0 ||
                                                                          controller.mainController.userProfileModel!.currentUserPlan?.packageId !=
                                                                              '1'
                                                                      ? model.isBorrowed ==
                                                                              false
                                                                          ? const LinearGradient(
                                                                              begin: Alignment.centerLeft,
                                                                              end: Alignment.centerRight,
                                                                              colors: <Color>[
                                                                                primaryColor,
                                                                                primaryColor
                                                                              ],
                                                                            )
                                                                          : (DateTime.now().isAfter(DateTime.parse(model.borrowedNextdate)))
                                                                              ? const LinearGradient(
                                                                                  begin: Alignment.centerLeft,
                                                                                  end: Alignment.centerRight,
                                                                                  colors: <Color>[
                                                                                    primaryColor,
                                                                                    primaryColor
                                                                                  ],
                                                                                )
                                                                              : (DateTime.now().isAfter(DateTime.parse(model.borrowedEnddate)) && DateTime.now().isBefore(DateTime.parse(model.borrowedNextdate)))
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
                                                                          begin:
                                                                              Alignment.centerLeft,
                                                                          end: Alignment
                                                                              .centerRight,
                                                                          colors: <Color>[
                                                                            primaryColor,
                                                                            primColor
                                                                          ],
                                                                        ),
                                                              callback: () {
                                                                // if (Platform
                                                                //     .isIOS) {
                                                                //   customDialog(
                                                                //       context,
                                                                //       'Is which way do you want to pay?',
                                                                //       'InApp',
                                                                //       '', () {
                                                                //     // Get.back();
                                                                //     // Get.to(() =>
                                                                //     //     BookPaymentScreen(
                                                                //     //       bookPrice:
                                                                //     //           model.bookPrice,
                                                                //     //       title:
                                                                //     //           model.title,
                                                                //     //       id: model
                                                                //     //           .id,
                                                                //     //     ));
                                                                //   }, () {
                                                                //     Get.to(() =>
                                                                //         BookPaymentScreen(
                                                                //           bookPrice:
                                                                //               model.bookPrice,
                                                                //           title:
                                                                //               model.title,
                                                                //           id: model
                                                                //               .id,
                                                                //         ));
                                                                //   });
                                                                // } else {
                                                                  // Get.to(() =>
                                                                  //     BookPaymentScreen(
                                                                  //       bookPrice:
                                                                  //           model.bookPrice,
                                                                  //       title: model
                                                                  //           .title,
                                                                  //       id: model
                                                                  //           .id,
                                                                  //     ));
                                                                // }

                                                                model.bookFor == "sale"
                                                                    ?  
                                                                     Get.to(() =>
                                                                      BookPaymentScreen(
                                                                        bookPrice:
                                                                            model.bookPrice,
                                                                        title: model
                                                                            .title,
                                                                        id: model
                                                                            .id,
                                                                      ))

                                                                    : model.fileType == "url"
                                                                    ? (Get.toNamed(
                                                                    Routes
                                                                        .bookDetailsScreen,
                                                                    arguments: model
                                                                        .id))
                                                                    : model.isPaid ==
                                                                    0 ||
                                                                    controller
                                                                        .mainController
                                                                        .userProfileModel!
                                                                        .currentUserPlan
                                                                        ?.packageId !=
                                                                        '1'
                                                                    ? (model
                                                                    .isBorrowed ==
                                                                    false)
                                                                    ? (controller
                                                                    .storeBorrowBook(
                                                                    model
                                                                        .id)
                                                                    .then(
                                                                        (value) {
                                                                      setState(
                                                                              () {
                                                                            controller
                                                                                .getAllBooksData();
                                                                          });
                                                                    }))
                                                                    : (DateTime.now()
                                                                    .isAfter(
                                                                    DateTime.parse(
                                                                        model
                                                                            .borrowedNextdate)))
                                                                    ? (controller
                                                                    .storeBorrowBook(
                                                                    model
                                                                        .id)
                                                                    .then(
                                                                        (value) {
                                                                      setState(() {
                                                                        controller
                                                                            .getAllBooksData();
                                                                      });
                                                                    }))
                                                                    : (DateTime.now()
                                                                    .isAfter(
                                                                    DateTime.parse(
                                                                        model
                                                                            .borrowedEnddate)) &&
                                                                    DateTime.now()
                                                                        .isBefore(
                                                                        DateTime
                                                                            .parse(
                                                                            model
                                                                                .borrowedNextdate)))
                                                                    ? ''
                                                                    : ''
                                                                    : (Get.toNamed(
                                                                    Routes
                                                                        .pricing));
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
                                      visible: controller.gettingMoreData.value,
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
