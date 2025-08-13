import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tcllibraryapp_develop/core/utils/constants.dart';
import 'package:tcllibraryapp_develop/core/values/k_images.dart';
import 'package:tcllibraryapp_develop/data/remote_urls.dart';
import 'package:tcllibraryapp_develop/screens/setting/controllers/settings_controller.dart';
import 'package:tcllibraryapp_develop/widgets/custom_avatar.dart';
import 'package:tcllibraryapp_develop/widgets/custom_dialog.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Obx(() => CustomAvatar(
              height: Get.height / 6.5,
              width: Get.height / 6.5,
              image: settingsController.profileImage.value.path.isEmpty &&
                      settingsController.image.isNotEmpty
                  ? '${RemoteUrls.rootUrl}/${settingsController.image}'
                  : settingsController.profileImage.value.path.isNotEmpty
                      ? settingsController.profileImage.value.path
                      : KImages.avatar,
              network: settingsController.profileImage.value.path.isEmpty &&
                  settingsController.image.isNotEmpty,
              file: settingsController.profileImage.value.path.isNotEmpty)),
          Positioned(
            bottom: settingsController.isTablet ? 0.h : 5.h,
            right: settingsController.isTablet ? 10.w : 5.w,
            child: GestureDetector(
              onTap: () {
                customDialog(
                    context,
                    'Upload Profile',
                    'Select from you want to upload your profile',
                    'Gallery',
                    'Camera', () async {
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    settingsController.setProfileImage(File(pickedFile.path));
                    Navigator.pop(context);
                  }
                }, () async {
                  final pickedFile = await ImagePicker().pickImage(
                    source: ImageSource.camera,
                    maxWidth: 1800,
                    maxHeight: 1800,
                  );
                  if (pickedFile != null) {
                    settingsController.setProfileImage(File(pickedFile.path));
                    Navigator.pop(context);
                  }
                });
              },
              child: Container(
                padding: settingsController.isTablet
                    ? const EdgeInsets.all(8)
                    : const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: redColor, borderRadius: BorderRadius.circular(90)),
                alignment: Alignment.center,
                child: const Icon(Icons.camera_alt_rounded,
                    size: 22, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
