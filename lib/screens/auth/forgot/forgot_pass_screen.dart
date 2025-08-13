import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/utils/utils.dart';
import 'package:tcllibraryapp_develop/screens/auth/forgot/controller/forgot_pass_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import '../../../../widgets/custom_text_field.dart';

class ForgotPasswordScreen extends GetView<ForgotPasswordController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordController>(builder: (controller) {
      return Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Image.asset('assets/images/auth_overlayer.png')),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 130.h),
                        Text(
                          'Forgot Password',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: Get.height / 4),
                        CustomTextField(
                          textEditingController: controller.emailController,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          text: 'Enter your Email',
                        ),
                        SizedBox(height: 5.h),
                        Obx(
                          () => controller.isLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : CustomBtn(
                                  width: Get.width / 2.15,
                                  text: 'Send reset password link',
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: <Color>[primaryColor, primColor],
                                  ),
                                  callback: () {
                                    Utils.closeKeyBoard(context);
                                    controller.forgotPassword();
                                  },
                                ),
                        ),
                        SizedBox(height: 5.h),
                        CustomBtn(
                          width: Get.width / 2.15,
                          text: 'Back to login page',
                          color2: Colors.black,
                          color: Colors.white,
                          callback: () {
                            Get.back();
                          },
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
