import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/components/billing_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/components/coutry_bottomsheet.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/components/custom_required_text.dart';
import 'package:tcllibraryapp_develop/screens/my_subscription/controller/my_subscription_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

class BillingDetails extends GetView<MySubscriptionController> {
  const BillingDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
          ),
        ),
        title: Text(
          "Billing Details",
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Obx(
            () => controller.isLoading.value
                ? const BillingShimmer()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomRequiredText(title: 'Name', star: "*"),
                      CustomTextField(
                        controller: controller.nameController,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        hintText: "Enter your name",
                      ),
                      SizedBox(height: 5.h),
                      const CustomRequiredText(title: 'Email', star: "*"),
                      CustomTextField(
                        controller: controller.emailController,
                        textInputType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        hintText: "Enter your email",
                      ),
                      SizedBox(height: 5.h),
                      const CustomRequiredText(title: 'Phone', star: "*"),
                      SizedBox(
                        height: controller.isTablet
                            ? Get.height / 19
                            : Get.height / 17,
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
                                height: controller.isTablet
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
                                    SizedBox(
                                        width: controller.isTablet ? 7.w : 2.w),
                                    Obx(
                                      () => Text(
                                        '+${controller.dialCode.value}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: controller.isTablet
                                              ? 8.sp
                                              : 15.sp,
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
                                height: controller.isTablet
                                    ? Get.height / 19
                                    : Get.height / 17,
                                width: Get.width - (Get.width / 3.45),
                                child: TextField(
                                  controller: controller.phoneController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
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
                      SizedBox(height: 10.h),
                      const CustomRequiredText(title: 'User Type', star: "*"),
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
                            borderRadius: BorderRadius.circular(10.r),
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            value: controller.userItems.value.contains(
                                    controller.userType.value.capitalizeFirst)
                                ? controller.userType.value.capitalizeFirst
                                : null,
                            isExpanded: true,
                            iconEnabledColor: Colors.grey.shade400,
                            underline: const SizedBox(),
                            hint: const Text("Select one"),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items:
                                controller.userItems.value.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(
                                  items,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:
                                        controller.isTablet ? 10.sp : 14.sp,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              controller.changeSizeItemValue(newValue!);
                            },
                          );
                        }),
                      ),
                      SizedBox(height: 10.h),
                      const CustomRequiredText(title: 'Address', star: "*"),
                      CustomTextField(
                        controller: controller.addressController,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        hintText: "Enter your address",
                      ),
                      SizedBox(height: 10.h),
                      const CustomRequiredText(
                          title: 'Choose your Country', star: "*"),
                      SizedBox(
                        height: Get.height / 15,
                        child: GestureDetector(
                          onTap: () {
                            customBottomSheet(
                                context,
                                CustomCountryBottomSheet(
                                  controller: controller,
                                ));
                          },
                          child: AbsorbPointer(
                            child: CustomTextField(
                              controller: controller.selectedCountryOption,
                              textInputAction: TextInputAction.done,
                              hintText: "Select a Country",
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
                      SizedBox(height: 10.h),
                      const CustomRequiredText(title: 'State', star: "*"),
                      CustomTextField(
                        controller: controller.stateController,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        hintText: "Enter your state",
                      ),
                      SizedBox(height: 7.h),
                      const CustomRequiredText(title: 'City', star: "*"),
                      CustomTextField(
                        controller: controller.cityController,
                        textInputType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        hintText: "Enter your city",
                      ),
                      SizedBox(height: 7.h),
                      const CustomRequiredText(title: 'Zip Code', star: "*"),
                      CustomTextField(
                        controller: controller.zipController,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        hintText: "Enter your zip code",
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomBtn(
                            width: Get.width / 6,
                            text: "Cancel",
                            color: Colors.red,
                            callback: () {
                              Get.back();
                            },
                          ),
                          SizedBox(width: 10.w),
                          Obx(
                            () => controller.isLoading.value
                                ? SizedBox(
                                    width: Get.width / 2.5,
                                    child: const Center(
                                        child: CircularProgressIndicator()))
                                : CustomBtn(
                                    width: Get.width / 2.8,
                                    text: "Save billing details",
                                    callback: () {
                                      controller
                                          .billingInformationPost(context);
                                    },
                                  ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
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
}
