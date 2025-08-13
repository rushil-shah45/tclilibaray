import 'dart:async';
import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/models/package_wrapper.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/global_widgets/custom_dialog.dart';
import 'package:tcllibraryapp_develop/screens/pricing/controller/pricing_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

import '../../routes/routes.dart';
import 'component/pricing_shimmer.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    const Duration autoScrollDuration = Duration(seconds: 7);

    _timer = Timer.periodic(autoScrollDuration, (timer) {
      if (_currentPage < 3 - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PricingController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          title: Text(
            "Subscription",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            return controller.getPricing();
          },
          child: Obx(
            () => controller.isLoading.value
                ? const PricingShimmer()
                : Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 10.w,
                          right: 10.w,
                          bottom: 10.h,
                        ),
                      ),
                      SizedBox(
                        height: Get.height / 1.4,
                        width: Get.width,
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: controller.pricingModelList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: Get.height / 1.6,
                              margin: const EdgeInsets.all(16),
                              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 16.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(color: Colors.transparent),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 6,
                                    offset: const Offset(0, 5),
                                  )
                                ],
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                          controller.pricingModelList[index].title,
                                          style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: Table(
                                            children: [
                                              tableRow(
                                                title: "Price",
                                                subtitle: controller.pricingModelList[index].title == "Free"
                                                    ? "Free"
                                                    : controller.pricingModelList[index].title == "Light"
                                                        ? "\$${controller.pricingModelList[index].price}  ${controller.pricingModelList[index].priceNgn != null ? ' or N${controller.pricingModelList[index].priceNgn} Annually' : ''}"
                                                        : "\$${controller.pricingModelList[index].price} ${controller.pricingModelList[index].priceNgn != null ? ' or N${controller.pricingModelList[index].priceNgn} Monthly' : ''}",
                                              ),
                                              tableRow(title: "Offerings", subtitle: controller.pricingModelList[index].offerings),
                                              tableRow(title: "Library Content", subtitle: controller.pricingModelList[index].pricingModelLibrary),
                                              tableRow(title: "Book Access", subtitle: controller.pricingModelList[index].book),
                                              tableRow(title: "Blog", subtitle: controller.pricingModelList[index].blog),
                                              tableRow(title: "Forum", subtitle: controller.pricingModelList[index].forum),
                                              tableRow(title: "Book Club", subtitle: controller.pricingModelList[index].club),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                      ],
                                    ),
                                    SizedBox(height: 50.h),
                                    controller.pricingModelList[index].isSubscribed == false
                                        ? CustomBtn(
                                            width: Get.width / 2,
                                            text: "Subscribe",
                                            gradient: controller.pricingModelList[index].isSubscribed == false
                                                ? const LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: <Color>[primaryColor, primColor],
                                                  )
                                                : const LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: <Color>[blueGradiantColor, blueColor],
                                                  ),
                                            callback: () {
                                              log(controller.pricingModelList[index].title, name: 'PricingScreen');
                                              if (controller.pricingModelList[index].isSubscribed == false &&
                                                  controller.pricingModelList[index].title.compareTo('Free') != 0) {
                                                if (!Platform.isAndroid) {
                                                  for (Package p in controller.pack.value) {
                                                    if (controller.pricingModelList[index].title.contains(p.storeProduct.title) &&
                                                        controller.pricingModelList[index].title.contains('Light')) {
                                                      Get.toNamed(Routes.inAppPurchaseScreen,
                                                          arguments: [p, controller.pricingModelList[index].id.toString()]);
                                                    } else if (controller.pricingModelList[index].title.contains(p.storeProduct.title) &&
                                                        controller.pricingModelList[index].title.contains('Premium')) {
                                                      Get.toNamed(Routes.inAppPurchaseScreen,
                                                          arguments: [p, controller.pricingModelList[index].id.toString()]);
                                                    } else if (controller.pricingModelList[index].title.contains(p.storeProduct.title) &&
                                                        p.storeProduct.title.contains('Tcli one year Membership')) {
                                                      Get.toNamed(Routes.inAppPurchaseScreen,
                                                          arguments: [p, controller.pricingModelList[index].id.toString()]);
                                                    } else if (controller.pricingModelList[index].title.contains(p.storeProduct.title) &&
                                                        p.storeProduct.title.contains('TCLI Membership Payment')) {
                                                      Get.toNamed(Routes.inAppPurchaseScreen,
                                                          arguments: [p, controller.pricingModelList[index].id.toString()]);
                                                    }
                                                  }
                                                } else {
                                                  Get.toNamed(Routes.paymentScreen, arguments: controller.pricingModelList[index]);
                                                }
                                              } else if (controller.pricingModelList[index].title.compareTo('Free') == 0) {
                                                Get.toNamed(Routes.paymentScreen, arguments: controller.pricingModelList[index]);
                                              }
                                            },
                                          )
                                        : CustomBtn(
                                            width: Get.width / 2,
                                            text: "Subscribed",
                                            gradient: controller.pricingModelList[index].isSubscribed == false
                                                ? const LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: <Color>[primaryColor, primColor],
                                                  )
                                                : const LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: <Color>[blueGradiantColor, blueColor],
                                                  ),
                                            callback: () {
                                              // Get.toNamed(Routes.paymentScreen, arguments: controller.pricingModelList[index]);
                                              // if (controller
                                              //             .pricingModelList[
                                              //                 index]
                                              //             .isSubscribed ==
                                              //         false &&
                                              //     controller
                                              //             .pricingModelList[
                                              //                 index]
                                              //             .title
                                              //             .compareTo('Free') !=
                                              //         0) {
                                              //   if (Platform.isIOS) {
                                              //     for (Package p in controller
                                              //         .pack.value) {
                                              //       if ('yearly_${controller.pricingModelList[index].title.toLowerCase()}'
                                              //               .compareTo(p
                                              //                   .storeProduct
                                              //                   .identifier) ==
                                              //           0) {
                                              //         Get.toNamed(
                                              //             Routes
                                              //                 .inAppPurchaseScreen,
                                              //             arguments: [
                                              //               p,
                                              //               controller
                                              //                   .pricingModelList[
                                              //                       index]
                                              //                   .id
                                              //                   .toString()
                                              //             ]);
                                              //       } else if ('monthly_${controller.pricingModelList[index].title.toLowerCase()}'
                                              //               .compareTo(p
                                              //                   .storeProduct
                                              //                   .identifier) ==
                                              //           0) {
                                              //         Get.toNamed(
                                              //             Routes
                                              //                 .inAppPurchaseScreen,
                                              //             arguments: [
                                              //               p,
                                              //               controller
                                              //                   .pricingModelList[
                                              //                       index]
                                              //                   .id
                                              //                   .toString()
                                              //             ]);
                                              //       } else {
                                              //         Get.toNamed(
                                              //             Routes
                                              //                 .inAppPurchaseScreen,
                                              //             arguments: [
                                              //               p,
                                              //               controller
                                              //                   .pricingModelList[
                                              //                       index]
                                              //                   .id
                                              //                   .toString()
                                              //             ]);
                                              //       }
                                              //     }
                                              //   } else {
                                              //     Get.toNamed(
                                              //         Routes.paymentScreen,
                                              //         arguments: controller
                                              //                 .pricingModelList[
                                              //             index]);
                                              //   }
                                              // } else if (controller
                                              //         .pricingModelList[index]
                                              //         .title
                                              //         .compareTo('Free') ==
                                              //     0) {
                                              //   Get.toNamed(
                                              //       Routes.paymentScreen,
                                              //       arguments: controller
                                              //               .pricingModelList[
                                              //           index]);
                                              // }
                                            },
                                          )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Obx(() => controller.isRestored.value
                          ? controller.products.value.isEmpty
                              ? const Text('No Active Subscription')
                              : Column(
                                  children: [
                                    const Text('Your Purchase Restored:', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: controller.products.value.length,
                                        itemBuilder: (context, index) {
                                          return Center(
                                              child: Text(controller.products.value[index].compareTo('monthly_62f8d81cbf71c') == 0
                                                  ? 'Monthly Gold'
                                                  : controller.products.value[index].compareTo('monthly_62f8d935b6119') == 0
                                                      ? 'Monthly Premium'
                                                      : controller.products.value[index].compareTo('yearly_62f8d81cbf71c') == 0
                                                          ? 'Yearly Gold'
                                                          : 'Yearly Premium'));
                                        }),
                                  ],
                                )
                          : Visibility(
                              visible: false,
                              child: Obx(() => controller.isRestoring.value
                                  ? const Center(child: CircularProgressIndicator())
                                  : GestureDetector(
                                      onTap: () async {
                                        await controller.restorePurchase();
                                      },
                                      child: Container(
                                        height: 45,
                                        width: Get.width / 2,
                                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(8)),
                                        child: const Text(
                                          'Restore Purchase',
                                          style: TextStyle(color: Colors.white, fontSize: 16),
                                        ),
                                      ),
                                    )),
                            )),
                    ],
                  ),
          ),
        ),
      );
    });
  }

  TableRow tableRow({required String title, required String subtitle}) {
    return TableRow(
      children: [
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            // "Book Club",
            title,
            style: darkSmallBoldTextStyle,
          ),
        )),
        TableCell(
            child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            // controller.pricingModelList[index].club,
            subtitle,
            style: greySmallTextStyle,
          ),
        )),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }
}
