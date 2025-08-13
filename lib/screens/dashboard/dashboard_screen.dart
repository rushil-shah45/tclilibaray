import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/component/dashboard_card_borrowedBook.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/component/dashboard_card_lastViewedBook.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/component/dashboard_card_latestBooks.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/component/dashboard_card_top_readers.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/component/dashboard_card_viewedUserBook.dart';
import 'package:tcllibraryapp_develop/screens/dashboard/widget/institution_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/pricing/controller/pricing_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_drawer.dart';
import 'package:tcllibraryapp_develop/widgets/custom_gif_image.dart';

import '../../../core/utils/constants.dart';
import '../../../routes/routes.dart';
import 'controller/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    inspect(controller.dashboardModel.value);
    return Scaffold(
      appBar: AppBar(
        title: controller.isTablet
            ? Text(
                "Dashboard",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              )
            : const Text("Dashboard"),
        actions: [
          GestureDetector(
            onTap: () {
              if (controller.mainController.userProfileModel?.roleId == 1) {
                print("ValueZZZ 1 :${controller.dashboardModel.value!.tawkSrc}");
                Get.toNamed(Routes.twak, arguments: controller.dashboardModel.value?.tawkSrc);
              } else if (controller.mainController.userProfileModel?.roleId == 2) {
                print("ValueZZ 2 :${controller.dashboardModel.value!.tawkSrc}");
                Get.toNamed(Routes.twak, arguments: controller.dashboardAuthorModel.value?.tawkSrc);
              } else {
                print("ValueZZ 3 :${controller.dashboardModel.value!.tawkSrc}");
                Get.toNamed(Routes.twak, arguments: controller.dashboardInstitutionModel.value?.tawkSrc);
              }
            },
            child: Image.asset(
              "assets/images/support.png",
              height: controller.isTablet ? 22.h : 30.h,
              width: controller.isTablet ? 22.h : 30.h,
            ),
          ),
          SizedBox(width: controller.isTablet ? 10.w : 40.w),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.notifications);
            },
            child: SizedBox(
              width: 40.w,
              child: Stack(
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: 30,
                  ),
                  Positioned(
                    right: controller.isTablet ? 18.w : 15.w,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(90.r),
                        // shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Obx(() => Text(
                            controller.notifications.value.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: controller.isTablet ? 5.sp : 8,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      //
      // floatingActionButton: GetBuilder<PricingController>(
      //   builder: (priCtrl) {
      //     return OutlinedButton(
      //       key: ValueKey('fab_key'),
      //       onPressed: () {
      //         //
      //         priCtrl.fetchOffers();
      //       },
      //       child: const Icon(Icons.add),
      //     );
      //   },
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      body: RefreshIndicator(
        onRefresh: () async {
          return controller.getDashboardData();
        },
        child: Obx(
          () {
            inspect(controller.dashboardModel.value);
            bool isFreeSub = controller.dashboardModel.value?.plan.title.toLowerCase() == "free";
            return controller.mainController.isLoading.value || controller.isLoading.value
                ? const InstitutionShimmer()
                : CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: controller.isTablet
                            ? EdgeInsets.only(left: 8.w, right: 8.w, top: 5.h)
                            : EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h),
                        sliver: SliverToBoxAdapter(
                          child: controller.mainController.userProfileModel?.roleId == 1
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.borrowedBooks);
                                      },
                                      child: Container(
                                        height: Get.height / 7.6,
                                        width: controller.isTablet ? Get.width / 2.15 : Get.width / 2.3,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: greenColor),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${controller.dashboardModel.value?.totalBorrowedBooks}",
                                              style: TextStyle(fontSize: 18.sp, color: greenColor, fontWeight: FontWeight.bold),
                                            ),
                                            const Text("Borrowed Books"),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: Get.height / 7.6,
                                      width: controller.isTablet ? Get.width / 2.15 : Get.width / 2.3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: customBlueColor),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${controller.dashboardModel.value?.totalViewedBooks}",
                                            style: TextStyle(fontSize: 18.sp, color: customBlueColor, fontWeight: FontWeight.bold),
                                          ),
                                          const Text("Book Views"),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : controller.mainController.userProfileModel?.roleId == 2

                                  ///2
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.myBooks);
                                          },
                                          child: Container(
                                            height: Get.height / 8.5,
                                            width: controller.isTablet ? Get.width / 2.15 : Get.width / 2.3,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(color: primaryColor),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${controller.dashboardAuthorModel.value!.myBooks.length}",
                                                  style: TextStyle(fontSize: 18.sp, color: primaryColor, fontWeight: FontWeight.bold),
                                                ),
                                                const Text("My Books"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.pendingBooks);
                                          },
                                          child: Container(
                                            height: Get.height / 8.5,
                                            width: controller.isTablet ? Get.width / 2.15 : Get.width / 2.3,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(color: greenColor),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${controller.dashboardAuthorModel.value!.pendingBooks.length}",
                                                  style: TextStyle(fontSize: 18.sp, color: greenColor, fontWeight: FontWeight.bold),
                                                ),
                                                const Text("Pending Books"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )

                                  ///3
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.borrowedBooks);
                                          },
                                          child: Container(
                                            height: Get.height / 8.5,
                                            width: controller.isTablet ? Get.width / 2.2 : Get.width / 2.3,
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(color: greenColor),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${controller.dashboardInstitutionModel.value?.totalIssuedBooks}",
                                                  style: TextStyle(fontSize: 18.sp, color: greenColor, fontWeight: FontWeight.bold),
                                                ),
                                                const Text("Issued Books"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: Get.height / 8.5,
                                          width: controller.isTablet ? Get.width / 2.2 : Get.width / 2.3,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color: customBlueColor),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${controller.dashboardInstitutionModel.value?.totalViewedBooks}",
                                                style: TextStyle(fontSize: 18.sp, color: customBlueColor, fontWeight: FontWeight.bold),
                                              ),
                                              const Text("Book Views"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverToBoxAdapter(
                          child: controller.mainController.userProfileModel?.roleId == 1

                              ///1
                              ? controller.dashboardModel.value?.user.planId == 1
                                  ? Container(
                                      height: Get.height / 8.5,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: redDeepColor),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          "Free Subscription",
                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: Get.height / 7.6,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        color: isFreeSub ? redDeepColor.withValues(alpha: 0.1) : Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: isFreeSub ? redDeepColor : greenColor),
                                      ),
                                      child: isFreeSub
                                          ? Center(
                                              child: Text(
                                                "Free Subscription",
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: redDeepColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          : Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${controller.dashboardModel.value?.subscriptionRemaining}",
                                                  style: TextStyle(fontSize: 18.sp, color: greenColor, fontWeight: FontWeight.bold),
                                                ),
                                                Text("Subscription Remaining (${controller.dashboardModel.value?.plan.title})"),
                                              ],
                                            ),
                                    )
                              : controller.mainController.userProfileModel?.roleId == 2

                                  ///2
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.declineBooks);
                                          },
                                          child: Container(
                                            height: Get.height / 8.5,
                                            width: controller.isTablet ? Get.width / 2.15 : Get.width / 2.3,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(color: customBlueColor),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${controller.dashboardAuthorModel.value!.declineBooks.length}",
                                                  style: TextStyle(fontSize: 18.sp, color: customBlueColor, fontWeight: FontWeight.bold),
                                                ),
                                                const Text("Declined Books"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(Routes.myReaders);
                                          },
                                          child: Container(
                                            height: Get.height / 8.5,
                                            width: controller.isTablet ? Get.width / 2.15 : Get.width / 2.3,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(color: redDeepColor),
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${controller.dashboardAuthorModel.value!.readersCount}",
                                                  style: TextStyle(fontSize: 18.sp, color: redDeepColor, fontWeight: FontWeight.bold),
                                                ),
                                                const Text("My Readers"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )

                                  ///3
                                  : GestureDetector(
                                      onTap: () {
                                        print("Fav Books Clicked");
                                        Get.toNamed(Routes.favouriteBook);
                                      },
                                      child: Container(
                                        height: Get.height / 8.5,
                                        width: Get.width / 2.3,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(16),
                                          border: Border.all(color: greenColor),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${controller.dashboardInstitutionModel.value?.totalFavBooks}",
                                              style: TextStyle(fontSize: 18.sp, color: greenColor, fontWeight: FontWeight.bold),
                                            ),
                                            const Text("Favourite Books"),
                                          ],
                                        ),
                                      ),
                                    ),
                        ),
                      ),

                      ///Latest Viewed Books or Latest Books
                      SliverPadding(
                        padding: controller.isTablet
                            ? EdgeInsets.only(left: 8.w, right: 8.w, bottom: 10.h)
                            : EdgeInsets.only(left: 16.w, right: 16.w, bottom: 10.h),
                        sliver: SliverToBoxAdapter(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.mainController.userProfileModel?.roleId == 2

                                    ///2
                                    ? "Latest Books"

                                    ///3
                                    : "Last viewed books",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                              ),
                              Visibility(
                                visible: controller.mainController.userProfileModel?.roleId == 2 &&
                                    controller.dashboardAuthorModel.value?.myBooks.isEmpty == false,
                                child: CustomBtn(
                                  width: controller.isTablet ? Get.width / 5.5 : Get.width / 5,
                                  text: "View All",
                                  size: controller.isTablet ? 8.sp : 14,
                                  callback: () {
                                    Get.toNamed(Routes.myBooks);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverToBoxAdapter(
                          child: controller.mainController.userProfileModel?.roleId == 1

                              ///1
                              ? controller.dashboardModel.value?.lastViewedBooks.isEmpty == true
                                  ? Container()
                                  : Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        border: Border.all(color: Colors.grey.shade100),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Book",
                                                style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "Publisher",
                                                style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "Publisher Year",
                                                style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "ISBN",
                                                style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                              : controller.mainController.userProfileModel?.roleId == 2

                                  ///2
                                  ? controller.dashboardAuthorModel.value?.myBooks.isEmpty == true
                                      ? Container()
                                      : Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            border: Border.all(color: Colors.grey.shade100),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Book",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "Publisher",
                                                style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "Publisher Year",
                                                style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                              ),
                                              Text(
                                                "Action",
                                                style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )
                                  : controller.dashboardInstitutionModel.value?.lastViewedBooks.isEmpty == true
                                      ? Container()
                                      : Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                            border: Border.all(color: Colors.grey.shade100),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    "Book",
                                                    style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Publisher",
                                                    style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "Publisher Year",
                                                    style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                                  ),
                                                  Text(
                                                    "ISBN",
                                                    style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: controller.mainController.userProfileModel?.roleId == 1

                            ///1
                            ? controller.dashboardModel.value?.lastViewedBooks.isEmpty == true
                                ? SliverPadding(
                                    padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h),
                                    sliver: SliverToBoxAdapter(child: CustomGifImage(height: Get.height / 7)),
                                  )
                                : SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      childCount: controller.dashboardModel.value?.lastViewedBooks.length,
                                      (context, index) {
                                        final lastView = controller.dashboardModel.value?.lastViewedBooks[index];
                                        return Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade100)),
                                          child: DashboardCardLastViewedUserBook(
                                            controller: controller,
                                            lastViewedBook: lastView!,
                                          ),
                                        );
                                      },
                                    ),
                                  )
                            : controller.mainController.userProfileModel?.roleId == 2

                                ///2
                                ? controller.dashboardAuthorModel.value?.myBooks.isEmpty == true
                                    ? SliverPadding(
                                        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h),
                                        sliver: SliverToBoxAdapter(child: CustomGifImage(height: Get.height / 7)),
                                      )
                                    : SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          childCount: controller.dashboardAuthorModel.value!.myBooks.length,
                                          (context, index) {
                                            return Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade100)),
                                              child: DashboardCardLatestBook(
                                                book: controller.dashboardAuthorModel.value!.myBooks[index],
                                                controller: controller,
                                              ),
                                            );
                                          },
                                        ),
                                      )

                                ///3
                                : controller.dashboardInstitutionModel.value?.lastViewedBooks.isEmpty == true
                                    ? SliverPadding(
                                        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 50.h),
                                        sliver: SliverToBoxAdapter(child: CustomGifImage(height: Get.height / 7)),
                                      )
                                    : SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          childCount: controller.dashboardInstitutionModel.value?.lastViewedBooks.length,
                                          (context, index) {
                                            return Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade100)),
                                              child: controller.dashboardInstitutionModel.value == null
                                                  ? Container()
                                                  : DashboardCardLastViewedBook(
                                                      controller: controller,
                                                      lastViewedBooks: controller.dashboardInstitutionModel.value!.lastViewedBooks[index],
                                                    ),
                                            );
                                          },
                                        ),
                                      ),
                      ),

                      ///Last Borrowed  Books or Top Readers
                      SliverPadding(
                        padding: const EdgeInsets.all(1),
                        sliver: SliverToBoxAdapter(
                          child: Visibility(
                            visible: controller.mainController.userProfileModel?.roleId != 3,
                            child: Padding(
                              padding: controller.isTablet
                                  ? EdgeInsets.only(
                                      left: 8.w,
                                      right: 8.w,
                                      top: 10.h,
                                      bottom: 10.h,
                                    )
                                  : EdgeInsets.only(left: 15.w, right: 15.w, bottom: 15.h, top: 15.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.mainController.userProfileModel?.roleId != 1
                                        ? controller.mainController.userProfileModel?.roleId == 2

                                            ///2
                                            ? "Top Readers"

                                            ///3
                                            : ""

                                        ///1
                                        : "Last borrowed books",
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Visibility(
                                    visible: controller.mainController.userProfileModel?.roleId != 3 &&
                                            controller.dashboardModel.value?.lastBorrowedBooks.isEmpty == false ||
                                        controller.dashboardAuthorModel.value?.topReaders.isEmpty == false,
                                    child: CustomBtn(
                                      width: controller.isTablet ? Get.width / 5.5 : Get.width / 5,
                                      size: controller.isTablet ? 8.sp : 14,
                                      text: "View All",
                                      callback: () {
                                        if (controller.mainController.userProfileModel?.roleId == 1) {
                                          Get.toNamed(Routes.borrowedBooks);
                                        } else if (controller.mainController.userProfileModel?.roleId == 2) {
                                          Get.toNamed(Routes.myReaders);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverToBoxAdapter(
                          child: Visibility(
                            visible: controller.mainController.userProfileModel?.roleId != 3,
                            child: controller.mainController.userProfileModel?.roleId == 1

                                ///1
                                ? controller.dashboardModel.value?.lastBorrowedBooks.isEmpty == true
                                    ? Container()
                                    : Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(color: Colors.grey.shade100)),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Book",
                                                  style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  "Publisher",
                                                  style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  "Publisher Year",
                                                  style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  "ISBN",
                                                  style: TextStyle(fontSize: controller.isTablet ? 10.sp : 12.sp, fontWeight: FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                : controller.mainController.userProfileModel?.roleId == 2

                                    ///2
                                    ? controller.dashboardAuthorModel.value?.topReaders.isEmpty == true
                                        ? Container()
                                        : Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(color: Colors.grey.shade100, border: Border.all(color: Colors.grey.shade100)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Book Cover",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: controller.isTablet ? 10.sp : 12.sp,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Book Title",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: controller.isTablet ? 10.sp : 12.sp,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Reader Name",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: controller.isTablet ? 10.sp : 12.sp,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "Total Views",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        overflow: TextOverflow.ellipsis,
                                                        fontSize: controller.isTablet ? 10.sp : 12.sp,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )

                                    ///3
                                    : Container(),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 40.h),
                        sliver: controller.mainController.userProfileModel?.roleId == 1

                            ///1
                            ? controller.dashboardModel.value?.lastBorrowedBooks.isEmpty == true
                                ? SliverPadding(
                                    padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h),
                                    sliver: SliverToBoxAdapter(child: CustomGifImage(height: Get.height / 7)),
                                  )
                                : SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      childCount: controller.dashboardModel.value?.lastBorrowedBooks.length,
                                      (context, index) {
                                        return Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade100)),
                                          child: DashboardCardLastBorrowedBook(
                                              controller: controller, lastBorrowedBook: controller.dashboardModel.value!.lastBorrowedBooks[index]),
                                        );
                                      },
                                    ),
                                  )
                            : controller.mainController.userProfileModel?.roleId == 2

                                ///2
                                ? controller.dashboardAuthorModel.value?.topReaders.isEmpty == true
                                    ? SliverPadding(
                                        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h),
                                        sliver: SliverToBoxAdapter(child: CustomGifImage(height: Get.height / 7)),
                                      )
                                    : SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          childCount: controller.dashboardAuthorModel.value!.topReaders.length,
                                          (context, index) {
                                            return Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: Colors.grey.shade100)),
                                              child: DashboardCardTopReaders(topReader: controller.dashboardAuthorModel.value!.topReaders[index]),
                                            );
                                          },
                                        ),
                                      )

                                ///3
                                : controller.dashboardInstitutionModel.value?.lastIssuedBooks.isEmpty == true
                                    ? SliverPadding(
                                        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h),
                                        sliver: SliverToBoxAdapter(child: Container()
                                            // CustomGifImage(
                                            //     height: Get.height / 7)
                                            ),
                                      )
                                    : SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          childCount: controller.dashboardInstitutionModel.value?.lastIssuedBooks.length,
                                          (context, index) {
                                            return const SizedBox();
                                          },
                                        ),
                                      ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 50.h)),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
