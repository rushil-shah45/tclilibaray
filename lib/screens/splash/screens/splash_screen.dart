import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/animation/delayed_animation.dart';
import '../../../animation/wave_clipper.dart';
import '../../../core/utils/constants.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : DelayedAnimation(
                delay: 600,
                child: SizedBox(
                  height: Get.height,
                  child: Stack(
                    children: [
                      ClipPath(
                        clipper: WaveClipper(),
                        child: Container(
                          color: primaryColor,
                          height: Get.height / 2,
                        ),
                      ),
                      Positioned(
                          top: Get.height / 2.5,
                          left: Get.width / 2 - 70.w,
                          child: SizedBox(
                              height: 150.h,
                              width: 150.h,
                              child: Image.asset('assets/images/logo.png'))),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
