import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/data/SettingsDataController.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/auth/login/controller/login_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/bookSummary/conponent/book_summary_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/book/bookSummary/controller/book_summary_controller.dart';
import 'package:tcllibraryapp_develop/screens/book/model/books_model.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/setting/model/profile_model.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';

import 'conponent/book_cover.dart';

class BookSummaryScreen extends StatefulWidget {
  const BookSummaryScreen({super.key});

  @override
  State<BookSummaryScreen> createState() => _BookSummaryScreenState();
}

class _BookSummaryScreenState extends State<BookSummaryScreen> {
  final ScrollController _scrollController = ScrollController();
  BookSummaryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookSummaryController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Book Summary"),
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
            ),
          ),
        ),
        bottomNavigationBar: CustomBtn(
          width:
          Get.width /
              4.3.w,
          // text: controller.bookSummaryDetail.value?.bookFor ==
          //     "sale"
          //     ? (controller.bookSummaryDetail.value?.isBorrowed == true &&
          //     (controller.bookSummaryDetail.value?.borrowedEnddate ?? "").isEmpty)
          //     ? 'Bought'
          //     : "Buy - ${controller.bookSummaryDetail.value?.bookPrice}\$"
          //     : controller.bookSummaryDetail.value?.fileType == "url"
          //     ? "Watch Now"
          //     : (controller.bookSummaryDetail.value?.isPaid == 0 ||
          //     controller.mainController.userProfileModel!.currentUserPlan?.packageId != '1')
          //     ? (controller.bookSummaryDetail.value?.isBorrowed == false)
          //     ? 'Borrow'
          //     : (DateTime.now().isAfter(DateTime.parse(controller.bookSummaryDetail.value?.borrowedNextdate ?? "")))
          //     ? 'Borrow'
          //     : (DateTime.now().isAfter(DateTime.parse(controller.bookSummaryDetail.value?.borrowedEnddate ?? "")) && DateTime.now().isBefore(DateTime.parse(controller.bookSummaryDetail.value?.borrowedNextdate ?? "")))
          //     ? 'Locked'
          //     : 'Borrowed'
          //     : 'Premium',
          text: getBookActionText(controller.bookSummaryDetail.value!, controller.mainController.userProfileModel),
          gradient: controller.bookSummaryDetail.value?.bookFor ==
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
              : controller.bookSummaryDetail.value?.fileType ==
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
              : controller.bookSummaryDetail.value?.isPaid == 0 ||
              controller.mainController.userProfileModel!.currentUserPlan?.packageId != '1'
              ? controller.bookSummaryDetail.value?.isBorrowed == false
              ? const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              primaryColor,
              primaryColor
            ],
          )
              : (DateTime.now().isAfter(DateTime.parse(controller.bookSummaryDetail.value?.borrowedNextdate ?? "")))
              ? const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              primaryColor,
              primaryColor
            ],
          )
              : (DateTime.now().isAfter(DateTime.parse(controller.bookSummaryDetail.value?.borrowedEnddate ?? "")) && DateTime.now().isBefore(DateTime.parse(controller.bookSummaryDetail.value?.borrowedNextdate ?? "")))
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
                controller.bookSummaryDetail.value!,
                controller.settingsDataController);

            log(
                "BookDetails: FoSell: ${controller.bookSummaryDetail.value?.bookFor}, isBorrowed: ${controller.bookSummaryDetail.value?.isBorrowed}");

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
        body: Obx(
          () => controller.isLoading.value
              ? const BookSummaryShimmer()
              : controller.bookSummaryDetail.value == null
                  ? const Center(
                      child: Text(
                        "Summary for this book is not available",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.only(top: 5.h),
                          sliver: SliverToBoxAdapter(
                            child: BookCover(
                                controller: controller,
                                isBookForSale: false,
                                bookForSaleTitle: "",
                                onBookForSaleChange: (value) {}),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10.h),
                                Obx(
                                  () =>
                                      controller.bookSummaryDetail.value != null
                                          ? Text(
                                              controller.bookSummaryDetail
                                                  .value!.title,
                                              maxLines: 2,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          : const SizedBox(),
                                ),
                                Obx(
                                  () =>
                                      controller.bookSummaryDetail.value != null
                                          ? Text(
                                              "Authors: ${controller.bookSummaryDetail.value!.author?.name} ${controller.bookSummaryDetail.value!.author?.lastName}",
                                              style: greyTextStyle,
                                            )
                                          : const SizedBox(),
                                ),
                                Obx(
                                  () =>
                                      controller.bookSummaryDetail.value != null
                                          ? Text(
                                              "Publisher: ${controller.bookSummaryDetail.value!.publisher}",
                                              style: greyTextStyle,
                                            )
                                          : const SizedBox(),
                                ),
                                Obx(
                                  () =>
                                      controller.bookSummaryDetail.value != null
                                          ? Text(
                                              "Publish Years: ${controller.bookSummaryDetail.value!.publisherYear}",
                                              style: greyTextStyle,
                                            )
                                          : const SizedBox(),
                                ),
                                Obx(
                                  () => controller.bookSummaryDetail.value !=
                                              null &&
                                          controller.bookSummaryDetail.value!
                                                  .edition !=
                                              ''
                                      ? Text(
                                          "Edition: ${controller.bookSummaryDetail.value!.edition}",
                                          style: greyTextStyle,
                                        )
                                      : const SizedBox(),
                                ),
                                if(controller.bookSummaryDetail.value != null && controller.bookSummaryDetail.value!.isbn10 != '')
                                  Obx(
                                        () => Text(
                                          "ISBN10: ${controller.bookSummaryDetail.value!.isbn10}",
                                          style: greyTextStyle,
                                        ),
                                  ),
                                if(controller.bookSummaryDetail.value != null && controller.bookSummaryDetail.value!.isbn13 != '')
                                  Obx(
                                        () => Text(
                                      "ISBN13: ${controller.bookSummaryDetail.value!.isbn13}",
                                      style: greyTextStyle,
                                        ),
                                  ),
                                SizedBox(height: 10.h),
                                Text(
                                  "Description",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Obx(
                                  () =>
                                      controller.bookSummaryDetail.value != null
                                          ? Text(
                                              controller.bookSummaryDetail
                                                  .value!.description,
                                              style: greyTextStyle,
                                            )
                                          : const SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
        ),
      );
    });
  }

  void manageButtonNavigation(
      Book model, SettingsDataController settingsDataController) async {
    final now = DateTime.now();
    final bookFor = model.bookFor.split(',');
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
        Get.back();
      } else {
        // Premium restriction
        Get.snackbar("Warning", "This book will be available on Premium Subscription.");
      }
      return;
    }

    // If not allowed access (planId == 1)
    Get.toNamed(Routes.pricing);

    // if (model.bookFor == "sale") {
    //   log("btn callback: 1");
    //   if (model.isBorrowed) {
    //     log("btn callback: 1.1");
    //     Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]);
    //   } else {
    //     log("btn callback: 1.2");
    //     if (!Platform.isIOS) {
    //       payWithPaypal(
    //           settingsDataController.settingsData!.data!.paypalClientId!,
    //           settingsDataController.settingsData!.data!.paypalClientSecret!,
    //           double.tryParse(model.bookPrice) ?? 0.0,
    //           model.title,
    //           "USD",
    //           model.id);
    //     }
    //   }
    // } else {
    //   log("btn callback: 2");
    //   if (model.isBorrowed) {
    //     log("btn callback: 2.3");
    //     Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]);
    //   } else if (model.fileType == "url") {
    //     log("btn callback: 2.1");
    //     Get.toNamed(Routes.bookDetailsScreen, arguments: [model.id, ""]);
    //   } else {
    //     log("btn callback: 2.2");
    //
    //     if ( //model.isPaid == 0 &&
    //     controller.mainController.userProfileModel!.currentUserPlan!
    //         .packageId !=
    //         '1') {
    //       log("btn callback: 2.2.1");
    //       if (model.isBorrowed == false) {
    //         log("btn callback: 2.2.1.1");
    //         controller.storeBorrowBook(model.id).then((value) {
    //           Get.back();
    //           // setState(() {
    //           //   controller.getAllBooksData();
    //           // });
    //         });
    //       } else {
    //         log("btn callback: 2.2.1.2");
    //
    //         if (DateTime.now()
    //             .isAfter(DateTime.parse(model.borrowedNextdate))) {
    //           log("btn callback: 2.2.1.2.1");
    //
    //           controller.storeBorrowBook(model.id).then((value) {
    //             Get.back();
    //             // setState(() {
    //             //   controller.getAllBooksData();
    //             // });
    //           });
    //         } else {
    //           log("btn callback: 2.2.1.2.2");
    //
    //           DateTime.now().isAfter(DateTime.parse(model.borrowedEnddate)) &&
    //               DateTime.now()
    //                   .isBefore(DateTime.parse(model.borrowedNextdate));
    //         }
    //       }
    //     }
    //     // else if(model.isPaid != 0 &&
    //     //     controller
    //     //         .mainController
    //     //         .userProfileModel!
    //     //         .currentUserPlan!
    //     //         .packageId != '1'){
    //     //
    //     //   print("Paid:${model.isPaid}, packegeId: ${controller
    //     //       .mainController
    //     //       .userProfileModel!
    //     //       .currentUserPlan!
    //     //       .packageId}");
    //     //   // controller
    //     //   //     .storeBorrowBook(
    //     //   //     model.id)
    //     //   //     .then((value) {
    //     //   //   setState(() {
    //     //   //     controller
    //     //   //         .getAllBooksData();
    //     //   //   });
    //     //   // });
    //     //   log("btn callback: 2.2.2");
    //     //
    //     // }
    //     else {
    //       log("btn callback: 2.2.3");
    //
    //       (Get.toNamed(Routes.pricing));
    //     }
    //   }
    // }
  }

  String getBookActionText(Book model, UserProfileModel? user) {
    final now = DateTime.now();
    final bookFor = model.bookFor.split(',');
    final fileType = model.fileType;
    final isPaid = model.isPaid;
    final isBorrowed = model.isBorrowed;
    final borrowedEndDate = DateTime.tryParse(model.borrowedEnddate);
    final borrowedNextDate = DateTime.tryParse(model.borrowedNextdate);
    final packageId = user?.currentUserPlan?.packageId;
    final subscriptionRemaining = (user?.currentUserPlan?.expiredDate ?? DateTime.now()).difference(now).inDays;
    // final subscriptionRemaining = borrowedNextDate != null && borrowedEndDate != null && (now.isAfter(borrowedEndDate) && now.isBefore(borrowedNextDate));
    final planTitle = user?.plan.title;


    if (bookFor == "sale" && fileType != 'url') {
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
