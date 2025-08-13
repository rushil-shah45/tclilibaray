import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tcllibraryapp_develop/core/utils/custom_image.dart';
import 'package:tcllibraryapp_develop/screens/main/controller/main_controller.dart';
import '../../../core/utils/constants.dart';
import '../../setting/repository/setting_repository.dart';

class MyBottomNavigationBar extends StatelessWidget {
  MyBottomNavigationBar(
      {Key? key,
      required this.controller,
      required this.pageController,
      required this.pageIndex})
      : super(key: key);
  final int pageIndex;
  final PageController pageController;
  final MainController controller;

  final imageList = <String>[
    "assets/images/ticket.png",
    "assets/images/book.png",
    "assets/images/favorite.png",
    "assets/images/setting.png",
    "assets/images/decline.png",
  ];

  final titleList = <String>[
    "Ticket",
    "My Books",
    "Declined",
    "Settings",
    "All Books",
    "Favourite",
    "Issued"
  ];

  @override
  Widget build(BuildContext context) {
    Get.lazyPut<SettingsRepository>(() => SettingRepositoryImpl(
        remoteDataSource: Get.find(), localDataSource: Get.find()));

    return AnimatedBottomNavigationBar.builder(
      itemCount: imageList.length - 1,
      height: 60,
      backgroundColor: Colors.white,
      splashColor: redColor,
      notchMargin: 7,
      notchSmoothness: NotchSmoothness.sharpEdge,
      gapLocation: GapLocation.center,
      leftCornerRadius: 0,
      rightCornerRadius: 0,
      activeIndex: pageIndex == 0 ? -1 : pageIndex - 1,
      tabBuilder: (int index, bool isActive) {
        final color = isActive ? primaryColor : blackColor;
        return Obx(
          () => controller.isLoading.value
              ? const SizedBox()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomImage(
                      path: controller.userProfileModel?.roleId != 3
                          ? index == 2
                              ? controller.userProfileModel?.roleId == 1
                                  ? imageList[index]
                                  : imageList[4]
                              : imageList[index]
                          : index == 2
                              ? imageList[2]
                              : imageList[index],
                      height: 22,
                      color: color,
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        controller.userProfileModel?.roleId != 3
                            ? controller.userProfileModel?.roleId == 1
                                ? index == 1
                                    ? titleList[4]
                                    : index == 2
                                        ? titleList[5]
                                        : titleList[index]
                                : titleList[index]
                            : index == 1
                                ? titleList[6]
                                : index == 2
                                    ? titleList[5]
                                    : titleList[index],
                        maxLines: 1,
                        style: TextStyle(color: color, fontSize: 14),
                      ),
                    )
                  ],
                ),
        );
      },
      onTap: (index) {
        controller.changePage(index + 1);
        pageController.animateToPage(
          index + 1,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      },
    );
  }
}
