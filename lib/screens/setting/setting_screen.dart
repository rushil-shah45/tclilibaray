import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/values/k_images.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/routes/routes.dart';
import 'package:tcllibraryapp_develop/screens/setting/component/profile_view_shimmer.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_avatar.dart';
import 'package:tcllibraryapp_develop/widgets/custom_btn.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';

class SettingScreen extends StatefulWidget {
   SettingScreen({super.key,this.isMain = false});
   bool? isMain;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen>
    with SingleTickerProviderStateMixin {
  SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          leading: widget.isMain == false ? IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_new)) : const SizedBox(),

        title: Text("Account Settings",
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          return settingsController.getUserProfile();
        },
        child: Obx(
          () => settingsController.isLoading.value
              ? const ProfileViewShimmer()
              : CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.only(left: 16.w, right: 16.w),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            // Obx(
                            //   () => CustomAvatar(
                            //     height: Get.height / 6.5,
                            //     width: Get.height / 6.5,
                            //     image: settingsController
                            //                 .profileImage.value.path.isEmpty &&
                            //             settingsController
                            //                 .image.value.isNotEmpty
                            //         ? '${RemoteUrls.rootUrl}${settingsController.image.value}'
                            //         : KImages.avatar,
                            //     network: settingsController
                            //             .profileImage.value.path.isEmpty &&
                            //         settingsController.image.value.isNotEmpty,
                            //     file: settingsController
                            //         .profileImage.value.path.isNotEmpty,
                            //   ),
                            // ),
                            Obx(
                              () => Container(
                                height: Get.height / 6.5,
                                width: Get.height / 6.5,
                                decoration: BoxDecoration(
                                  border: Border.all(color: redColor.withOpacity(.5), width: 4.w),
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100.r),
                                  child: CustomImage(
                                    path:
                                        "${RemoteUrls.rootUrl}${settingsController.image.value}",
                                    height: Get.height / 6.5,
                                    width: Get.height / 6.5,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding:
                          EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name: ${settingsController.userProfileModel?.name} ${settingsController.userProfileModel?.lastName}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.profileEditMode);
                                  },
                                  child: Image.asset(
                                    "assets/images/editing.png",
                                    height: 22.h,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "Email: ${settingsController.userProfileModel?.email}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                            Visibility(
                              visible:
                                  settingsController.userProfileModel?.roleId !=
                                      "3",
                              child: Text(
                                "Phone: ${settingsController.userProfileModel?.dialCode}${settingsController.userProfileModel?.phone ?? ""}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                            Visibility(
                              visible:
                                  settingsController.userProfileModel?.roleId !=
                                      "3",
                              child: Text(
                                "Country: ${settingsController.userProfileModel?.country}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Change Password",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.passwordChange);
                              },
                              child: Image.asset("assets/images/editing.png",
                                  height: 22.h, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),

                    ///Delete Section
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverToBoxAdapter(
                        child: CustomBtn(
                          width: Get.width / 2,
                          text: 'Delete Account',
                          color: Colors.red,
                          callback: () {
                            showUserDeleteDialog(context);
                          },
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 80.h)),
                  ],
                ),
        ),
      ),
    );
  }

  void showUserDeleteDialog(context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      // curve: Curves.easeInOut,
      // alignment: Alignment.center,
      // duration: const Duration(milliseconds: 500),
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.r))),
          child: SingleChildScrollView(
            child: Container(
              height: Get.height / 3,
              width: double.infinity.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Confirm Account Deletion",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "If you DELETE this account all data will be lost permanently from our application!",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.red.shade600,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              height: Get.height / 14,
                              child: TextFormField(
                                controller: settingsController.deleteCtrl,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Please type Delete",
                                  contentPadding: EdgeInsets.only(
                                      top: 20.h, left: 10.w, right: 10.w),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomBtn(
                                  width: Get.width / 6,
                                  text: "No".tr,
                                  callback: () {
                                    Get.back();
                                  },
                                ),
                                SizedBox(width: 10.w),
                                Obx(
                                  () => settingsController
                                          .isDeleteBtnLoading.value
                                      ? SizedBox(
                                          width: Get.width / 6,
                                          child: const Center(
                                              child:
                                                  CircularProgressIndicator()))
                                      : CustomBtn(
                                          width: Get.width / 6,
                                          text: "Yes".tr,
                                          color: Colors.red,
                                          callback: () {
                                            settingsController.deleteAccount();
                                          },
                                        ),
                                ),
                              ],
                            ),
                            SizedBox(height: 0.h),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      // animationType: DialogTransitionType.scale,
    );
  }
}
