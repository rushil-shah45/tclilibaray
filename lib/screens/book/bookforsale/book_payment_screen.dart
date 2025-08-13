import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/global_widgets/custom_dialog.dart';
import 'package:tcllibraryapp_develop/screens/book/bookforsale/controller/all_book_for_sale_screen_controller.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import 'package:tcllibraryapp_develop/screens/payment/componant/coutry_bottomsheet.dart';
import 'package:tcllibraryapp_develop/screens/payment/componant/payment_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/setting/repository/setting_repository.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

class BookPaymentScreen extends StatefulWidget {
  String? bookPrice;
  String? title;
  int? id;
  BookPaymentScreen(
      {super.key,
      required this.bookPrice,
      required this.title,
      required this.id});

  @override
  State<BookPaymentScreen> createState() => _BookPaymentScreenState();
}

class _BookPaymentScreenState extends State<BookPaymentScreen> {
  SettingsRepository settingsRepository = Get.find<SettingsRepository>();
  var controller = Get.put(AllBookForSaleScreenController());

  

  bool isTablet = Get.width >= 600;

  @override
  void initState() {
    controller.getCountryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 500), () {
        controller.emailController.text =
            Get.find<MainController>().userProfileModel!.email.toString();
        controller.nameController.text =
            "${Get.find<MainController>().userProfileModel!.name.toString()} ${Get.find<MainController>().userProfileModel!.lastName.toString()}";

        controller.update();
      });
    });
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "Payment",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: /* Obx(() => isLoading.value
            ? const PaymentShimmer()
            :  */
              Container(
        color: const Color.fromRGBO(136, 152, 170, .15),
        child: Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 5.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, top: 5.h),
                        child: Text(
                          "Buy Book",
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: SizedBox(
                          width: Get.width,
                          child: Table(
                            border:
                                TableBorder.all(color: Colors.grey, width: 1),
                            defaultVerticalAlignment:
                                TableCellVerticalAlignment.middle,
                            children: [
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Book title",
                                    textScaleFactor: 1.1,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Text(
                                    widget.title ?? '',
                                    textScaleFactor: 1.1,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Total Payable",
                                    textScaleFactor: 1.1,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: Text(
                                    '\$${double.parse(widget.bookPrice ?? '').toStringAsFixed(2)}',
                                    textScaleFactor: 1.1,
                                    textAlign: TextAlign.end,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Billing Details",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      const CustomRichText(title: 'Name ', star: "*"),
                      CustomTextField(
                        controller: controller.nameController,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        hintText: "Enter your name",
                      ),
                      const CustomRichText(title: 'Email ', star: "*"),
                      CustomTextField(
                        controller: controller.emailController,
                        textInputType: TextInputType.text,
                        isReadOnly: true,
                        textInputAction: TextInputAction.next,
                      ),
                      const CustomRichText(
                          title: 'Billing Address ', star: "*"),
                      CustomTextField(
                        controller: controller.billingAddressController,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        hintText: "Enter your billing address",
                      ),
                      const CustomRichText(title: 'Billing City ', star: "*"),
                      CustomTextField(
                        controller: controller.billingCityController,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        hintText: "Enter your billing city",
                      ),
                      const CustomRichText(title: 'Billing State ', star: "*"),
                      CustomTextField(
                        controller: controller.billingStateController,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        hintText: "Enter your billing state",
                      ),
                      const CustomRichText(
                          title: 'Billing Zip Code ', star: "*"),
                      CustomTextField(
                        controller: controller.billingZipCodeController,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        hintText: "Enter your billing zip code",
                      ),
                      SizedBox(height: 2.h),
                      const CustomRichText(
                          title: 'Billing Country ', star: "*"),
                      SizedBox(
                        height: Get.height / 15,
                        child: GestureDetector(
                          onTap: () {
                            customBottomSheet(
                                context,
                                CustomCountryBottomSheetForBookPayment(
                                  controller: controller,
                                ));
                          },
                          child: AbsorbPointer(
                            child: CustomTextField(
                              controller:
                                  controller.billingSelectedCountryController,
                              hintText: "Select a Country / Region",
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
                      SizedBox(height: 2.h),
                      const CustomRichText(title: 'Type ', star: "*"),
                      Container(
                        height: Get.height / 16.7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Obx(() {
                          return DropdownButton(
                            padding: EdgeInsets.only(left: 10.w, right: 10.w),
                            value: controller.userItems.value.contains(
                                    controller.userItemsSelected.value
                                        .capitalizeFirst)
                                ? controller
                                    .userItemsSelected.value.capitalizeFirst
                                : null,
                            isExpanded: true,
                            iconEnabledColor: Colors.grey.shade400,
                            underline: const SizedBox(),
                            hint: const Text("Select one"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: controller.userItems.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              controller.userItemsSelected.value =
                                  newValue.toString();
                            },
                          );
                        }),
                      ),
                      SizedBox(height: 8.h),
                      const CustomRichText(title: 'Phone ', star: "*"),
                      SizedBox(
                        height: isTablet ? Get.height / 19 : Get.height / 17,
                        width: Get.width,
                        child: Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: true,
                                  onSelect: (Country country) {
                                    controller.dialCode.value =
                                        country.phoneCode;
                                    controller.flagIcon.value =
                                        country.flagEmoji;
                                    controller.countryCodeName.value =
                                        country.countryCode;
                                  },
                                  countryListTheme: CountryListThemeData(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.r),
                                      topRight: Radius.circular(20.r),
                                    ),

                                    /// if you increase the number of country
                                    /// try to increase the height
                                    /// though it's not mandatory
                                    bottomSheetHeight: Get.height * 0.6,
                                    backgroundColor: Colors.white,
                                    inputDecoration: InputDecoration(
                                      hintText: 'Search',
                                      fillColor: Colors.white,
                                      filled: true,
                                      prefixIcon: const Icon(Icons.search),
                                      contentPadding: EdgeInsets.only(
                                          top: 27.h, left: 10.w, right: 10.w),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: const BorderSide(
                                          color: primaryColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        borderSide: const BorderSide(
                                          color: primaryColor,
                                        ),
                                      ),
                                    ),
                                    searchTextStyle: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: isTablet
                                    ? Get.height / 19
                                    : Get.height / 17,
                                width: Get.width / 5,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.r),
                                    bottomLeft: Radius.circular(10.r),
                                  ),
                                  border:
                                      Border.all(color: Colors.grey.shade400),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Obx(
                                      () => Text(
                                        controller.flagIcon.value,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: isTablet ? 7.w : 2.w),
                                    Obx(
                                      () => Text(
                                        '+${controller.dialCode.value}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: isTablet ? 8.sp : 15.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: Get.width / 5.1,
                              child: SizedBox(
                                height: isTablet
                                    ? Get.height / 19
                                    : Get.height / 17,
                                width: Get.width - (Get.width / 2.84),
                                child: TextField(
                                  controller: controller.phoneController,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: "Enter your phone number",
                                    fillColor: Colors.white,
                                    filled: true,
                                    contentPadding: EdgeInsets.only(
                                        top: 27.h, left: 10.w, right: 10.w),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.r),
                                        bottomRight: Radius.circular(10.r),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.r),
                                        bottomRight: Radius.circular(10.r),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.r),
                                        bottomRight: Radius.circular(10.r),
                                      ),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if(!Platform.isIOS) ...[
                        SizedBox(height: 8.h),
                        Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomRichText(
                              title: 'Payment Method ', star: "*"),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: Get.width,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: Image.asset(
                                        "assets/images/paypal-logo.png",
                                        height: Get.height / 20,
                                        width: Get.width / 8),
                                  ),
                                  Text(
                                    "Paypal",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      ],
                      SizedBox(height: 10.w),
                      Obx(() => controller.makingPayment.value
                          ? const Center(child: CircularProgressIndicator())
                          : Center(
                              child: CustomBtn(
                                width: Get.width / 2.3,
                                text: "Continue for Payment",
                                color: Colors.blueAccent,
                                callback: () async {
                                  // if (Platform.isAndroid) {
                                  
                                    
                                  
                                    controller.makePaypalPayment(
                                        'paypal',
                                        widget.id ?? 0,
                                        widget.bookPrice ?? '0.0',
                                        context);
                                  

                                  // }
                                },
                              ),
                            )),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      )),
      // ),
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
