import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/archivment/archivment_screen.dart';
import 'package:tcllibraryapp_develop/screens/book/bookOfTheMonth/book_of_the_month_screen.dart';
import 'package:tcllibraryapp_develop/screens/book/bookforsale/all_book_for_sale_screen.dart';
import 'package:tcllibraryapp_develop/screens/book/bookforsale/purchased_book_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/book/authorBook/controller/author_book_controller.dart';

class CustomDrawer extends GetView<AuthorBookController> {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: Get.height,
        width: Get.width * 0.70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(left: 16.w, top: 10.h),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => Container(
                            height: Get.height / 15,
                            width: Get.height / 15,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4,
                                strokeAlign: BorderSide.strokeAlignOutside,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 16,
                                    offset: const Offset(0, 0)),
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    blurRadius: 16,
                                    offset: const Offset(0, 0)),
                              ],
                            ),
                            child: controller.settingsController.isLoading.value
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade200,
                                    child: Container(
                                      height: 140,
                                      width: 140,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(100.r),
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: CustomImage(
                                      path:
                                          "${RemoteUrls.rootUrl}${controller.settingsController.userProfileModel?.image}",
                                      height: 140,
                                      width: 140,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              controller.settingsController.isLoading.value
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade200,
                                      child: Container(
                                        height: Get.height / 27,
                                        width: Get.width / 1.9.w,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: Get.width / 2.2,
                                      padding: EdgeInsets.all(2.w),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${controller.settingsController.userProfileModel?.name} ${controller.settingsController.userProfileModel?.lastName}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 15.sp),
                                        ),
                                      ),
                                    ),
                              // SizedBox(height: 2.h),
                              // controller.settingsController.isLoading.value
                              //     ? Shimmer.fromColors(
                              //         baseColor: Colors.grey.shade300,
                              //         highlightColor: Colors.grey.shade200,
                              //         child: Container(
                              //           height: Get.height / 18,
                              //           width: Get.width,
                              //           alignment: Alignment.center,
                              //           decoration: BoxDecoration(
                              //             color: Colors.grey,
                              //             borderRadius:
                              //                 BorderRadius.circular(5.r),
                              //           ),
                              //         ),
                              //       )
                              //     : Container(
                              //         width: Get.width,
                              //         decoration: BoxDecoration(
                              //           borderRadius:
                              //               BorderRadius.circular(2.r),
                              //         ),
                              //         child: Text(
                              //           "${controller.settingsController.userProfileModel?.email}",
                              //           maxLines: 2,
                              //           overflow: TextOverflow.ellipsis,
                              //         ),
                              //       ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),

                    ///Dashboard option
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            const Icon(Icons.home_outlined),
                            SizedBox(width: 10.w),
                            const Text("DashBoard"),
                          ],
                        ),
                      ),
                    ),

                    ///BOOK OPTIONS
                    controller.mainController.userProfileModel?.roleId == 2
                        ? Column(
                            children: [
                              SizedBox(height: 20.h),
                              GestureDetector(
                                onTap: () {
                                  controller.isBook.value =
                                      !controller.isBook.value;
                                },
                                child: Obx(
                                  () => Padding(
                                    padding:
                                        EdgeInsets.only(left: 2.w, right: 10.w),
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const CustomImage(
                                                path: "assets/images/book.png",
                                                height: 22,
                                              ),
                                              SizedBox(width: 13.w),
                                              const Text("My Books"),
                                            ],
                                          ),
                                          controller.isBook.value
                                              ? const Icon(
                                                  Icons.keyboard_arrow_down)
                                              : const Icon(
                                                  Icons.keyboard_arrow_left),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => Visibility(
                                  visible: controller.isBook.value,
                                  child: Column(
                                    children: List.generate(
                                      controller.bookList.length,
                                      (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (index == 0) {
                                              Navigator.pop(context);
                                              Get.toNamed(Routes.myBooks);
                                              controller.isBook.value =
                                                  !controller.isBook.value;
                                            }
                                            if (index == 1) {
                                              Navigator.pop(context);
                                              Get.toNamed(Routes.pendingBooks);
                                              controller.isBook.value =
                                                  !controller.isBook.value;
                                            }
                                            if (index == 2) {
                                              Navigator.pop(context);
                                              Get.toNamed(Routes.declineBooks);
                                              controller.isBook.value =
                                                  !controller.isBook.value;
                                            }
                                            if (index == 3) {
                                              Navigator.pop(context);
                                              Get.toNamed(Routes.myReaders);
                                            }
                                          },
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              color: Colors.white,
                                              width: Get.width,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 33.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Divider(
                                                        thickness: 1,
                                                        color: Colors.black26),
                                                    Text(
                                                        "${controller.bookList[index]["name"]}"),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        : Column(
                            children: [
                              SizedBox(height: 20.h),
                              GestureDetector(
                                onTap: () {
                                  controller.isLibrary.value =
                                      !controller.isLibrary.value;
                                },
                                child: Obx(
                                  () => Padding(
                                    padding:
                                        EdgeInsets.only(left: 2.w, right: 10.w),
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/book.png',
                                                height: 22,
                                              ),
                                              SizedBox(width: 13.w),
                                              const Text("Library"),
                                            ],
                                          ),
                                          controller.isLibrary.value
                                              ? const Icon(
                                                  Icons.keyboard_arrow_down)
                                              : const Icon(
                                                  Icons.keyboard_arrow_left),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Obx(
                                () => Visibility(
                                  visible: controller.isLibrary.value,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: List.generate(
                                        controller.mainController
                                                    .userProfileModel?.roleId ==
                                                1
                                            ? controller.libraryBookList.length
                                            : controller
                                                .libraryBookListInstitution
                                                .length,
                                        (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              if (controller
                                                      .mainController
                                                      .userProfileModel
                                                      ?.roleId ==
                                                  1) {
                                                if (index == 0) {
                                                  Navigator.pop(context);
                                                  controller.isLibrary.value =
                                                      !controller
                                                          .isLibrary.value;
                                                  Get.toNamed(Routes.allBooks);
                                                } else if (index == 1) {
                                                  Navigator.pop(context);
                                                  controller.isLibrary.value =
                                                      !controller
                                                          .isLibrary.value;
                                                  Get.toNamed(
                                                      Routes.favouriteBook);
                                                } else if (index == 2) {
                                                  Navigator.pop(context);
                                                  controller.isLibrary.value =
                                                      !controller
                                                          .isLibrary.value;
                                                  Get.toNamed(
                                                      Routes.borrowedBooks);
                                                } else if (index == 3) {
                                                  controller.isLibrary.value =
                                                      !controller
                                                          .isLibrary.value;
                                                  Get.to(() =>
                                                      BookOfTheMonthScreen());
                                                }
                                              } else if (controller
                                                      .mainController
                                                      .userProfileModel
                                                      ?.roleId ==
                                                  3) {
                                                if (index == 0) {
                                                  Navigator.pop(context);
                                                  controller.isLibrary.value =
                                                      !controller
                                                          .isLibrary.value;
                                                  Get.toNamed(
                                                      Routes.borrowedBooks);
                                                } else if (index == 1) {
                                                  Navigator.pop(context);
                                                  controller.isLibrary.value =
                                                      !controller
                                                          .isLibrary.value;
                                                  Get.toNamed(
                                                      Routes.favouriteBook);
                                                }
                                              }
                                            },
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                color: Colors.transparent,
                                                width: Get.width,
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 33.w),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Divider(
                                                          thickness: 1,
                                                          color:
                                                              Colors.black26),
                                                      Text(
                                                        controller
                                                                    .mainController
                                                                    .userProfileModel
                                                                    ?.roleId ==
                                                                1
                                                            ? "${controller.libraryBookList[index]["name"]}"
                                                            : "${controller.libraryBookListInstitution[index]["name"]}",
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                    //// Books For Sale
                    Column(
                      children: [
                        SizedBox(height: 20.h),
                        GestureDetector(
                          onTap: () {
                            controller.isBookForSale.value =
                                !controller.isBookForSale.value;
                          },
                          child: Obx(
                            () => Padding(
                              padding: EdgeInsets.only(left: 2.w, right: 10.w),
                              child: Container(
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/book.png',
                                          height: 22,
                                        ),
                                        SizedBox(width: 13.w),
                                        const Text("Books For Sale"),
                                      ],
                                    ),
                                    controller.isBookForSale.value
                                        ? const Icon(Icons.keyboard_arrow_down)
                                        : const Icon(Icons.keyboard_arrow_left),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.isBookForSale.value,
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  controller.mainController.userProfileModel
                                              ?.roleId ==
                                          1
                                      ? controller.bookForSaleBookList.length
                                      : controller
                                          .libraryBookListInstitution.length,
                                  (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (index == 0) {
                                          Navigator.pop(context);
                                          controller.isBookForSale.value =
                                              !controller.isBookForSale.value;
                                          // Get.toNamed(Routes.allBooks);
                                          Get.to(() => AllBookForSaleScreen());
                                          log("All");
                                        } else if (index == 1) {
                                          Navigator.pop(context);
                                          controller.isBookForSale.value =
                                              !controller.isBookForSale.value;
                                          // Get.toNamed(Routes.favouriteBook);
                                          Get.to(() =>
                                              BookForSalePurchasedScreen());
                                          log("Purchase Book");
                                        }
                                      },
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          color: Colors.transparent,
                                          width: Get.width,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 33.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Divider(
                                                    thickness: 1,
                                                    color: Colors.black26),
                                                Text(
                                                  controller
                                                              .mainController
                                                              .userProfileModel
                                                              ?.roleId ==
                                                          1
                                                      ? "${controller.bookForSaleBookList[index]["name"]}"
                                                      : "${controller.libraryBookListInstitution[index]["name"]}",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    ///Promo Code
                    Visibility(
                      visible:
                          controller.mainController.userProfileModel?.roleId ==
                              1,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.toNamed(Routes.applyPromoCode);
                        },
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/promo-code.png",
                                    height: 22,
                                  ),
                                  SizedBox(width: 12.w),
                                  const Text("Apply PromoCode"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // SizedBox(height: 20.h),

                    /// Achievements
                    Visibility(
                      visible:
                          controller.mainController.userProfileModel?.roleId ==
                              1,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          Get.to(() => const ArchivementScree());
                        },
                        child: Column(
                          children: [
                            SizedBox(height: 20.h),
                            Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  // Image.asset(
                                  //   "assets/images/promo-code.png",
                                  //   height: 22,
                                  // ),

                                  Icon(
                                    Icons.emoji_events_outlined,
                                    size: 22,
                                  ),
                                  SizedBox(width: 12.w),
                                  const Text("Achievements"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///Notification option
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.notifications);
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            const Icon(Icons.notifications_outlined),
                            SizedBox(width: 10.w),
                            const Text("Notification"),
                          ],
                        ),
                      ),
                    ),

                    ///Club Option
                    Visibility(
                      visible:
                          controller.mainController.userProfileModel?.roleId ==
                              1,
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              if (controller.mainController.userProfileModel!
                                      .plan.price ==
                                  "0") {
                                Get.snackbar('Warning',
                                    'Please upgrade your plan to get access club feature');
                                Get.toNamed(Routes.pricing);
                              } else {
                                Get.toNamed(Routes.clubScreen);
                              }
                            },
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  const Icon(Icons.groups_outlined),
                                  SizedBox(width: 10.w),
                                  const Text("Club"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///My Subscription
                    Visibility(
                      visible:
                          controller.mainController.userProfileModel?.roleId ==
                              1,
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.mySubscriptionScreen);
                            },
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/ecommerce.png",
                                    height: 22,
                                  ),
                                  SizedBox(width: 13.w),
                                  const Text("My Subscription"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///Transaction
                    Visibility(
                      visible:
                          controller.mainController.userProfileModel?.roleId ==
                              1,
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.transactionScreen);
                            },
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  const Icon(Icons.credit_card_outlined),
                                  SizedBox(width: 10.w),
                                  const Text("Transactions"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///Support Ticket Option
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.supportTicket);
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            const Icon(Icons.support_agent_outlined),
                            SizedBox(width: 10.w),
                            const Text("Support Ticket"),
                          ],
                        ),
                      ),
                    ),

                    ///Setting Option
                    Visibility(
                      visible:
                          controller.mainController.userProfileModel?.roleId ==
                              1,
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.setting);
                            },
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  const Icon(Icons.settings_outlined),
                                  SizedBox(width: 10.w),
                                  const Text("Settings"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    ///Pricing Option
                    Visibility(
                      visible:
                          controller.mainController.userProfileModel?.roleId ==
                              1,
                      child: Column(
                        children: [
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.pricing);
                            },
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  const Icon(Icons.attach_money),
                                  SizedBox(width: 10.w),
                                  const Text("Pricing"),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///Blog Option
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                        final Uri url = Uri.parse(RemoteUrls.blogs);
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 2.w),
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/blogger.png",
                                height: 22,
                              ),
                              SizedBox(width: 10.w),
                              const Text("Blog"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///Forum Option
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                        final Uri url = Uri.parse(RemoteUrls.forum);
                        if (!await launchUrl(url,
                            mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/communication.png",
                              height: 22,
                            ),
                            SizedBox(width: 13.w),
                            const Text("Forum"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///Privacy Policy Option
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.privacyPolicy);
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/insurance.png",
                              height: 22,
                            ),
                            SizedBox(width: 13.w),
                            const Text("Privacy Policy"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///Terms & Conditions Option
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.termsCondition);
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/terms-and-conditions.png",
                              height: 20,
                            ),
                            SizedBox(width: 13.w),
                            const Text("Terms & Conditions"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///Faq Option
                    GestureDetector(
                      onTap: () {
                        Get.back();
                        Get.toNamed(Routes.faq);
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/help.png",
                              height: 22,
                            ),
                            SizedBox(width: 13.w),
                            const Text("Faq"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    ///Logout Option
                    GestureDetector(
                      onTap: () async {
                        Get.back();
                        controller.onBackPressed(context);
                      },
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          children: [
                            const Icon(Icons.logout),
                            SizedBox(width: 10.w),
                            const Text("Logout Account"),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
