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
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/SettingsDataController.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/authorBook/components/custom_authors_bottomsheet.dart';
import 'package:tcllibraryapp_develop/screens/book/authorBook/components/custom_publisher_bottomSheet.dart';
import 'package:tcllibraryapp_develop/screens/book/authorBook/components/institution_grid_issued_container.dart';
import 'package:tcllibraryapp_develop/screens/book/authorBook/components/my_book_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/book/authorBook/controller/author_book_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/bookOfTheMonth/book_of_the_month_screen.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

import '../../setting/repository/setting_repository.dart';
import '../model/books_model.dart';

class AuthorBooksScreen extends StatefulWidget {
  AuthorBooksScreen({super.key, this.isMain = false});

  bool? isMain;

  @override
  State<AuthorBooksScreen> createState() => _AuthorBooksScreenState();
}

class _AuthorBooksScreenState extends State<AuthorBooksScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollControllerFavourite = ScrollController();
  AuthorBookController controller = Get.find();

  void _scroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.loadMoreFiles();
    }
  }

  void _scrollFavourite() {
    if (_scrollControllerFavourite.position.pixels ==
        _scrollControllerFavourite.position.maxScrollExtent) {
      controller.loadMoreFilesFavourite();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scroll);
    _scrollControllerFavourite.addListener(_scrollFavourite);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _scrollControllerFavourite.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SettingsDataController settingsDataController =
        Get.find<SettingsDataController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          controller.mainController.userProfileModel?.roleId == 1
              ? "All Books"
              : controller.mainController.userProfileModel?.roleId == 2
                  ? "My Books"
                  : "Issued Books",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: widget.isMain == false
            ? IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back_ios_new))
            : const SizedBox(),
      ),
      body: controller.mainController.userProfileModel?.roleId == 1
          ? RefreshIndicator(
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
                            // onChanged: (p0) {
                            //   controller.searchController.text = p0.toString();
                            // },
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
                              child: const Icon(Icons.clear),
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
                                          controller: controller),
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
                                  controller.page.value = 0;
                                  controller.getAllBooksData();
                                  // controller.filterBooks();
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
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
                                    if (controller.mainController
                                            .userProfileModel?.roleId ==
                                        1)
                                      InkWell(
                                        onTap: () {
                                          Get.to(() =>
                                              const BookOfTheMonthScreen());
                                        },
                                        child: SizedBox(
                                          width: 270.w,
                                          child: RichText(
                                            text: TextSpan(
                                              style:
                                                  DefaultTextStyle.of(context)
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
                                                      fontWeight:
                                                          FontWeight.w500),
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
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: Get.height / 2.5,
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 6,
                                        crossAxisSpacing: 14,
                                      ),
                                      itemCount: 8,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.h),
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade400,
                                            highlightColor:
                                                Colors.grey.shade300,
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
                                : controller.booksModels.value.isEmpty
                                    ? Padding(
                                        padding: EdgeInsets.only(top: 100.h),
                                        child: const CustomGifImage())
                                    : Column(
                                        children: [
                                          SizedBox(
                                            width: Get.width,
                                            child: GridView.builder(
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                      mainAxisExtent:
                                                          Get.height / 2.4,
                                                      crossAxisCount: 2,
                                                      mainAxisSpacing: 14,
                                                      crossAxisSpacing: 14),
                                              itemCount: controller
                                                  .booksModels.value.length,
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                final model = controller
                                                    .booksModels.value[index];

                                                return GestureDetector(
                                                  onTap: () {
                                                    print(
                                                        "borrowerBookTitle: ${model.title}");
                                                    print(
                                                        "borrowerIsBorrowed: ${model.isBorrowed}");
                                                    print(
                                                        "borrowerEndDate: ${model.borrowedEnddate}");

                                                    print(
                                                        "fileType: ${model.fileType}, isPaid: ${model.isPaid}, packageID: ${controller.mainController.userProfileModel!.currentUserPlan!.packageId}, bookFor: ${model.bookFor}, isBorrowed: ${model.isBorrowed},");

                                                    gotoBookDetailsPage(model);

                                                    print('');

                                                    // model.fileType == "url"
                                                    //     ? (
                                                    //     {Get.toNamed(
                                                    //     Routes
                                                    //         .bookDetailsScreen,
                                                    //     arguments:
                                                    //     model.id)}
                                                    // )
                                                    //     :
                                                    //     (model.bookFor=='sell' && model.isPaid==1)
                                                    //  ?(
                                                    //     Get.toNamed(
                                                    //     Routes
                                                    //         .bookDetailsScreen,
                                                    //     arguments:
                                                    //     model.id)
                                                    // ):
                                                    //
                                                    // (model.isPaid == 0 ||
                                                    //     controller
                                                    //         .mainController
                                                    //         .userProfileModel!
                                                    //         .currentUserPlan!
                                                    //         .packageId !=
                                                    //         '1')
                                                    //     ? (model.isBorrowed ==
                                                    //     false)
                                                    //     ? (Get.snackbar(
                                                    //     'Warning',
                                                    //     'First, you need to borrow this book.'))
                                                    //     : (DateTime.now().isAfter(
                                                    //     DateTime.parse(model
                                                    //         .borrowedNextdate)))
                                                    //     ? (Get.snackbar(
                                                    //     'Warning',
                                                    //     'First, you need to borrow this book.'))
                                                    //     : ()
                                                    //     ? (Get.snackbar('Warning',
                                                    //     'First, you need to borrow this book.'))
                                                    //     : ()
                                                    //     : (
                                                    // Get.snackbar(
                                                    //   'Warning',
                                                    //   'First, you need to borrow this book.',
                                                    // ),
                                                    // );
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
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: primaryGrayColor
                                                                    .withOpacity(
                                                                        0.5),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                              ),
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
                                                                  fit: BoxFit
                                                                      .fill,
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
                                                                          .all(
                                                                          5),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        height: Get.height /
                                                                            19.80,
                                                                        width: Get.width /
                                                                            10.5,
                                                                        decoration: const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            color: primaryGrayColor),
                                                                        child:
                                                                            Icon(
                                                                          (model.isPaid == 0 || controller.mainController.userProfileModel!.currentUserPlan?.packageId != '1')
                                                                              ? (model.isBorrowed == false)
                                                                                  ? Icons.lock_open
                                                                                  : model.borrowedEnddate.isEmpty
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
                                                                              : model.isBorrowed ==
                                                                                      true
                                                                                  ? Get.toNamed(Routes.bookDetailsScreen, arguments: [
                                                                                      model.id,
                                                                                      ""
                                                                                    ])
                                                                                  : Get.snackbar('Warning', 'First, you need to borrow this book.');
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              Get.height / 19.80,
                                                                          width:
                                                                              Get.width / 10.5,
                                                                          decoration:
                                                                              const BoxDecoration(
                                                                            color:
                                                                                primaryGrayColor,
                                                                            shape:
                                                                                BoxShape.circle,
                                                                          ),
                                                                          child:
                                                                              const Icon(
                                                                            Icons.remove_red_eye_rounded,
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
                                                                            controller.favouriteMark();
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                            height: Get.height /
                                                                                19.80,
                                                                            width: Get.width /
                                                                                10.5,
                                                                            decoration:
                                                                                const BoxDecoration(color: primaryGrayColor, shape: BoxShape.circle),
                                                                            child: Icon(Icons.favorite_outlined, color: model.isFavorite == false ? Colors.white : Colors.red)),
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
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius: BorderRadius.only(
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10.r),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10.r))),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left: 4
                                                                            .w),
                                                                child: Text(
                                                                  model.title,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp),
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
                                                                    itemCount:
                                                                        5,
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
                                                                width:
                                                                    Get.width /
                                                                        4.3.w,
                                                                text: model.bookFor ==
                                                                        "sale"
                                                                    ? (model.isBorrowed &&
                                                                            model
                                                                                .borrowedEnddate.isEmpty)
                                                                        ? 'Bought'
                                                                        : "Buy - ${model.bookPrice}\$"
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
                                                                            .bookFor ==
                                                                        "sale"
                                                                    ? const LinearGradient(
                                                                        begin: Alignment
                                                                            .centerLeft,
                                                                        end: Alignment
                                                                            .centerRight,
                                                                        colors: <Color>[
                                                                          blackGrayColor,
                                                                          blackGrayColor
                                                                        ],
                                                                      )
                                                                    : model.fileType ==
                                                                            "url"
                                                                        ? const LinearGradient(
                                                                            begin:
                                                                                Alignment.centerLeft,
                                                                            end:
                                                                                Alignment.centerRight,
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
                                                                callback: () {
                                                                  manageButtonNavigation(
                                                                      model,
                                                                      settingsDataController);

                                                                  print(
                                                                      "BookDetails: FoSell: ${model.bookFor}, isBorrowed: ${model.isBorrowed}");

                                                                  // if(model.bookFor=="sale"){
                                                                  //
                                                                  //   //todo.... Need to implement Paypal Payment Gateway here
                                                                  //
                                                                  //
                                                                  //   if(model
                                                                  //       .isBorrowed){
                                                                  //     Get.toNamed(
                                                                  //         Routes
                                                                  //             .bookDetailsScreen,
                                                                  //         arguments: model
                                                                  //             .id);
                                                                  //   }else{
                                                                  //     payWithPaypal(
                                                                  //         settingsDataController.settingsData!.data!.paypalClientId!,
                                                                  //         settingsDataController.settingsData!.data!.paypalClientSecret!,
                                                                  //         double.tryParse(model.bookPrice)??0.0,
                                                                  //         model.title,
                                                                  //         "USD", model.id);
                                                                  //   }
                                                                  // }else{
                                                                  //   if(model.fileType == "url"){
                                                                  //     Get.toNamed(
                                                                  //         Routes
                                                                  //             .bookDetailsScreen,
                                                                  //         arguments: model
                                                                  //             .id);
                                                                  //   }else{
                                                                  //     if(model.isPaid == 0 ||
                                                                  //         controller.mainController
                                                                  //             .userProfileModel!
                                                                  //             .currentUserPlan!
                                                                  //             .packageId != '1'){
                                                                  //
                                                                  //       if(model.isBorrowed ==
                                                                  //           false){
                                                                  //         (controller
                                                                  //             .storeBorrowBook(model.id)
                                                                  //             .then((value) {
                                                                  //           setState(() {
                                                                  //             controller
                                                                  //                 .getAllBooksData();
                                                                  //           });
                                                                  //         }))
                                                                  //       }else{
                                                                  //
                                                                  //       }
                                                                  //       ()
                                                                  //           ?
                                                                  //           : (DateTime.now().isAfter(
                                                                  //           DateTime.parse(model
                                                                  //               .borrowedNextdate)))
                                                                  //           ? (controller
                                                                  //           .storeBorrowBook(model.id)
                                                                  //           .then((value) {
                                                                  //         setState(() {
                                                                  //           controller
                                                                  //               .getAllBooksData();
                                                                  //         });
                                                                  //       }))
                                                                  //           : (DateTime.now().isAfter(
                                                                  //           DateTime.parse(model
                                                                  //               .borrowedEnddate)) &&
                                                                  //           DateTime.now().isBefore(
                                                                  //               DateTime.parse(model
                                                                  //                   .borrowedNextdate)))
                                                                  //           ? ''
                                                                  //           : '';
                                                                  //     }else{
                                                                  //       (Get.toNamed(
                                                                  //           Routes.pricing));
                                                                  //     }
                                                                  //   }
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
                                                );
                                              },
                                            ),
                                          ),
                                          Visibility(
                                            visible: controller
                                                .gettingMoreData.value,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 40.h),
                                              child:
                                                  const CircularProgressIndicator(
                                                      color: primaryColor),
                                            ),
                                          ),
                                        ],
                                      ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          : controller.mainController.userProfileModel?.roleId == 2
              ? RefreshIndicator(
                  onRefresh: () async {
                    return controller.getMyBook();
                  },
                  child: Obx(
                    () => controller.isLoading.value
                        ? const MyBookShimmer()
                        : CustomScrollView(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            slivers: [
                              SliverPadding(
                                padding: const EdgeInsets.all(0.0),
                                sliver: SliverToBoxAdapter(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 16.w,
                                            right: 16.w,
                                            bottom: 10.h),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: CustomBtn(
                                            width: Get.width / 5,
                                            text: "Add New",
                                            callback: () {
                                              Get.toNamed(Routes.addBookScreen);
                                            },
                                          ),
                                        ),
                                      ),
                                      controller.booksModel == null
                                          ? Container()
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  border: Border.all(
                                                      color:
                                                          Colors.grey.shade100),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      child: Text(
                                                        "Book",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    SizedBox(width: 60.w),
                                                    SizedBox(
                                                      child: Text(
                                                        "Publisher",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    SizedBox(width: 30.w),
                                                    SizedBox(
                                                      child: Text(
                                                        "ISBN",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    SizedBox(width: 35.w),
                                                    SizedBox(
                                                      child: Text(
                                                        "Action",
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      controller.booksModel == null
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(top: 100.h),
                                              child: const CustomGifImage(),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16.w),
                                              child: SizedBox(
                                                width: Get.width,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemCount: controller
                                                      .booksModel!.books.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(
                                                            Routes
                                                                .bookDetailsScreen,
                                                            arguments: [
                                                              controller
                                                                  .booksModel!
                                                                  .books[index]
                                                                  .id,
                                                              ""
                                                            ]);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                            color: Colors
                                                                .grey.shade100,
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: Get.width /
                                                                  3.8,
                                                              child: Text(
                                                                "${controller.booksModel?.books[index].title}",
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 2.w),
                                                            SizedBox(
                                                              width: Get.width /
                                                                  5.8,
                                                              child: Text(
                                                                "${controller.booksModel?.books[index].publisher}",
                                                                maxLines: 1,
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 2.w),
                                                            SizedBox(
                                                              width: Get.width /
                                                                  3.7,
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    "${controller.booksModel?.books[index].isbn10}",
                                                                    maxLines: 1,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .start,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                  controller.booksModel?.books[index].isbn13 ==
                                                                          ''
                                                                      ? const Text(
                                                                          "N/A")
                                                                      : Text(
                                                                          "${controller.booksModel?.books[index].isbn13}",
                                                                          maxLines:
                                                                              1,
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                ],
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 2.w),
                                                            SizedBox(
                                                              width:
                                                                  Get.width / 9,
                                                              child:
                                                                  PopupMenuButton(
                                                                onSelected:
                                                                    (value) {
                                                                  final val = controller
                                                                      .booksModel
                                                                      ?.books[index];
                                                                  controller.onMenuItemSelected(
                                                                      value
                                                                          as int,
                                                                      controller
                                                                          .booksModel!
                                                                          .books[
                                                                              index]
                                                                          .id,
                                                                      val,
                                                                      context);
                                                                },
                                                                offset: Offset(
                                                                    Get.width /
                                                                        10,
                                                                    Get.height /
                                                                        20),
                                                                shape:
                                                                    const RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              8.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              8.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              8.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8.0)),
                                                                ),
                                                                itemBuilder:
                                                                    (ctx) => [
                                                                  _buildPopupMenuItem(
                                                                      'Analytics',
                                                                      Options
                                                                          .analytics
                                                                          .index),
                                                                  _buildPopupMenuItem(
                                                                      'Edit',
                                                                      Options
                                                                          .edit
                                                                          .index),
                                                                  _buildPopupMenuItem(
                                                                      'Delete',
                                                                      Options
                                                                          .delete
                                                                          .index),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                      SizedBox(height: 20.h)
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    return controller.getBorrowedBooks();
                  },
                  child: Obx(
                    () => controller.isLoading.value
                        ? SizedBox(
                            width: Get.width,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: Get.height / 2.5,
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 6,
                                  crossAxisSpacing: 14,
                                ),
                                itemCount: 8,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
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
                            ),
                          )
                        : controller.issuedModel.value.isEmpty
                            ? CustomScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                slivers: [
                                    SliverPadding(
                                        padding: EdgeInsets.only(top: 140.h),
                                        sliver: const SliverToBoxAdapter(
                                            child: CustomGifImage()))
                                  ])
                            : CustomScrollView(
                                slivers: [
                                  InstitutionGridIssuedContainer(
                                      controller: controller),
                                  SliverToBoxAdapter(
                                    child: SizedBox(height: 30.h),
                                  ),
                                ],
                              ),
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

  void gotoBookDetailsPage(Book model) {
    if (controller
            .mainController.userProfileModel!.currentUserPlan!.packageId.toString() !=
        '1') {
      //Unlimited Book Access
      if (model.isBorrowed) {
        log("btn callback: 1.1");
        Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]);
      } else {
        Get.snackbar('Warning', 'First, you need to borrow this book.');
      }
    } else if (model.bookFor == 'sale') {
      //Book for sale
      if (model.isBorrowed) {
        //Book Bought
        Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]);
      } else {
        Get.snackbar('Warning', 'First, you need to borrow this book.');
      }
    } else {
      if (model.fileType == 'url') {
        Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]);
      } else if (model.isBorrowed) {
        //Book Borrowed
        if (DateTime.now().isAfter(DateTime.parse(model.borrowedNextdate)) ||
            (DateTime.now().isAfter(DateTime.parse(model.borrowedEnddate)) &&
                DateTime.now()
                    .isBefore(DateTime.parse(model.borrowedNextdate)))) {
          Get.snackbar('Warning', 'First, you need to borrow this book.');
        } else {
          Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]);
        }
      } else {
        Get.toNamed(Routes.bookSummary, arguments: [model]);
        // Get.snackbar('Warning', 'First, you need to borrow this book.');
      }
    }
  }

  void manageButtonNavigation(
      Book model, SettingsDataController settingsDataController) {
    if (model.bookFor == "sale") {
      log("btn callback: 1");
      if (model.isBorrowed) {
        log("btn callback: 1.1");
        Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]);
      } else {
        log("btn callback: 1.2");
        if (!Platform.isIOS) {
          payWithPaypal(
              settingsDataController.settingsData!.data!.paypalClientId!,
              settingsDataController.settingsData!.data!.paypalClientSecret!,
              double.tryParse(model.bookPrice) ?? 0.0,
              model.title,
              "USD",
              model.id);
        }
      }
    } else {
      log("btn callback: 2");
      if (model.isBorrowed) {
        log("btn callback: 2.3");
        Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]);
      } else if (model.fileType == "url") {
        log("btn callback: 2.1");
        Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]);
      } else {
        log("btn callback: 2.2");

        if ( //model.isPaid == 0 &&
            controller.mainController.userProfileModel!.currentUserPlan!
                    .packageId !=
                '1') {
          log("btn callback: 2.2.1");
          if (model.isBorrowed == false) {
            log("btn callback: 2.2.1.1");
            controller.storeBorrowBook(model.id).then((value) {
              setState(() {
                controller.getAllBooksData();
              });
            });
          } else {
            log("btn callback: 2.2.1.2");

            if (DateTime.now()
                .isAfter(DateTime.parse(model.borrowedNextdate))) {
              log("btn callback: 2.2.1.2.1");

              controller.storeBorrowBook(model.id).then((value) {
                setState(() {
                  controller.getAllBooksData();
                });
              });
            } else {
              log("btn callback: 2.2.1.2.2");

              DateTime.now().isAfter(DateTime.parse(model.borrowedEnddate)) &&
                  DateTime.now()
                      .isBefore(DateTime.parse(model.borrowedNextdate));
            }
          }
        }
        // else if(model.isPaid != 0 &&
        //     controller
        //         .mainController
        //         .userProfileModel!
        //         .currentUserPlan!
        //         .packageId != '1'){
        //
        //   print("Paid:${model.isPaid}, packegeId: ${controller
        //       .mainController
        //       .userProfileModel!
        //       .currentUserPlan!
        //       .packageId}");
        //   // controller
        //   //     .storeBorrowBook(
        //   //     model.id)
        //   //     .then((value) {
        //   //   setState(() {
        //   //     controller
        //   //         .getAllBooksData();
        //   //   });
        //   // });
        //   log("btn callback: 2.2.2");
        //
        // }
        else {
          log("btn callback: 2.2.3");

          (Get.toNamed(Routes.pricing));
        }
      }
    }
  }
}
