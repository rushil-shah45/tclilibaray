import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/auth/registration/controllers/registration_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_text_field.dart';
import '../../../../../core/utils/constants.dart';

class RegistrationScreen extends GetView<RegistrationController> {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) {
        return Scaffold(
          body: Obx(() => controller.isGettingCountry.value
              ? const Center(child: CircularProgressIndicator())
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child:
                                Image.asset('assets/images/auth_overlayer.png'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16.w, right: 16.w, top: 80.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(
                                    'Create a new account',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30.h),
                                const CustomRichText(
                                    title: 'First Name', star: '*'),
                                CustomTextField(
                                  textEditingController:
                                      controller.firstNameController,
                                  textInputAction: TextInputAction.next,
                                  text: "Enter your first name",
                                ),
                                SizedBox(height: 5.h),
                                const CustomRichText(
                                    title: 'Last Name', star: '*'),
                                CustomTextField(
                                  textEditingController:
                                      controller.lastNameController,
                                  textInputAction: TextInputAction.next,
                                  text: 'Enter your last name',
                                ),
                                SizedBox(height: 5.h),
                                const CustomRichText(title: 'Email', star: '*'),
                                CustomTextField(
                                  textEditingController:
                                      controller.emailController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  text: 'Enter your email',
                                ),
                                SizedBox(height: 5.h),
                                const CustomRichText(
                                    title: 'Phone Number', star: '*'),
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
                                              controller.countryCode.value =
                                                  country.countryCode;
                                              controller.countryName.value =
                                                  country.name;
                                            },
                                            countryListTheme:
                                                CountryListThemeData(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(20.r),
                                                  topRight:
                                                      Radius.circular(20.r)),
                                              bottomSheetHeight:
                                                  Get.height * 0.6,
                                              backgroundColor: Colors.white,
                                              searchTextStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14.sp),
                                              inputDecoration: InputDecoration(
                                                hintText: 'Search',
                                                fillColor: Colors.white,
                                                filled: true,
                                                prefixIcon:
                                                    const Icon(Icons.search),
                                                contentPadding: EdgeInsets.only(
                                                    top: 27.h,
                                                    left: 10.w,
                                                    right: 10.w),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color:
                                                                    primaryColor,
                                                                width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.r)),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: Get.height / 17,
                                          width: Get.width / 5,
                                          decoration: BoxDecoration(
                                              color: secondaryColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.r),
                                                bottomLeft:
                                                    Radius.circular(10.r),
                                              ),
                                              border: const Border(
                                                  right: BorderSide(
                                                      color: Colors.grey,
                                                      width: 2))),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Obx(
                                                () => Text(
                                                  controller.flagIcon.value,
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              SizedBox(width: 2.w),
                                              Obx(
                                                () => Text(
                                                  '+${controller.dialCode.value}',
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: Get.width / 5.1,
                                        child: SizedBox(
                                          height: Get.height / 17,
                                          width: Get.width - (Get.width / 3.40),
                                          child: TextField(
                                            controller:
                                                controller.phoneController,
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                              hintText:
                                                  "Enter your phone number",
                                              filled: true,
                                              fillColor: secondaryColor,
                                              contentPadding: EdgeInsets.only(
                                                  top: 27.h,
                                                  left: 10.w,
                                                  right: 10.w),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: primaryColor,
                                                      width: 2),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10.r),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10.r))),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: secondaryColor),
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10.r),
                                                    bottomRight:
                                                        Radius.circular(10.r)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                const CustomRichText(
                                    title: 'Password', star: '*'),
                                Obx(
                                  () => CustomTextField(
                                    textEditingController:
                                        controller.passwordController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    text: 'Enter your password',
                                    isObscure: controller.obscureText.value,
                                    widget: GestureDetector(
                                      onTap: () {
                                        controller.toggle();
                                      },
                                      child: controller.obscureText.value
                                          ? const Icon(
                                              Icons.visibility_off,
                                              color: Colors.black87,
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              color: Colors.black87,
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                const CustomRichText(
                                    title: 'Confirm Password', star: '*'),
                                Obx(
                                  () => CustomTextField(
                                    textEditingController:
                                        controller.confirmPasswordController,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    text: 'Confirm your Password',
                                    isObscure:
                                        controller.obscureConfirmText.value,
                                    widget: GestureDetector(
                                      onTap: () {
                                        controller.toggleConfirm();
                                      },
                                      child: controller.obscureConfirmText.value
                                          ? const Icon(
                                              Icons.visibility_off,
                                              color: Colors.black87,
                                            )
                                          : const Icon(
                                              Icons.visibility,
                                              color: Colors.black87,
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.h),
                                Obx(
                                  () => controller.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : CustomBtn(
                                          height: controller.isTablet
                                              ? Get.height / 21
                                              : Get.height / 18,
                                          width: Get.width,
                                          text: 'Sign Up',
                                          size: controller.isTablet
                                              ? 13.sp
                                              : 16.sp,
                                          gradient: const LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: <Color>[
                                              primaryColor,
                                              primColor
                                            ],
                                          ),
                                          callback: () {
                                            if (controller
                                                    .passwordController.text ==
                                                controller
                                                    .confirmPasswordController
                                                    .text) {
                                              controller.registration();
                                            } else {
                                              Get.snackbar("Warning",
                                                  "Confirm password not matched");
                                            }
                                          },
                                        ),
                                ),
                                SizedBox(height: 16.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Already have an account? ',
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        'Sign In',
                                        style: TextStyle(
                                          color: customBlueColor,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: Platform.isAndroid,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 30.h),
                                      Center(
                                        child: Text(
                                          'Or, continue with',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Obx(
                                        () =>
                                        controller.isSocialLoading.value
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10.h),
                                                child: const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                              )
                                            : Visibility(
                                              visible: Platform.isAndroid,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .socialLogin('google');
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: 10.h),
                                                    padding: EdgeInsets.only(
                                                        top: 5.h, bottom: 5.h),
                                                    height: Get.height / 18,
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              26.r),
                                                      color: Colors.grey.shade200,
                                                      border: Border.all(
                                                        color: primaryColor,
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          height: 35,
                                                          width: 35,
                                                          child: Image.asset(
                                                              "assets/images/google.png"),
                                                        ),
                                                        const SizedBox(width: 8),
                                                        const Text(
                                                          "Google",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
        );
      },
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
