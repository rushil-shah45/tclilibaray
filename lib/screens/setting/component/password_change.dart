import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/widgets/custom_rich_text.dart';
import 'package:tcllibraryapp_develop/widgets/custom_textfield.dart';

class PasswordChangeScreen extends StatefulWidget {
  const PasswordChangeScreen({super.key});

  @override
  State<PasswordChangeScreen> createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen>
    with SingleTickerProviderStateMixin {
  SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Get.back();
            }),
        title: Text("Change Password",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          ///Password Section
          SliverPadding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            sliver: SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomRichText(title: 'Current Password'),
                    Obx(
                      () => CustomTextField(
                        controller: settingsController.currentPassCtrl,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: settingsController.obscureText.value,
                        hintText: "Current Password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            settingsController.toggle();
                          },
                          child: settingsController.obscureText.value
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
                    const CustomRichText(title: "New Password"),
                    Obx(
                      () => CustomTextField(
                        controller: settingsController.newPassCtrl,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: settingsController.obscureNewText.value,
                        hintText: "New Password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            settingsController.toggleNew();
                          },
                          child: settingsController.obscureNewText.value
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
                    const CustomRichText(title: "Confirm Password"),
                    Obx(
                      () => CustomTextField(
                        controller: settingsController.confirmPassCtrl,
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: settingsController.obscureConfirmText.value,
                        hintText: "Confirm Password",
                        suffixIcon: GestureDetector(
                          onTap: () {
                            settingsController.toggleConfirm();
                          },
                          child: settingsController.obscureConfirmText.value
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
                    Obx(
                      () => settingsController.passIsLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : Center(
                              child: CustomBtn(
                                width: Get.width / 6,
                                text: 'Save',
                                callback: () {
                                  settingsController.updatePassword();
                                },
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
