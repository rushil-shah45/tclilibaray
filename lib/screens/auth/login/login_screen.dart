import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_text_field.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/constants.dart';
import 'controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String emailAddress = 'tclilibrary@gmail.com';

    return GetBuilder<LoginController>(builder: (controller) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Obx(() => controller.isSelected.value == 0
                        ? Image.asset('assets/images/auth_overlayer.png')
                        : controller.isSelected.value == 1
                            ? Image.asset('assets/images/autho.png')
                            : Image.asset('assets/images/institution.png')),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.w, top: 80.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                                fontSize: 22.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Center(
                            child: SvgPicture.asset(
                                "assets/images/breadcrumb_shape.svg")),
                        SizedBox(height: 70.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            controller.userList.length,
                            (index) => Expanded(
                              child: Obx(
                                () => GestureDetector(
                                  onTap: () {
                                    controller.changeSelected(index);
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 4.h),
                                    child: Container(
                                      height: Get.height / 22,
                                      decoration: BoxDecoration(
                                          color: controller.isSelected.value ==
                                                  index
                                              ? controller.isSelected.value == 0
                                                  ? primaryColor
                                                  : controller.isSelected
                                                              .value ==
                                                          1
                                                      ? authorColor
                                                      : institutionColor
                                              : Colors.white,
                                          border: Border.all(
                                              color: Colors.grey.shade300,
                                              width: 1.w),
                                          borderRadius:
                                              BorderRadius.circular(12.r)),
                                      child: Center(
                                        child: Text(
                                          controller.userList[index],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                controller.isSelected.value ==
                                                        index
                                                    ? Colors.white
                                                    : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 70.h),
                        const CustomRichText(title: 'Email'),
                        Obx(
                          () => CustomTextField(
                            textEditingController: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            text: 'Enter your email',
                            borderColor: controller.isSelected.value == 0
                                ? primaryColor
                                : controller.isSelected.value == 1
                                    ? authorColor
                                    : institutionColor,
                            color: controller.isSelected.value == 0
                                ? secondaryColor
                                : controller.isSelected.value == 1
                                    ? authorGrayColor
                                    : institutionGrayColor,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        const CustomRichText(title: 'Password'),
                        Obx(
                          () => CustomTextField(
                            textEditingController:
                                controller.passwordController,
                            textInputAction: TextInputAction.done,
                            text: 'Enter your password',
                            isObscure: controller.obscureText.value,
                            borderColor: controller.isSelected.value == 0
                                ? primaryColor
                                : controller.isSelected.value == 1
                                    ? authorColor
                                    : institutionColor,
                            color: controller.isSelected.value == 0
                                ? secondaryColor
                                : controller.isSelected.value == 1
                                    ? authorGrayColor
                                    : institutionGrayColor,
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
                        SizedBox(height: 10.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(Routes.forgotPassword);
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(
                                  fontSize: 14.sp, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Obx(
                          () => controller.isLoading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                  color: controller.isSelected.value == 0
                                      ? primaryColor
                                      : controller.isSelected.value == 1
                                          ? authorColor
                                          : institutionColor,
                                ))
                              : CustomBtn(
                                  height: controller.isTablet
                                      ? Get.height / 21
                                      : Get.height / 18,
                                  width: Get.width,
                                  text: 'Sign In',
                                  size: controller.isTablet ? 13.sp : 16.sp,
                                  gradient: controller.isSelected.value == 0
                                      ? const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                          colors: <Color>[
                                            primaryColor,
                                            primColor
                                          ],
                                        )
                                      : controller.isSelected.value == 1
                                          ? const LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: <Color>[
                                                authorColor,
                                                authorGradiantColor
                                              ],
                                            )
                                          : LinearGradient(
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                              colors: <Color>[
                                                institutionColor,
                                                institutionGradiantColor
                                              ],
                                            ),
                                  callback: () {
                                    print('object');
                                    controller.login();
                                  },
                                ),
                        ),
                        SizedBox(height: 16.h),
                        Obx(
                          () => Visibility(
                            visible: controller.isSelected.value == 1,
                            child: Column(
                              children: [
                                Text(
                                  'Are you interested in becoming an author? Kindly send us an email today indicating your interest',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    Get.back();
                                    final Uri emailLaunchUri = Uri(
                                        scheme: 'mailto', path: emailAddress);
                                    if (!await launchUrl(emailLaunchUri)) {
                                      throw Exception(
                                          'Could not launch $emailLaunchUri');
                                    }
                                  },
                                  child: Text(
                                    emailAddress,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14.sp, color: primaryColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Obx(
                          () => Visibility(
                            visible: controller.isSelected.value == 0,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Don't have an account? ",
                                      style: TextStyle(fontSize: 14.sp),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.registration);
                                      },
                                      child: Text(
                                        'Sign Up',
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
                                        () => controller.isSocialLoading.value
                                            ? Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10.h),
                                                child: const Center(
                                                    child:
                                                        CircularProgressIndicator()))
                                            : Column(
                                                children: [
                                                  Visibility(
                                                    visible: Platform.isAndroid,
                                                    child: GestureDetector(
                                                      
                                                      onTap: () {
                                                        controller.socialLogin('google');
                                                      },
                                                      child: Container(
                                                        margin:
                                                            EdgeInsets.symmetric(
                                                                vertical: 10.h),
                                                        padding: EdgeInsets.only(
                                                            top: 5.h,
                                                            bottom: 5.h),
                                                        height: Get.height / 18,
                                                        width: Get.width,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(26.r),
                                                          color: Colors
                                                              .grey.shade200,
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
                                                            const SizedBox(
                                                                width: 8),
                                                            const Text(
                                                              "Google",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  // Visibility(
                                                  //   visible: Platform.isIOS,
                                                  //   child: GestureDetector(
                                                  //     onTap: () {
                                                  //       controller.socialLogin(
                                                  //           'apple');
                                                  //     },
                                                  //     child: Container(
                                                  //       width: Get.width,
                                                  //       padding:
                                                  //           const EdgeInsets
                                                  //               .all(10),
                                                  //       decoration: BoxDecoration(
                                                  //           color: Colors.black,
                                                  //           borderRadius:
                                                  //               BorderRadius
                                                  //                   .circular(
                                                  //                       26.r)),
                                                  //       alignment:
                                                  //           Alignment.center,
                                                  //       child: const Row(
                                                  //         mainAxisAlignment:
                                                  //             MainAxisAlignment
                                                  //                 .start,
                                                  //         mainAxisSize:
                                                  //             MainAxisSize.min,
                                                  //         children: [
                                                  //           Icon(Icons.apple,
                                                  //               color: Colors
                                                  //                   .white),
                                                  //           SizedBox(width: 10),
                                                  //           Text(
                                                  //             "Sign in with Apple",
                                                  //             style: TextStyle(
                                                  //                 color: Colors
                                                  //                     .white),
                                                  //           ),
                                                  //         ],
                                                  //       ),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ],
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
