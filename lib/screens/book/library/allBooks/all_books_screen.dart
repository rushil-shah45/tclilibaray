import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

// import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/data/SettingsDataController.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/bookOfTheMonth/book_of_the_month_screen.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/component/custom_authors_bottomsheet.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/component/custom_publisher_bottomSheet.dart';
import 'package:tcllibraryapp_develop/screens/book/library/allBooks/controller/all_books_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';
import 'package:tcllibraryapp_develop/widgets/custom_image.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

class AllBooksScreen extends StatefulWidget {
  const AllBooksScreen({super.key});

  @override
  State<AllBooksScreen> createState() => _AllBooksScreenState();
}

class _AllBooksScreenState extends State<AllBooksScreen> {
  final ScrollController _scrollController = ScrollController();
  AllBooksController controller = Get.find();

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
    SettingsDataController settingsDataController =
        Get.find<SettingsDataController>();

    return GetBuilder<AllBooksController>(
      builder: (controllers) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () {
                Get.back();
              },
            ),
            title: Text(
              "All Books",
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
                          controller: controller.searchController,
                          textInputAction: TextInputAction.done,
                          hintText: 'keyword',
                          hintStyle:
                              TextStyle(fontSize: 12.sp, color: Colors.grey),
                          // onChanged: controller.onSearchTextChanged,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              // controller.searchItem('');
                              controller.searchController.clear();
                              controller.selectPublisherController.clear();
                              controller.selectAuthorController.clear();
                              controller.publisherId.value = 0;
                              controller.authorId.value = 0;
                              controller.getAllBooksData();
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
                                    controller:
                                        controller.selectPublisherController,
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
                                    controller:
                                        controller.selectAuthorController,
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
                                controller.searchController.clear();
                                controller.selectPublisherController.clear();
                                controller.selectAuthorController.clear();
                                controller.publisherId.value = 0;
                                controller.authorId.value = 0;
                                // controller.searchItem('');
                                controller.getAllBooksData();
                              },
                            ),
                            SizedBox(width: 5.w),
                            CustomBtn(
                              width: Get.width / 6,
                              text: 'Search',
                              callback: () {
                                // controller.filterBooks();
                                controller.getAllBooksData();
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        controller.mainController.userProfileModel!.plan
                                    .title ==
                                'Free'
                            ? Row(
                                children: [
                                  Image.asset(
                                    'assets/images/free.png',
                                    height: 40,
                                    width: 40,
                                  ),
                                  SizedBox(width: 5.w),
                                  InkWell(
                                    onTap: () {
                                      Get.to(
                                          () => const BookOfTheMonthScreen());
                                    },
                                    child: SizedBox(
                                      width: 270.w,
                                      child: RichText(
                                        text: TextSpan(
                                          style: DefaultTextStyle.of(context)
                                              .style,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  'Free Users can Read Only Book of the Month Free',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                              ),
                                            ),
                                            TextSpan(
                                              text: ' View',
                                              style: TextStyle(
                                                  fontSize: 12.sp,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        SizedBox(height: 15.h),
                        Obx(
                          () => controller.isLoading.value
                              ? SizedBox(
                                  width: Get.width,
                                  child: GridView.builder(
                                    itemCount: 8,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
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
                                            margin: const EdgeInsets.only(
                                                bottom: 5),
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
                              : controller.booksModel.value.isEmpty
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
                                                mainAxisExtent:
                                                    Get.height / 2.4,
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 6,
                                                crossAxisSpacing: 14,
                                              ),
                                              itemCount: controller
                                                  .booksModel.value.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                final model = controller
                                                    .booksModel.value[index];
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 5.h),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      model.fileType == "url"
                                                          ? (Get.toNamed(
                                                              Routes.bookDetailsScreen,
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
                                                                  ? Get.toNamed(Routes.bookSummary, arguments: [model])
                                                                  : (model.borrowedNextdate != "") &&
                                                                          (DateTime.now().isAfter(DateTime.parse(model
                                                                              .borrowedNextdate)))
                                                                      ? (Get.snackbar(
                                                                          'Warning', 'First, you need to borrow this book.'))
                                                                      : (model.borrowedEnddate != "" && model.borrowedNextdate != "") && (DateTime.now().isAfter(DateTime.parse(model.borrowedEnddate)) && DateTime.now().isBefore(DateTime.parse(model.borrowedNextdate)))
                                                                          ? (Get.snackbar('Warning', 'First, you need to borrow this book.'))
                                                                          : (Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]))
                                                              : (Get.snackbar('Warning', 'First, you need to borrow this book.'));
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.r),
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
                                                                        BorderRadius.circular(
                                                                            10.r)),
                                                                child:
                                                                    ClipRRect(
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
                                                                    width: Get
                                                                        .width,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                left: 5,
                                                                top: 5,
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color:
                                                                        primaryColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            40.r),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            5),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          height:
                                                                              Get.height / 19.80,
                                                                          width:
                                                                              Get.width / 10.5,
                                                                          decoration: const BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              color: primaryGrayColor),
                                                                          child:
                                                                              Icon(
                                                                            (model.isPaid == 0 || controller.mainController.userProfileModel!.currentUserPlan?.packageId != '1')
                                                                                ? (model.isBorrowed == false)
                                                                                    ? Icons.lock_open
                                                                                    : (DateTime.now().isAfter(DateTime.parse(model.borrowedStartdate)) && DateTime.now().isBefore(DateTime.parse(model.borrowedEnddate)))
                                                                                        ? Icons.lock_open
                                                                                        : Icons.lock_open
                                                                                : Icons.lock,
                                                                            color:
                                                                                Colors.white,
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
                                                                                : model.isBorrowed == true
                                                                                    ? (Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]))
                                                                                    : Get.snackbar('Warning', 'First, you need to borrow this book.');
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                Get.height / 19.80,
                                                                            width:
                                                                                Get.width / 10.5,
                                                                            decoration:
                                                                                const BoxDecoration(color: primaryGrayColor, shape: BoxShape.circle),
                                                                            child:
                                                                                const Icon(
                                                                              Icons.remove_red_eye_rounded,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                5.h),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            controller.storeFavouriteBook(model.id).then((value) {
                                                                              controller.favouriteMark(isBookOfTheMonth: false);
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                Get.height / 19.80,
                                                                            width:
                                                                                Get.width / 10.5,
                                                                            decoration:
                                                                                const BoxDecoration(color: primaryGrayColor, shape: BoxShape.circle),
                                                                            child:
                                                                                Icon(
                                                                              Icons.favorite_outlined,
                                                                              color: model.isFavorite == false ? Colors.white : Colors.red,
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
                                                            height:
                                                                Get.height / 8,
                                                            width: Get.width,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius.only(
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
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14.sp,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        5.h),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    RatingBarIndicator(
                                                                      rating: double
                                                                          .parse(
                                                                              model.avgRating),
                                                                      itemCount:
                                                                          5,
                                                                      itemSize:
                                                                          20.0,
                                                                      direction:
                                                                          Axis.horizontal,
                                                                      itemBuilder: (context, _) => const Icon(
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
                                                                    height:
                                                                        5.h),
                                                                CustomBtn(
                                                                  width:
                                                                      Get.width /
                                                                          4.3.w,
                                                                  text: getBookActionText(model, controller.mainController.userProfileModel),
                                                                  // text: model.bookFor ==
                                                                  //         "sale"
                                                                  //     ? "Buy - ${model.bookPrice}\$"
                                                                  //     : model.fileType ==
                                                                  //             "url"
                                                                  //         ? "Watch Now"
                                                                  //         : (model.isPaid == 0 || controller.mainController.userProfileModel?.currentUserPlan?.packageId != 1)
                                                                  //             ? (model.isBorrowed == false)
                                                                  //                 ? 'Borrow'
                                                                  //                 : (DateTime.now().isAfter(DateTime.parse(model.borrowedNextdate)))
                                                                  //                     ? 'Borrow'
                                                                  //                     : (DateTime.now().isAfter(DateTime.parse(model.borrowedEnddate)) && DateTime.now().isBefore(DateTime.parse(model.borrowedNextdate)))
                                                                  //                         ? 'Locked'
                                                                  //                         : 'Borrowed'
                                                                  //             : 'Premium',
                                                                  gradient: model
                                                                              .fileType ==
                                                                          "url"
                                                                      ? const LinearGradient(
                                                                          begin:
                                                                              Alignment.centerLeft,
                                                                          end: Alignment
                                                                              .centerRight,
                                                                          colors: <Color>[
                                                                            primaryColor,
                                                                            primColor
                                                                          ],
                                                                        )
                                                                      : model.isPaid == 0 ||
                                                                              controller.mainController.userProfileModel!.currentUserPlan?.packageId != '1'
                                                                          ? model.isBorrowed == false
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
                                                                              begin: Alignment.centerLeft,
                                                                              end: Alignment.centerRight,
                                                                              colors: <Color>[
                                                                                primaryColor,
                                                                                primColor
                                                                              ],
                                                                            ),
                                                                  callback: () async {
                                                                    log("callback ==== ${model.toJson()}");
                                                                    log(controller.mainController.userProfileModel!.currentUserPlan!.packageId.toString());

                                                                    final now = DateTime.now();
                                                                    final bookFor = model.bookFor;
                                                                    final fileType = model.fileType;
                                                                    final isPaid = model.isPaid;
                                                                    final isBorrowed = model.isBorrowed;
                                                                    final borrowedEndDate = DateTime.tryParse(model.borrowedEnddate);
                                                                    final borrowedNextDate = DateTime.tryParse(model.borrowedNextdate);
                                                                    final packageId = controller.mainController.userProfileModel!.currentUserPlan?.packageId;
                                                                    final subscriptionRemaining = (controller.mainController.userProfileModel!.currentUserPlan?.expiredDate ?? DateTime.now()).difference(now).inDays;
                                                                    final planTitle = controller.mainController.userProfileModel?.plan.title;

                                                                    if(bookFor == "sale") {
                                                                        if (!Platform.isIOS) {
                                                                          payWithPaypal(settingsDataController.settingsData!.data!.paypalClientId!, settingsDataController.settingsData!.data!.paypalClientSecret!, double.tryParse(model.bookPrice) ?? 0.0, model.title, "USD", model.id);
                                                                        }else {
                                                                          // Optional: show error for iOS
                                                                          Get.snackbar("Unsupported", "PayPal not supported on iOS");
                                                                        }
                                                                        return;
                                                                    }

                                                                    if(fileType == "url") {
                                                                      Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]);
                                                                      return;
                                                                    }

                                                                    final hasAccess = isPaid == 0 || packageId != 1;

                                                                    if (hasAccess) {
                                                                      if (isBorrowed == true && model.isValid == "1") {
                                                                        // Already borrowed — do nothing or show snackbar
                                                                        Get.snackbar("Info", "You already borrowed this book.");
                                                                        return;
                                                                      }

                                                                      if (isBorrowed == true && borrowedNextDate != null && now.isBefore(borrowedNextDate)) {
                                                                        // Locked — inform user
                                                                        Get.snackbar("Locked", "This book will be available on ${borrowedNextDate.toLocal()}.");
                                                                        return;
                                                                      }

                                                                      if (planTitle != null && subscriptionRemaining <= 365) {
                                                                        await controller.storeBorrowBook(model.id);
                                                                        controller.getAllBooksData();
                                                                      } else {
                                                                        // Premium restriction
                                                                        Get.snackbar("Warning", "This book will be available on Premium Subscription.");
                                                                      }
                                                                      return;
                                                                    }

                                                                    // If not allowed access (planId == 1)
                                                                    Get.toNamed(Routes.pricing);


                                                                    // model.bookFor ==
                                                                    //     "sale"
                                                                    //     ? {
                                                                    //   if (!Platform.isIOS)
                                                                    //     {
                                                                    //       payWithPaypal(settingsDataController.settingsData!.data!.paypalClientId!, settingsDataController.settingsData!.data!.paypalClientSecret!, double.tryParse(model.bookPrice) ?? 0.0, model.title, "USD", model.id)
                                                                    //     }
                                                                    // }
                                                                    // // ? Get.toNamed(Routes.paymentScreen, arguments: [null, "", ""])
                                                                    //
                                                                    //     : model.fileType ==
                                                                    //     "url"
                                                                    //     ? (Get.toNamed(Routes.bookDetailsScreen, arguments: [
                                                                    //   model.id,
                                                                    //   ""
                                                                    // ]))
                                                                    //     :model.fileType ==
                                                                    //             "url"
                                                                    //         ? (Get.toNamed(Routes.bookDetailsScreen, arguments: [
                                                                    //             model.id,
                                                                    //             ""
                                                                    //           ]))
                                                                    //         : model.isPaid == 0 || controller.mainController.userProfileModel!.currentUserPlan?.packageId != 1
                                                                    //             ? (model.isBorrowed == false)
                                                                    //                 ? {
                                                                    //                     (controller.storeBorrowBook(model.id).then((value) {
                                                                    //                       setState(() {
                                                                    //                         controller.getAllBooksData();
                                                                    //                       });
                                                                    //                     }))
                                                                    //                   }
                                                                    //                 : (DateTime.now().isAfter(DateTime.parse(model.borrowedNextdate)))
                                                                    //                     ? (controller.storeBorrowBook(model.id).then((value) {
                                                                    //                         setState(() {
                                                                    //                           controller.getAllBooksData();
                                                                    //                         });
                                                                    //                       }))
                                                                    //                     : (DateTime.now().isAfter(DateTime.parse(model.borrowedEnddate)) && DateTime.now().isBefore(DateTime.parse(model.borrowedNextdate)))
                                                                    //                         ? ''
                                                                    //                         : ''
                                                                    //             : (Get.toNamed(Routes.pricing));
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        5.h),
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
                                              controller.gettingMoreData.value,
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
      },
    );
  }

  // String getBookActionText(Book model,UserProfileModel? user) {
  //   final now = DateTime.now();
  //   final bookFor = model.bookFor;
  //   final fileType = model.fileType;
  //   final isPaid = model.isPaid;
  //   final isBorrowed = model.isBorrowed;
  //   final borrowedEndDate = DateTime.tryParse(model.borrowedEnddate);
  //   final borrowedNextDate = DateTime.tryParse(model.borrowedNextdate);
  //   final packageId = user?.currentUserPlan?.packageId ?? -1;
  //
  //   if (bookFor == "sale") {
  //     return "Buy - ${model.bookPrice}\$";
  //   } else if (fileType == "url") {
  //     return "Watch Now";
  //   } else if (isPaid == 0 || packageId != 1) {
  //     if (isBorrowed == false) {
  //       return "Borrow";
  //     } else if (borrowedNextDate != null && now.isAfter(borrowedNextDate)) {
  //       return "Borrow";
  //     } else if (
  //     borrowedEndDate != null &&
  //         borrowedNextDate != null &&
  //         now.isAfter(borrowedEndDate) &&
  //         now.isBefore(borrowedNextDate)
  //     ) {
  //       return "Locked";
  //     } else {
  //       return "Borrowed";
  //     }
  //   } else {
  //     log("Premium Button Rendered Please check ${model.id}");
  //     return "Premium";
  //   }
  // }

  String getBookActionText(Book model, UserProfileModel? user) {
    final now = DateTime.now();
    final bookForList = model.bookFor.split(',').map((s) => s.trim().toLowerCase()).toList();
    final fileType = model.fileType;
    final isPaid = model.isPaid;
    final isBorrowed = model.isBorrowed;
    final borrowedEndDate = DateTime.tryParse(model.borrowedEnddate);
    final borrowedNextDate = DateTime.tryParse(model.borrowedNextdate);
    final packageId = user?.currentUserPlan?.packageId;
    final subscriptionRemaining = (user?.currentUserPlan?.expiredDate ?? DateTime.now()).difference(now).inDays;
    final planTitle = user?.plan.title;


    if (model.bookFor == "sale" && fileType != 'url') {
      log("getBookActionText called for book: ${model.title}, ${model.bookFor}");
      return "Buy - ${model.bookPrice}\$";
    } else {
     if (fileType == 'url') {
       return "Watch Now";
     } else {
       if (isPaid == 0 || packageId != 1) {
         if (isBorrowed == true && model.isValid == "1") {
           return "Borrowed";
         }
         else if (isBorrowed == true && borrowedNextDate != null && now.isBefore(borrowedNextDate)) {
           return "Locked";
         }
           // Laravel checks: if subscription_remaining <= 365 allow borrow, else show Premium
         else {
           // log("${user?.toJson()}");
           if (planTitle != null && subscriptionRemaining <= 365) {
             return "Borrow";
           } else {
             return "Premium";
           }
         }
       } else {
         if (planTitle != null && subscriptionRemaining <= 365) {
           return "Premium";
         } else {
           return "Premium";
         }
       }
     }
    }
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

  void payWithPaypal(String clientId, String secretKey, double amount,
      String productName, String currency, int bookId) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => UsePaypal(
        sandboxMode: true,
        clientId: clientId,
        secretKey: secretKey,
        returnURL: "https://samplesite.com/return",
        cancelURL: "https://samplesite.com/cancel",
        transactions: [
          {
            "amount": {
              "total": '$amount',
              "currency": currency,
              "details": {
                "subtotal": '$amount',
                "shipping": '0',
                "shipping_discount": 0
              }
            },
            "description": "The payment transaction description.",
            // "payment_options": {
            //   "allowed_payment_method":
            //       "INSTANT_FUNDING_SOURCE"
            // },
            "item_list": {
              "items": [
                {
                  "name": productName,
                  "quantity": 1,
                  "price": '$amount',
                  "currency": currency
                },
              ],

              // Optional
              //   "shipping_address": {
              //     "recipient_name": "Tharwat samy",
              //     "line1": "tharwat",
              //     "line2": "",
              //     "city": "tharwat",
              //     "country_code": "EG",
              //     "postal_code": "25025",
              //     "phone": "+00000000",
              //     "state": "ALex"
              //  },
            }
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          // element.value['transactions'][0]['related_resources'][0]
          // ['sale']['amount']['total'],
          // element.value['transactions'][0]['related_resources'][0]
          // ['sale']['state'] ==
          // 'completed',
          // element.value['transactions'][0]['related_resources'][0]
          // ['sale']['id'],

          for (var element in params.entries) {
            if (element.key == 'data') {
              updatePaymentStatus(
                  bookId,
                  element.value['transactions'][0]['related_resources'][0]
                      ['sale']['id'],
                  "${element.value['transactions'][0]['related_resources'][0]['sale']['amount']['total']}");
            }
          }
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }

  updatePaymentStatus(int bookId, String transactionId, String price) async {
    EasyLoading.show();
    MainController mainController = Get.find<MainController>();
    Map<String, dynamic> body = {
      'billing_name': "${mainController.userProfileModel?.billingName}",
      'billing_email': "${mainController.userProfileModel?.billingEmail}",
      'billing_country': "${mainController.userProfileModel?.country}",
      'billing_country_code':
          "${mainController.userProfileModel?.billingCountryCode}".trim(),
      'billing_dial_code':
          '+${mainController.userProfileModel?.billingDialCode == '' ? '' : "${mainController.userProfileModel?.billingDialCode.substring(1)}"}',
      'billing_phone':
          "${mainController.userProfileModel?.billingPhone}".trim(),
      'type': "${mainController.userProfileModel?.type}".capitalizeFirst,
      'billing_address': "${mainController.userProfileModel?.address}",
      'billing_state': "${mainController.userProfileModel?.state}",
      'billing_city': "${mainController.userProfileModel?.city}",
      'billing_zipcode': "${mainController.userProfileModel?.zipcode}",
      'payment_method': 'paypal',
      'transaction_id': transactionId,
      'billing_for': 'book',
      'price': price,
    };

    var sharedPreferences = await SharedPreferences.getInstance();

    final result = await Get.find<SettingsRepository>().buyBook(
        body,
        Get.find<LoginController>().userInfo?.accessToken ??
            sharedPreferences.getString("uToken")!,
        bookId);
    result.fold((error) {
      print(error);
      Get.snackbar("Failed", "Payment Status Update Failed!");
      EasyLoading.dismiss();
    }, (data) async {
      Get.snackbar("Success", data);
      Navigator.pop(context);
      EasyLoading.dismiss();
    });
  }
}
